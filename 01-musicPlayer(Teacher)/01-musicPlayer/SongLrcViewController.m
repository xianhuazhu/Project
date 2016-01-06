//
//  SongLrcViewController.m
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SongLrcViewController.h"
#import "PlayerHandel.h"
#import "NSString+timer.h"
#import "LrcParseMode.h"

@interface SongLrcViewController ()<UITableViewDelegate,UITableViewDataSource,PlayerHandelPRo>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (weak, nonatomic) IBOutlet UIButton *playModeBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *ProgressSilder;
@property (weak, nonatomic) IBOutlet UISlider *volumeSilder;

@end

@implementation SongLrcViewController
#pragma mark tableViewDataSoucrce
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [PlayerHandel shareHandel].lrcMode.keyArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text=[PlayerHandel shareHandel].lrcMode.lrcDic[[PlayerHandel shareHandel].lrcMode.keyArr[indexPath.row]];
    return cell;
}



//初始化视图
-(void)initDataForView{
  //1.初始化volume
    _volumeSilder.maximumValue=1.0;
    _volumeSilder.minimumValue=0;
    _volumeSilder.value=[PlayerHandel shareHandel].volume;
  
  //2.初始化播放状态
    if ([PlayerHandel shareHandel].isPlaying) {
        //暂停
        [_playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        //播放
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
  //3.初始化播放进度条
    _ProgressSilder.maximumValue=[PlayerHandel shareHandel].duration;
    _ProgressSilder.value=[PlayerHandel shareHandel].currentTime;
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataForView];
    //添加代理
    [PlayerHandel shareHandel].delegate=self;
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark 播放器协议
-(void)updateProgressForTime:(NSTimeInterval)time{
  //更新当前的进度条
    _ProgressSilder.value=time;
  //更新时间
    _currentTimeLab.text=[_currentTimeLab.text valueExchange:time];
}
-(void)updateLrcselectIndex:(NSInteger)index{
//选中歌词
    NSIndexPath *path=[NSIndexPath indexPathForRow:index inSection:0];
    [_myTable selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionNone];
    //滚动到哪行
    [_myTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
}
-(void)notifactionreSetUpDataLrc{
 //刷新歌词
    self.title=[PlayerHandel shareHandel].songTitle;
  [_myTable reloadData];
}



#pragma mark 播放进度改变
- (IBAction)progerssChangeValeu:(UISlider *)sender {
    //改变播放进度
    [PlayerHandel shareHandel].currentTime=sender.value;
    
}
#pragma mark音量控制
- (IBAction)volumeChangeValue:(UISlider *)sender {
    [PlayerHandel shareHandel].volume=sender.value;
}

#pragma mark 播放模型 //设置播放模式
- (IBAction)PlayerModeChang:(UIButton *)sender {
    switch ([PlayerHandel shareHandel].playMode) {
        case sequenceLoop:
            [sender setTitle:@"单曲循环" forState:UIControlStateNormal];
            [PlayerHandel shareHandel].playMode=singleLoop;
            break;
        case singleLoop:
            [sender setTitle:@"随机播放" forState:UIControlStateNormal];
            [PlayerHandel shareHandel].playMode=Random;
            break;
        case Random:
            [sender setTitle:@"顺序播放" forState:UIControlStateNormal];
            [PlayerHandel shareHandel].playMode=sequenceLoop;
            break;
        default:
            break;
    }
}
#pragma mark next song
- (IBAction)touchNextSong:(UIButton *)sender {
    [[PlayerHandel shareHandel] nextSong];
}
#pragma mark prev song
- (IBAction)touchPrevSong:(UIButton *)sender {
    [[PlayerHandel shareHandel] PrevousSong];
}
#pragma mark playorpause
- (IBAction)touchPlayOrPaue:(UIButton *)sender {
    //判断是否在播放
    if ([PlayerHandel shareHandel].isPlaying) {
        //暂停
        [PlayerHandel shareHandel].playOrPause=NO;
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }else{
       //播放
        [PlayerHandel shareHandel].playOrPause=YES;
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [PlayerHandel shareHandel].delegate=nil;
}

//处理远程事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    switch (event.subtype) {
        case  UIEventSubtypeRemoteControlPlay:
            [PlayerHandel shareHandel].playOrPause=YES;
            break;
        case UIEventSubtypeRemoteControlPause:
            [PlayerHandel shareHandel].playOrPause=NO;
            break;
        case UIEventSubtypeRemoteControlTogglePlayPause:
            if ([PlayerHandel shareHandel].isPlaying) {
                [PlayerHandel shareHandel].playOrPause=NO;
            }else{
                [PlayerHandel shareHandel].playOrPause=YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
