//
//  bigImageTableViewCell.h
//  1-新闻客户端
//
//  Created by qingyun on 16/1/14.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bigImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSDictionary *totalDic;

@end
