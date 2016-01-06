//
//  SongListHandle.h
//  音乐播放器
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//模型存在数组里面

#import <Foundation/Foundation.h>

@interface SongListHandle : NSObject

//歌曲列表
@property (nonatomic, strong) NSMutableArray *songArr;
+ (instancetype)sharedHandle;

@end
