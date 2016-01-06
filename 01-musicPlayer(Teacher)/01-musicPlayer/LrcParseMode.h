//
//  LrcParseMode.h
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SongMode;
@interface LrcParseMode : NSObject
@property(nonatomic,strong)NSArray *keyArr;
@property(nonatomic,strong)NSMutableDictionary *lrcDic;
+(instancetype)initWithSongMode:(SongMode *)mode;
@end
