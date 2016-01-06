//
//  SongListHandle.m
//  音乐播放器
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "SongListHandle.h"
#import "songData.h"

@implementation SongListHandle

+ (instancetype)sharedHandle
{
    static dispatch_once_t once;
    static SongListHandle *handle;
    dispatch_once(&once, ^{
        handle = [SongListHandle new];
    });
    return handle;
}

//将播放列表plist转换成mode
- (NSMutableArray *)songArr
{
    if (_songArr) {
        return _songArr;
    }
    
    _songArr = [NSMutableArray array];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SongsInfos" ofType:@"plist"]];
    
    for (NSDictionary *temp in arr) {
        //字典转换成模型，然后存在数组里
        [_songArr addObject:[[songData alloc] initWithDictionary:temp]];
    }
         return _songArr;
}

@end
