//
//  songData.h
//  音乐播放器
//
//  Created by qingyun on 16/1/4.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface songData : NSObject

@property (nonatomic, strong) NSString *kName;
@property (nonatomic, strong) NSString *kType;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
