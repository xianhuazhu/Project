//
//  SongMode.h
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
// 歌曲字典转换成模型

#import <Foundation/Foundation.h>
@interface SongMode : NSObject
@property(nonatomic,strong)NSString *kName;
@property(nonatomic,strong)NSString *kType;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
