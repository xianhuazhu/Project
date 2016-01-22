//
//  Header.h
//  02-FMDBURLResquest
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#ifndef Header_h
#define Header_h
//第三方库
#import "AFNetworking.h"
#import "FMDatabase.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>

//自己创建的
#import "ViewController.h"
#import "settingViewController.h"
#import "itermsScrollView.h"
#import "SmileCVC.h"
#import "onePictureTableViewCell.h"
#import "threePictureTableViewCell.h"
#import "URLanalysis.h"
#import "itermsScrollView.h"
#import "FeedBackViewController.h"
#import "bigImageTableViewCell.h"
#import "BigScrollView.h"
#import "discourseViewController.h"
#import "URLanalysis.h"
#import "GuanYu.h"
#import "setting.h"

#define kAppRun @"appRun"//app运行的标记
#define kScreenBounds  [[UIScreen mainScreen] bounds]
#define  kScreenW       [UIScreen mainScreen].bounds.size.width
#define  kScreenH        [UIScreen mainScreen].bounds.size.height
//SmallScrollView's button's width
#define kButtonWidth    [UIScreen mainScreen].bounds.size.width/7
//数据是否保存到本地
#define  ISSAVE           @"IsSave"
#define  sqlName          @"news.db"
//存储文件的名字
#define HOUSEINFOFile @"HOUSEINFO"
//网络请求的地址
#define  URLPATH         @"http://news-at.zhihu.com/api/4/stories/latest"
#define DATAMODE @"dataMode"
//数据库名
#define DBName @"student.db"

#include <sqlite3.h>
static sqlite3 *db;

#endif /* Header_h */


