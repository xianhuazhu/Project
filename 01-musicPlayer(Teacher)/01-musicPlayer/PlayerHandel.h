//
//  PlayerHandel.h
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//播放器控制类

#import <Foundation/Foundation.h>
@class LrcParseMode;
typedef enum:NSInteger{
    sequenceLoop,  //循环播放
    singleLoop,    //单曲播放
    Random,        //随机播放
 }PlayeMode;

@protocol PlayerHandelPRo <NSObject>
//更新播放时间的UI
-(void)updateProgressForTime:(NSTimeInterval)time;
//选中哪行歌词
-(void)updateLrcselectIndex:(NSInteger)index;
//重新刷新歌词
-(void)notifactionreSetUpDataLrc;
@end



@interface PlayerHandel : NSObject
//歌词解析模型
@property(nonatomic,strong,readonly)LrcParseMode *lrcMode;
//播放模式
@property(nonatomic,assign)PlayeMode playMode;
//当前播放时长
@property(nonatomic,assign)NSTimeInterval currentTime;
//音频总时长
@property(nonatomic,readonly)NSTimeInterval duration;
//判断播放状态
@property(nonatomic,readonly)BOOL isPlaying;
//设置暂停或者播放 YES 开始播放；NO 暂停
@property(nonatomic,assign)BOOL playOrPause;
//当前播放音乐的下标
@property(nonatomic,assign)NSInteger playIndex;
//当前音量
@property(nonatomic,assign)float volume;
//设置代理
@property(nonatomic,assign)id<PlayerHandelPRo>delegate;
//获取歌曲名称
@property(nonatomic,readonly,strong)NSString *songTitle;

+(instancetype)shareHandel;
//下一曲
-(void)nextSong;
//上一首
-(void)PrevousSong;
@end
