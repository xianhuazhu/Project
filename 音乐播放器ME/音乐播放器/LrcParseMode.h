//
//  LrcParseMode.h
//  音乐播放器
//
//  Created by qingyun on 16/1/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class songData;
@interface LrcParseMode : NSObject
//需要排序后的时间戳，解析得到的歌词和时间放进一个字典
@property (nonatomic, strong) NSArray *keyArr;
@property (nonatomic, strong) NSMutableDictionary *lrcDic;

+ (instancetype)initWithSongMode:(songData *)mode;

@end
