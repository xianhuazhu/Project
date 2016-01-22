//
//  BigScrollView.m
//  TableView复用
//
//  Created by jinchao on 15/12/18.
//  Copyright © 2015年 青云信息技术有限公司. All rights reserved.
//

#import "BigScrollView.h"
#import "Header.h"

@interface BigScrollView()

@end
@implementation BigScrollView
- (instancetype)initBigScroll
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 30, kScreenW, kScreenH-52);
        self.contentSize = CGSizeMake(kScreenW*3, 0);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

    }
    return self;
}

@end
