//
//  NSString+timer.m
//  音乐播放器
//
//  Created by qingyun on 16/1/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "NSString+timer.h"

@implementation NSString (timer)

- (NSString *)valueExchange:(NSTimeInterval)timer
{
    int minutes = (float)timer/60;
    int second = (int)timer%60;
    
    NSString *strMinute;
    if (minutes >= 10) {
        strMinute = [NSString stringWithFormat:@"%d",minutes];
    }else{
        strMinute = [NSString stringWithFormat:@"0%d",minutes];
        
    }
    
    NSString *strSecond;
    if (second) {
        strSecond = [NSString stringWithFormat:@"%d",second];
    }else{
        strSecond = [NSString stringWithFormat:@"%d",second];
    }
    
    return [NSString stringWithFormat:@"%@:%@",strMinute,strSecond];
}

@end
