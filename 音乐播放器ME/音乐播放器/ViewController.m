//
//  ViewController.m
//  音乐播放器
//
//  Created by qingyun on 16/1/4.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "SongLIstHandle.h"
#import "songData.h"
#import "PlayerHandel.h"
#import "SongLrcViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"歌曲列表";
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"play_bar_bg2.png"] forBarMetrics:UIBarMetricsDefault];

    UIImageView *view = [[UIImageView alloc] initWithFrame:myTableView.frame];
    view.image = [UIImage imageNamed:@"向日葵.png"];
    
    [self.view addSubview:myTableView];
    [myTableView setBackgroundView:view];
}


#pragma mark -dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [SongListHandle sharedHandle].songArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
    }
    //1.取出mode
    songData *mode=[SongListHandle sharedHandle].songArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text=mode.kName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SongLrcViewController *songLrcController=[[SongLrcViewController alloc] init];
    //播放音乐
    [PlayerHandel shareHandel].playIndex=indexPath.row;
    [self.navigationController pushViewController:songLrcController animated:YES];
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
