//
//  threePictureTableViewCell.h
//  1-新闻客户端
//
//  Created by qingyun on 15/12/31.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class newsModels;
@interface threePictureTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewTow;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewThree;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSDictionary *totalDict;

@end
