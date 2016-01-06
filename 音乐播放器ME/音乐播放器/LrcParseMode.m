//
//  LrcParseMode.m
//  音乐播放器
//
//  Created by qingyun on 16/1/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "LrcParseMode.h"
#import "songData.h"

@implementation LrcParseMode

- (void)lrcParseFromArry:(NSArray *)arr
{
    for (NSString *lrcStr in arr) {
        //以[:]拆分有效歌词
        NSArray *keyArr = [lrcStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[:]"]];
        if (keyArr.count >= 4) {
            NSString *mintes = keyArr[1];
            if ([mintes hasPrefix:@"0"]) {
                NSString *second = keyArr[2];
                NSString *value = keyArr[3];
                float key = mintes.intValue*60 + second.floatValue;
                //时间和value存在字典里边
                [self.lrcDic setObject:value forKey:@(key)];
            }
        }
    }
    //排序时间戳
    self.keyArr = [[self.lrcDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
}

- (instancetype)initWithSongMode:(songData *)mode
{
    if (self = [super init]) {
        //解析歌词
        //取出歌词
        NSString *lrcStr = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:mode.kName ofType:@"lrc"] encoding:NSUTF8StringEncoding error:nil];
        //歌词以/n拆分
        NSArray *keyLrc = [lrcStr componentsSeparatedByString:@"\n"];
        //初始化字典
        self.lrcDic = [NSMutableDictionary dictionary];
        [self lrcParseFromArry:keyLrc];
    }
    return self;
}

+ (instancetype)initWithSongMode:(songData *)mode
{
    return [[LrcParseMode alloc] initWithSongMode:mode];
}

@end
