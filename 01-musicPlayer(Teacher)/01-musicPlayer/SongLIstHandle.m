//
//  SongLIstHandle.m
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SongLIstHandle.h"
#import "SongMode.h"
@implementation SongLIstHandle
+(instancetype)sharedHandel{
 static dispatch_once_t once;
 static SongLIstHandle *handel;
    dispatch_once(&once, ^{
        handel=[SongLIstHandle new];
    });
    return handel;
}

//将播放列表plsit 转换成mode
-(NSMutableArray *)songArr{
    if (_songArr) {
        return _songArr;
    }
    _songArr=[NSMutableArray array];
    
    NSArray *arr=[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SongsInfos" ofType:@"plist"]];
    
    for (NSDictionary *temp in arr) {
      //字典转换成模型，然后存在数组里
      // SongMode *mode=[[SongMode alloc] initWithDic:temp]
        [_songArr addObject:[[SongMode alloc] initWithDic:temp]];
    }
    return _songArr;
}

@end
