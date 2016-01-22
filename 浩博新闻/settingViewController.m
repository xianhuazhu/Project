//
//  settingViewController.m
//  1-新闻客户端
//
//  Created by qingyun on 15/12/15.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "settingViewController.h"
#import "setting.h"

@interface settingViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic, strong) ViewController *viewControllers;
@property (nonatomic, weak) UIView *views ;
@property (nonatomic, strong) UIButton *smallBtn;
@property (nonatomic, strong) UIButton *greatBtn;
@property (nonatomic, strong) UIButton *bigBtn;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UISwitch *sw;
//@property (nonatomic, strong) NSString *CurrentFont;

@end

static NSInteger switchValue;
static NSString *CurrentFont;

@implementation settingViewController

//懒加载
- (NSArray *)datas
{
    if (_datas == nil) {
        _datas = @[@"字体大小", @"反馈", @"夜间模式", @"关于", @"版本"];;
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //字体设置
    if (CurrentFont == nil) {
        CurrentFont = @"中";
    }
    
    //夜间模式
    self.sw = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    if (switchValue == 1) {
        [self.sw setOn:YES];
    }else if(switchValue == 0){
        [self.sw setOn:NO];
    }
    
    [self setTableView];
}

#pragma mark -setTableView
- (void)setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图3.png"]];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    
    switch (indexPath.section) {
        case 0:{
            cell.textLabel.text = self.datas[indexPath.row];
            
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = CurrentFont;
            }if (indexPath.row == 2) {
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                
                cell.accessoryView = _sw;
                [_sw addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventValueChanged];
            }
        }break;
        case 1:{
            cell.textLabel.text = self.datas[indexPath.row + 3];
            if (indexPath.row == 1) {
                cell.textLabel.text = self.datas[indexPath.row + 3];
                cell.detailTextLabel.text = @"1.0";
            }
        }
            break;
        default:
            break;
    }
    _cell = cell;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell.backgroundColor = [UIColor clearColor];
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                //点击设置字体大小
                [self addView];
            }else if (indexPath.row == 1){
                FeedBackViewController *feedBack = [[FeedBackViewController alloc] init];
                [self.navigationController presentViewController:feedBack animated:YES completion:nil];
            }
        }break;
        case 1:{
            if (indexPath.row == 0) {
                GuanYu *GY = [[GuanYu alloc] init];
                [self.navigationController pushViewController:GY animated:YES];
            }
            if (indexPath.row == 1) {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"当前已是最新版本，欢迎您的使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alter show];
            }
        }break;
        default:
            break;
    }
}

#pragma mark -Btn阴影设置
- (void)addView
{
    _views = [[NSBundle mainBundle] loadNibNamed:@"Font" owner:nil options:nil][0];
    _views.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_views];
    _views.backgroundColor = [UIColor colorWithWhite:1.25 alpha:0.2];
    
    _smallBtn = (UIButton *)[_views viewWithTag:10];
    [self BtnSet:_smallBtn];
    [self.smallBtn addTarget:self action:@selector(addTarget:) forControlEvents:UIControlEventTouchUpInside];
    
    _greatBtn = (UIButton *)[_views viewWithTag:11];
    [self BtnSet:_greatBtn];
    [self.greatBtn addTarget:self action:@selector(addTarget:) forControlEvents:UIControlEventTouchUpInside];
    
    _bigBtn = (UIButton *)[_views viewWithTag:12];
    [self BtnSet:_bigBtn];
    [self.bigBtn addTarget:self action:@selector(addTarget:) forControlEvents:UIControlEventTouchUpInside];
    
    _cancleBtn = (UIButton *)[_views viewWithTag:13];
    [self BtnSet:_cancleBtn];
    [self.cancleBtn addTarget:self action:@selector(removeCurrentView) forControlEvents:UIControlEventTouchUpInside];

}

- (void)BtnSet:(UIButton *)sender
{
    [sender.layer setBorderWidth:1.0];
    [sender.layer setBorderColor:[UIColor whiteColor].CGColor];
    [sender.layer setShadowOpacity:1];
    [sender.layer setShadowRadius:100];
}

#pragma mark -SwitchSet
- (void)updateSwitchAtIndexPath:(UISwitch *)sender
{
    if (sender.on) {
        switchValue = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchPost" object:nil userInfo:@{@"SwitchValue":@"ON"}];
    }else{
        switchValue = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchPost" object:nil userInfo:@{@"SwitchValue":@"OFF"}];
    }
    [[setting shared] saveSwitchValue:switchValue];
}

- (void)addTarget:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"post" object:nil userInfo:@{@"value":sender.titleLabel.text}];
    CurrentFont = sender.titleLabel.text;

    [[setting shared] saveValue:CurrentFont];
    
    [self.tableView reloadData];
    [self.views removeFromSuperview];
}

- (void)removeCurrentView
{
    //删除
    [self.views removeFromSuperview];
    //隐藏
    //self.views.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
