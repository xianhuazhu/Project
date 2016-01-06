//
//  SongLrcViewController.m
//  音乐播放器
//
//  Created by qingyun on 16/1/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "SongLrcViewController.h"
#import "PlayerHandel.h"
#import "NSString+timer.h"
#import "LrcParseMode.h"

@interface SongLrcViewController () <UITableViewDataSource, UITableViewDelegate ,PlayerHandelPRo>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (weak, nonatomic) IBOutlet UIButton *playModeBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLab;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@end

@implementation SongLrcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initDataForView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"play_bar_bg2.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:_myTable.frame];
    view.image = [UIImage imageNamed:@"向日葵.png"];
    
    [_myTable setBackgroundView:view];
    //添加代理(启动代理协议)
    [PlayerHandel shareHandel].delegate = self;

}

#pragma mark -播放器协议
- (void)updateProgressForTime:(NSTimeInterval)time
{
    //更新当前的进度条
    _progressSlider.value = time;
    //更新时间
    _currentTimeLab.text = [_currentTimeLab.text valueExchange:time];
}

- (void)updateLrcselectIndex:(NSInteger)index
{
    //选中歌词
    NSIndexPath *path=[NSIndexPath indexPathForRow:index inSection:0];
    [_myTable selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionNone];
    //滚动到哪行
    [_myTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)notifactionreSetUpDataLrc
{
    //刷新歌词
    self.title = [PlayerHandel shareHandel].songTitle;
    [_myTable reloadData];
}

//音量调节
- (IBAction)volumeChangeValue:(UISlider *)sender {
    [PlayerHandel shareHandel].volume = sender.value;
}

//歌曲播放进度调节
- (IBAction)progressChange:(UISlider *)sender {
    //改变播放进度
    [PlayerHandel shareHandel].currentTime = sender.value;
}

//播放模式
- (IBAction)PlayerChange:(UIButton *)sender {
    
    switch ( [PlayerHandel shareHandel].playMode) {
        case sequenceLoop:
            [sender setTitle:@"单曲循环" forState:UIControlStateNormal];
            [PlayerHandel shareHandel].playMode = singleLoop;
            break;
        case singleLoop:
            [sender setTitle:@"随机播放" forState:UIControlStateNormal];
            [PlayerHandel shareHandel].playMode = Random;
            break;
        case Random:
            [sender setTitle:@"顺序播放" forState:UIControlStateNormal];
            [PlayerHandel shareHandel].playMode = sequenceLoop;
            break;
        default:
            break;
    }
}

//播放开始和暂停
- (IBAction)play:(UIButton *)sender {
    if ([PlayerHandel shareHandel].isPlaying) {
        //暂停
        [PlayerHandel shareHandel].playOrPause = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_click.png"] forState:UIControlStateNormal];
        
    }else{
        //播放
        [PlayerHandel shareHandel].playOrPause = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_click.png"] forState:UIControlStateNormal];
    }
}

//上一首歌曲
- (IBAction)prevSong:(UIButton *)sender {
    [[PlayerHandel shareHandel] PrevousSong];
}

//下一首歌曲
- (IBAction)nextSong:(UIButton *)sender {
    [[PlayerHandel shareHandel] nextSong];
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [PlayerHandel shareHandel].lrcMode.keyArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text=[PlayerHandel shareHandel].lrcMode.lrcDic[[PlayerHandel shareHandel].lrcMode.keyArr[indexPath.row]];
    return cell;
}

//初始化视图
- (void)initDataForView
{
    //1.初始化volume
    _volumeSlider.maximumValue=1.0;
    _volumeSlider.minimumValue=0;
    _volumeSlider.value=[PlayerHandel shareHandel].volume;
    
    //2.初始化播放状态
    if ([PlayerHandel shareHandel].isPlaying) {
        //播放
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_click.png"] forState:UIControlStateNormal];
        
    }else{
        //暂停
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_click.png"] forState:UIControlStateNormal];
        
    }
    //3.初始化播放进度条
    _progressSlider.maximumValue=[PlayerHandel shareHandel].duration;
    _progressSlider.value=[PlayerHandel shareHandel].currentTime;
    
    //4.初始化播放模式
    switch ([PlayerHandel shareHandel].playMode) {
        case singleLoop:
            [_playModeBtn setTitle:@"单曲循环" forState:UIControlStateNormal];
            break;
        case Random:
            [_playModeBtn setTitle:@"随机播放" forState:UIControlStateNormal];
            break;
        case sequenceLoop:
            [_playModeBtn setTitle:@"顺序播放" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    //5初始化化标题
    self.title=[PlayerHandel shareHandel].songTitle;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [PlayerHandel shareHandel].delegate = nil;
}

//处理远程控制事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            [PlayerHandel shareHandel].playOrPause = YES;
            break;
        case UIEventSubtypeRemoteControlPause:
            [PlayerHandel shareHandel].playOrPause = NO;
            break;
        case UIEventSubtypeRemoteControlTogglePlayPause://线控耳机
            if ([PlayerHandel shareHandel].isPlaying) {
                [PlayerHandel shareHandel].playOrPause = NO;
            }else{
                [PlayerHandel shareHandel].playOrPause = YES;
            }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
