//
//  setting.m
//  浩博新闻
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "setting.h"

@implementation setting

+ (instancetype)shared
{
    static setting *set;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [[setting alloc] init];
    });
    return set;
}

- (void)saveSwitchValue:(NSInteger)value
{
    _switchValue = value;
}

- (void)saveValue:(NSString *)string
{
    _value = string;
}

@end
