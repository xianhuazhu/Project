//
//  SongMode.m
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SongMode.h"

@implementation SongMode
-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
      //kvc赋值
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


@end
