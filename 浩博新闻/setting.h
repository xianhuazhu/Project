//
//  setting.h
//  浩博新闻
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface setting : NSObject
@property (nonatomic, assign) NSInteger switchValue;
@property (nonatomic, strong) NSString *value;

+ (instancetype)shared;

- (void)saveSwitchValue:(NSInteger)value;
- (void)saveValue:(NSString *)string;

@end
