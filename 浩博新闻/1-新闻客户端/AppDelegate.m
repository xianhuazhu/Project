//
//  AppDelegate.m
//  1-新闻客户端
//
//  Created by qingyun on 15/11/23.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "settingViewController.h"
#import "discourseViewController.h"
#import "Header.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navCtr;
@property (nonatomic, strong) UIViewController *VC;
@property (nonatomic, strong) NSString *appRun;
@property (nonatomic, strong) NSString *currentVersion;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = [self instationRootVC];
        [self.window makeKeyAndVisible];
    
        if ([self.appRun isEqualToString:self.currentVersion]) {
            [self creatNavigation];
        }
        return YES;
}

- (void)creatNavigation
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    _VC = [story instantiateViewControllerWithIdentifier:@"mainControll"];
    _navCtr = [[UINavigationController alloc] initWithRootViewController:_VC];
    
    [_VC.navigationItem setTitle:@"浩博新闻"];
    
    //自定义导航栏背景
    UIImage *imageNavigationBar = [UIImage imageNamed:@"daohangxiugai5.png"];
    [_navCtr.navigationBar setBackgroundImage:imageNavigationBar forBarMetrics:UIBarMetricsDefault];
    
    UIImage *imageToolbar = [UIImage imageNamed:@"daohangxiugai5.png"];
    [_navCtr.toolbar setBackgroundImage:imageToolbar forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    //创建工具栏内容
    UIBarButtonItem *first = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_home@2x.png"]   style:UIBarButtonItemStylePlain target:self action:nil];
    
    //设置图片保持原型
    UIBarButtonItem *second = [[UIBarButtonItem alloc] initWithTitle:@"^_^" style:UIBarButtonItemStylePlain target:self action:@selector(clickDiscourseView)];
    UIBarButtonItem *third = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_pop_os7@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickSetBtn)];
    
    //创建不固定间隔的barButtonIterm
    UIBarButtonItem *FlexibleSpaceBarBtnIterm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //创建固定间隔的barButtonIterm
    UIBarButtonItem *fixedSpaceBtnButIterm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedSpaceBtnButIterm.width = 30;
    
    NSArray *iterm = @[fixedSpaceBtnButIterm,first ,FlexibleSpaceBarBtnIterm,second , FlexibleSpaceBarBtnIterm,third,fixedSpaceBtnButIterm];
    [_VC setToolbarItems:iterm animated:YES];
    
    //对字体颜色的设置
    _navCtr.navigationBar.tintColor = [UIColor blackColor];
    _navCtr.toolbar.tintColor = [UIColor blackColor];
    //显示工具栏
    _navCtr.toolbarHidden = NO;
    
    _navCtr.navigationBar.translucent = NO;
    self.window.rootViewController = _navCtr;
}

//设置页面
- (void)clickSetBtn
{
    settingViewController *set = [[settingViewController alloc] init];
    [_navCtr pushViewController:set animated:YES];
}

- (void)clickDiscourseView
{
    discourseViewController *discourseView = [[discourseViewController alloc] init];
    [_navCtr pushViewController:discourseView animated:YES];
}

- (UIViewController *)instationRootVC
{
    //根据应用打开情况，第一次打开，显示引导页，之后再打开应用，显示的是首页
    
    //app运行的版本号
    _currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    _appRun = [user objectForKey:kAppRun];
    
    if ([_appRun isEqualToString:_currentVersion]) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *VC = [story instantiateViewControllerWithIdentifier:@"mainControll"];
        return VC;
    }else{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *VC = [story instantiateViewControllerWithIdentifier:@"guidST"];
        return VC;
    }
}

- (void)guidEnd
{
    //切换控制器
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    _VC = [story instantiateViewControllerWithIdentifier:@"mainControll"];
    self.window.rootViewController = _VC;
    [self creatNavigation];
    
    _currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //保存标记
    [[NSUserDefaults standardUserDefaults] setObject:_currentVersion forKey:kAppRun];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //提高自己应用的优先级
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence" withExtension:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    
    //无线播放
    player.numberOfLoops = -1;
    [player play];
    
    _player = player;
}

//程序进入后台时调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //开启一个后台任务，时间不确定，优先级比较低，加入系统要关闭应用，首先就先考虑
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        //当后台任务结束的时候调用
        [application endBackgroundTask:ID];
    }];
    
    //如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    //但是苹果会检测你的程序当时有没有播放音乐，如果没有，就有可能干掉你
    //微博：在程序即将失去焦点的时候播放静音音乐
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
