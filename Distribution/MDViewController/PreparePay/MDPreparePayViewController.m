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

@interface MDPreparePayViewController ()

@end

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
    
    //test よう
//    [MDCurrentPackage getInstance].package_id = @"21";
//    [MDCurrentPackage getInstance].package_number = @"1234567890";
    [_preparePayView initPackageNumber:[MDCurrentPackage getInstance].package_number];
    
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
    [self openMenu];
}

-(void) requestPersonPushed {
    MDNameSettingViewController *nameSettingViewController = [[MDNameSettingViewController alloc]init];
    [self.navigationController pushViewController:nameSettingViewController animated:YES];
}

-(void) phoneNumberPushed{
    MDPhoneViewController *phoneViewController = [[MDPhoneViewController alloc]init];
    [self.navigationController pushViewController:phoneViewController animated:YES];
}

-(void) postData {
    //check
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)openMenu
{
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"キャンセル"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"写真を撮る", @"カメラロール",nil];
    [myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            isCamera = YES;
            [self takePhoto];
            break;
        case 1:  //打开本地相册
            isCamera = NO;
            [self LocalPhoto];
            break;
    }
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
    [SVProgressHUD show];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if(isCamera) {
//        //先把图片转成NSData
            if (UIImagePNGRepresentation(image) == nil)
            {
                data = UIImageJPEGRepresentation(image, 0.3);
            }
            else
            {
                data = UIImagePNGRepresentation(image);
            }
            UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
            
        }
        
        CGSize imagesize = image.size;
        imagesize.height = imagesize.height/10;
        imagesize.width = imagesize.width/10;
        image = [self imageWithImage:image scaledToSize:imagesize];
        
        imagesize = image.size;
        
        [_preparePayView setBoxImage:image];
        
        //upload
        
        [[MDAPI sharedAPI] uploadImageWithHash:[MDUser getInstance].userHash
                                     packageId:[MDCurrentPackage getInstance].package_id
                                         image:image
                                    OnComplete:^(MKNetworkOperation *completeOperation){
                                        if([[completeOperation responseJSON][@"code"] integerValue] == 0){
                                            [picker dismissViewControllerAnimated:YES completion:nil];
                                        }
                                        [SVProgressHUD dismiss];
                                    }onError:^(MKNetworkOperation *completeOperation, NSError *error){
                                        NSLog(@"%@",error);
                                        [picker dismissViewControllerAnimated:YES completion:nil];
                                        [SVProgressHUD dismiss];
                                    }];
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
