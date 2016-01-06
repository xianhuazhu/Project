//
//  SongLIstHandle.h
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//  模型存在数组里边

#import <Foundation/Foundation.h>

@interface SongLIstHandle : NSObject
//歌曲列表;
@property(nonatomic,strong)NSMutableArray *songArr;
+(instancetype)sharedHandel;
@end
