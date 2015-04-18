//
//  MDRequestTableView.m
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestTableView.h"
#import "MDRequestTableViewCell.h"

@implementation MDRequestTableView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //delegate
        self.delegate = self;
        self.dataSource = self;
        self.separatorColor = [UIColor whiteColor];
    }
    
    return self;
}

#pragma mark - TableView
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDRequestTableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[MDRequestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(MDRequestTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [cell initCellWithData:_tableDataArray[indexPath.row]];
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if ([self.tableDelegate respondsToSelector:@selector(tableView:selectCellWithData:)]) {
//        [self.tableDelegate tableView:self selectCellWithData:_tableDataArray[indexPath.row]];
//    }
//}


@end
