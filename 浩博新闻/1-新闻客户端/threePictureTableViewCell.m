//
//  threePictureTableViewCell.m
//  1-新闻客户端
//
//  Created by qingyun on 15/12/31.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "threePictureTableViewCell.h"
#import "Header.h"

@implementation threePictureTableViewCell
- (void)setArr:(NSMutableArray *)arr
{
    _arr = arr;
    [_imgViewOne sd_setImageWithURL:[NSURL URLWithString:arr[0][@"pic"]]];
    [_imgViewTow sd_setImageWithURL:[NSURL URLWithString:arr[1][@"pic"]]];
    [_imgViewThree sd_setImageWithURL:[NSURL URLWithString:arr[2][@"pic"]]];
}

- (void)setTotalDict:(NSDictionary *)totalDict
{
    _totalDict = totalDict;
    if (_totalDict[@"total"] == nil) {
        self.total.text = [NSString stringWithFormat:@"0评论"];
    }else{
        self.total.text = [NSString stringWithFormat:@"%@条评论",_totalDict[@"total"]];
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
