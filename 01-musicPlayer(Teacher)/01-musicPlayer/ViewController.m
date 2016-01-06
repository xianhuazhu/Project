//
//  ViewController.m
//  01-musicPlayer
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "SongLIstHandle.h"
#import "SongMode.h"
#import "SongLrcViewController.h"
#import "PlayerHandel.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.title=@"歌曲列表";
    
    UITableView *myTable=[[UITableView alloc] initWithFrame:self.view.frame];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark tableViewDatasource 多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [SongLIstHandle sharedHandel].songArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
    }
    //1.取出mode
    SongMode *mode=[SongLIstHandle sharedHandel].songArr[indexPath.row];
    cell.textLabel.text=mode.kName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SongLrcViewController *songLrcController=[[SongLrcViewController alloc] init];
    //播放音乐
    [PlayerHandel shareHandel].playIndex=indexPath.row;
    [self.navigationController pushViewController:songLrcController animated:YES];
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

@end
