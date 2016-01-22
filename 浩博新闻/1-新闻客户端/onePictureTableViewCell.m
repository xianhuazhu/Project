//
//  onePictureTableViewCell.m
//  1-新闻客户端
//
//  Created by qingyun on 15/12/31.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "onePictureTableViewCell.h"
#import "Header.h"

@implementation onePictureTableViewCell

- (void)setDict:(NSDictionary *)dict
{
        self.label.text = dict[@"title"];
        self.update.text = dict[@"intro"];
        self.source.text = dict[@"source"];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"kpic"]]];
}

- (void)setTotalDict:(NSDictionary *)totalDict
{
    _totalDict = totalDict;
    if (_totalDict[@"total"] == nil) {
        self.total.text = [NSString stringWithFormat:@"0评论"];
    }else{
        self.total.text = [NSString stringWithFormat:@"%@条评论",totalDict[@"total"]];
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
