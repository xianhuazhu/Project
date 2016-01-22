//
//  bigImageTableViewCell.m
//  1-新闻客户端
//
//  Created by qingyun on 16/1/14.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "bigImageTableViewCell.h"
#import "Header.h"

@implementation bigImageTableViewCell

- (void)setDict:(NSDictionary *)dict
{
    self.title.text = dict[@"title"];
    self.source.text = dict[@"source"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"kpic"]]];
}

- (void)setTotalDic:(NSDictionary *)totalDic
{
    _totalDic = totalDic;
    if (_totalDic[@"total"] == nil) {
        self.total.text = [NSString stringWithFormat:@"0评论"];
    }else{
        self.total.text = [NSString stringWithFormat:@"%@条评论",_totalDic[@"total"]];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
