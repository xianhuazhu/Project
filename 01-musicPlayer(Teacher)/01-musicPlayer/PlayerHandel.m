//
//  PlayerHandel.m
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//  

#import "PlayerHandel.h"
#import <AVFoundation/AVFoundation.h>
#import "SongLIstHandle.h"
#import "SongMode.h"
#import "LrcParseMode.h"


@interface PlayerHandel ()<AVAudioPlayerDelegate>
//播放器
@property(nonatomic,strong)AVAudioPlayer *player;
//定时器，更新进度条，更新歌词
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation PlayerHandel
@synthesize currentTime=_currentTime;
@synthesize volume=_volume;

-(void)setAuridoBackGroudSeesion{
  //1.获取会话单例对象
    AVAudioSession *session=[AVAudioSession sharedInstance];
  //2.设置策略
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
   //3.启动会话
    [session setActive:YES error:nil];
}

//获取当前播放的时间
-(void)updateTime{
//    self.currentTime 回调当前播放时间
    if (_delegate) {
        [self.delegate updateProgressForTime:self.currentTime];
        
       //当前应该选中哪行
        NSInteger index=0;
        
        NSTimeInterval tmepCurrent=self.currentTime;
        for (NSNumber *nuber in _lrcMode.keyArr) {
            if (nuber.floatValue<=tmepCurrent) {
                index+=1;
            }else{
                //跳出循环
                break;
            }
        }
        //回调当前选中哪行歌词
        if (index!=0) {
            [self.delegate updateLrcselectIndex:index-1];
        }
    }
}

-(NSTimer *)timer{
    if (_timer) {
        return _timer;
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    return _timer;
}

-(NSString *)songTitle{
    SongMode *mode=[SongLIstHandle sharedHandel].songArr[_playIndex];
    return mode.kName;
}

//重写播放器音乐列表下标
-(void)setPlayIndex:(NSInteger)playIndex{
  if (playIndex!=-1) {
     if (_playIndex==playIndex) {
         return;
     }
    _playIndex=playIndex;
    //初始化音乐播放器
    //1.取出模型
    SongMode *mode=[SongLIstHandle sharedHandel].songArr[playIndex];
    //解析歌词
    _lrcMode=[LrcParseMode initWithSongMode:mode];
    
    
      
    NSURL *songUrl=[[NSBundle mainBundle]URLForResource:mode.kName withExtension:mode.kType];
    
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:songUrl error:nil];
    //设置音量
    _player.volume=self.volume;
    //设置委托
      _player.delegate=self;
    //准备开始播放
    [_player prepareToPlay];
      
    //开始播放
    self.playOrPause=YES;
      
    //更新歌词
      
      if (_delegate) {
          [self.delegate notifactionreSetUpDataLrc];
      }
  }else{
     _playIndex=playIndex;
  }
 
}
//重写delegate
-(void)setDelegate:(id<PlayerHandelPRo>)delegate{
    if (delegate) {
        //启动
        self.timer.fireDate=[NSDate distantPast];
    }else{
        //暂停
        self.timer.fireDate=[NSDate distantFuture];
    }
    _delegate=delegate;
}



//重写playOrpause set方法
-(void)setPlayOrPause:(BOOL)playOrPause{

    if (playOrPause) {
        [self.player play];
    }else{
        [self.player pause];
    }
    _playOrPause=playOrPause;
}

//判断当前播放状态
-(BOOL)isPlaying{
    return self.player.isPlaying;
}


//判断当前音频总长度
-(NSTimeInterval)duration{
    return self.player.duration;
}

//重写set方法改变当前播放时长
-(void)setCurrentTime:(NSTimeInterval)currentTime{
    if (_currentTime==currentTime) {
        return;
    }
    //更改播放器的当前播放进度
    self.player.currentTime=currentTime;
    _currentTime=currentTime;
}
//获取当前时长
-(NSTimeInterval)currentTime{
    return self.player.currentTime;
}


//改变当前音量
-(void)setVolume:(float)volume{
    if(_volume==volume){
        return;
    }
    self.player.volume=volume;
    _volume=volume;
}
//获取当前音量
-(float)volume{
    
    return _volume;
}

//下一首
-(void)nextSong{
    if(_playIndex<[SongLIstHandle sharedHandel].songArr.count-1){
        self.playIndex+=1;
    }else{
        self.playIndex=0;
    }
}
//上一曲
-(void)PrevousSong{
    if (_playIndex>0) {
        self.playIndex-=1;
    }else{
        self.playIndex=[SongLIstHandle sharedHandel].songArr.count-1;
    }
}

#pragma mark avaudioPlayerDelegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //播放完成
    if (flag) {
        switch (self.playMode) {
            case sequenceLoop:
                //顺序播放
                [self nextSong];
                break;
            case singleLoop:{
                //单曲循环
                NSInteger cureetIndex=self.playIndex;
                self.playIndex=-1;
                self.playIndex=cureetIndex;
              }
                break;
            case Random:
                //生成一个随机数 [0-count)
                self.playIndex=arc4random()%[SongLIstHandle sharedHandel].songArr.count;
                break;
            default:
                break;
        }
        
    }

}


+(instancetype)shareHandel{
    static PlayerHandel *handel;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        handel=[PlayerHandel new];
        handel.playIndex=-1;
        //设置音量值
        handel.volume=.5;
        //设置后台播放策略
        [handel setAuridoBackGroudSeesion];
        
    });
    return handel;
}


@end
