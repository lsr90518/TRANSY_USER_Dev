//
//  MDPreparePayViewController.m
//  Distribution
//
//  Created by Lsr on 3/31/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPreparePayViewController.h"
#import "MDDeliveryViewController.h"
#import <SVProgressHUD.h>
#import "MDRequestViewController.h"
#import "MDNameSettingViewController.h"
#import "MDPhoneNumberSettingViewController.h"
#import "MDPhoneViewController.h"
#import "MDPaymentViewController.h"
#import "MDRequestViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MDPreparePayViewController ()

@end

static CGRect oldframe;
@implementation MDPreparePayViewController
{
    UIActionSheet *myActionSheet;
    NSString* filePath;
    BOOL isCamera;
}
-(void)loadView {
    [super loadView];
    
    _preparePayView = [[MDPreparePayView alloc]initWithFrame:self.view.frame];
    _preparePayView.delegate = self;
    [self.view addSubview:_preparePayView];
    
    self.navigationController.delegate = self;
    
    //test よう
    //    [MDCurrentPackage getInstance].package_id = @"21";
    //    [MDCurrentPackage getInstance].package_number = @"1234567890";
    [_preparePayView initPackageNumber:[MDCurrentPackage getInstance].package_number];
    
    myActionSheet.delegate = self;
    
    //add right button item
    [self initNavigationBar];
    
}

-(void)initNavigationBar {
    self.navigationItem.title = @"準備と支払い方法";
    //add right button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    //    [_preparePayView updateData];
}


#pragma PreparePayView
-(void)backButtonPushed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) cameraButtonTouched {
    //open camera or カメラロール
    [self openCameraMenu];
}

-(void) updateImagePushed{
    [self openUpdateMenu];
}

-(void) requestPersonPushed {
    [MDUtil makeAlertWithTitle:@"変更できません" message:@"名前の設定を変更するには設定から変更をお願い致します。" done:@"OK" viewController:self];
}

-(void) phoneNumberPushed{
    [MDUtil makeAlertWithTitle:@"変更できません" message:@"電話番号の設定を変更するには設定から変更をお願い致します。" done:@"OK" viewController:self];
}

-(void) postData {
    if(_packageImage == nil){
        [MDUtil makeAlertWithTitle:@"写真が必須です" message:@"荷物の写真を登録してください。" done:@"OK" viewController:self];
    } else if(![_preparePayView isChecked]){
        [MDUtil makeAlertWithTitle:@"利用規約確認" message:@"利用規約とプライバシーポリシーの確認をお願いします。" done:@"OK" viewController:self];
    } else {
        [SVProgressHUD show];
        MDUser *user = [MDUser getInstance];
        [user initDataClear];
        
        [[MDAPI sharedAPI] orderWithHash:user.userHash
                               packageId:[MDCurrentPackage getInstance].package_id
                                   image:_packageImage
                              OnComplete:^(MKNetworkOperation *completeOperation){
                                  if([[completeOperation responseJSON][@"code"] integerValue] == 0){
                                      [MDCurrentPackage getInstance].status = @"2";
                                      [self dismissViewControllerAnimated:YES completion:nil];
                                  }else{
                                      [MDUtil makeAlertWithTitle:@"エラー" message:@"支払い方法が登録されていません。" done:@"OK" viewController:self];
                                      
                                  }
                                  [SVProgressHUD dismiss];
                              }onError:^(MKNetworkOperation *completeOperation, NSError *error){
                                  NSLog(@"%@",error);
                                  [SVProgressHUD dismiss];
                              }];
    }
}


//かかみん ここ
-(void) paymentButtonPushed {
    MDPaymentViewController *paymentViewController = [[MDPaymentViewController alloc] init];
    [self.navigationController pushViewController:paymentViewController animated:YES];
}
-(void) showCardIO {
    MDPaymentViewController *paymentViewController = [[MDPaymentViewController alloc] initWithCardIO];
    [self.navigationController pushViewController:paymentViewController animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    MDSelect *pay = (MDSelect *)[_preparePayView.scrollView viewWithTag:paymentSelect];
    if(pay){
        pay.selectLabel.text = [MDUtil getPaymentSelectLabel];
    }
}


-(void)openCameraMenu {
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"キャンセル"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"写真を撮る", @"カメラロール",nil];
    [myActionSheet showInView:self.view];
}

-(void) openUpdateMenu {
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"キャンセル"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"写真を撮る", @"カメラロール", @"写真を拡大", nil];
    [myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:  //打开照相机拍照
            isCamera = YES;
            [self takePhoto];
            break;
        case 1:  //打开本地相册
            isCamera = NO;
            [self LocalPhoto];
            break;
        case 2:
            if([[actionSheet buttonTitleAtIndex:2] isEqualToString:@"写真を拡大"]){
                [self expendImage];
            }
            break;
        default:
            break;
    }
}

-(void) expendImage{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImage:[_preparePayView getUploadedImage].image];
    
    
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    
    [backgroundView addSubview:imageView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
        imageView.center = backgroundView.center;
        [self.view addSubview:backgroundView];
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"カメラがない");
    }
}
//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSData *data;
        //transfer image to data
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 0.5);
        } else {
            data = UIImagePNGRepresentation(image);
        }
        
        if(isCamera) {
            UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
        }
        
        
        CGSize imagesize = image.size;
        imagesize.height = imagesize.height/5;
        imagesize.width = imagesize.width/5;
        image = [self imageWithImage:image scaledToSize:imagesize];
        
        imagesize = image.size;
        
        [_preparePayView setBoxImage:image];
        _packageImage = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



@end
