//
//  onePictureTableViewCell.h
//  1-新闻客户端
//
//  Created by qingyun on 15/12/31.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class newsModels;

@interface onePictureTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *update;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSDictionary *totalDict;

@end
