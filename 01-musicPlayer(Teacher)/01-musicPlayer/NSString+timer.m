//
//  NSString+timer.m
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSString+timer.h"

@implementation NSString (timer)
-(NSString *)valueExchange:(NSTimeInterval)timer{
    int minutes=(float)timer/60;
    int second=(int)timer%60;
    NSString *strMinute;
    if (minutes>=10) {
        strMinute=[NSString stringWithFormat:@"%d",minutes];
    }else{
        strMinute=[NSString stringWithFormat:@"0%d",minutes];
    }
    NSString *strSecond;
    if (second>=10) {
        strSecond=[NSString  stringWithFormat:@"%d",second];
    }else{
        strSecond=[NSString  stringWithFormat:@"0%d",second];
    }
    return [NSString stringWithFormat:@"%@:%@",strMinute,strSecond];
}


@end
