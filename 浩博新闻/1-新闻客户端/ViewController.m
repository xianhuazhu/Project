//
//  ViewController.m
//  1-新闻客户端
//
//  Created by qingyun on 15/11/25.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UINavigationBarDelegate, UIWebViewDelegate>
{
    UIRefreshControl *refresh;
}
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *middleTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UITableView *currentTableView;

@property (nonatomic, strong) itermsScrollView *itemsView;
@property (nonatomic, strong) BigScrollView *tablesScrollView;
@property (nonatomic, strong) URLanalysis *urlLanalysis;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSArray *itemsArr;

@property (nonatomic, strong) NSArray *leftArr;
@property (nonatomic, strong) NSArray *middleArr;
@property (nonatomic, strong) NSArray *rightArr;

@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) BOOL isResquest;

@property (nonatomic, strong) onePictureTableViewCell *OnePictureCell;
@property (nonatomic, strong) bigImageTableViewCell *BigPictureCell;
@property (nonatomic, strong) threePictureTableViewCell *ThreePictureCell;

@property (nonatomic, strong) settingViewController *setting;
@property (nonatomic, strong) discourseViewController *dis;
@property (nonatomic, assign) BOOL isOn;


@end

@implementation ViewController

//懒加载
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
      _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UITableView *)currentTableView
{
    if (_currentTableView == nil) {
        _currentTableView = [[UITableView alloc] init];
    }
    return _currentTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _itemsArr = @[@"首页", @"娱乐", @"社会", @"财经",@"体育",
                      @"NBA", @"汽车",@"科技", @"游戏", @"教育",
                      @"八卦", @"健康", @"时尚", @"历史", @"收藏", @"家居",
                      @"博客", @"星座", @"女性"];
    
    _time = 1;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createScrollViewAndTableViews];
    [self addRefreshControl];
    [self ResquestDataFromNte];
    [self createItemsScrollView];
    
    //接收set中的夜间模式的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTarget:) name:@"post" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSwitchValue:) name:@"SwitchPost" object:nil];
}

- (void)addTarget:(NSNotification *)notification
{
    self.CurrentBtnText = notification.userInfo[@"value"];
    [self changeTableViewAndLoadData];
}

- (void)getSwitchValue:(NSNotification *)notification
{
    if ([notification.userInfo[@"SwitchValue"] isEqualToString:@"ON"]) {
        self.isOn = YES;
        [self.view setBackgroundColor:[UIColor darkGrayColor]];
        [self.itemsView setBackgroundColor:[UIColor darkGrayColor]];
        [self.tablesScrollView setBackgroundColor:[UIColor darkGrayColor]];
        [self.leftTableView setBackgroundColor:[UIColor darkGrayColor]];
        [self.middleTableView setBackgroundColor:[UIColor darkGrayColor]];
        [self.rightTableView setBackgroundColor:[UIColor darkGrayColor]];
        [self changeTableViewAndLoadData];
    }else{
        self.isOn = NO;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self.itemsView setBackgroundColor:[UIColor whiteColor]];
        [self.tablesScrollView setBackgroundColor:[UIColor whiteColor]];
        [self.leftTableView setBackgroundColor:[UIColor whiteColor]];
        [self.middleTableView setBackgroundColor:[UIColor whiteColor]];
        [self.rightTableView setBackgroundColor:[UIColor whiteColor]];
        [self changeTableViewAndLoadData];
    }
   
}

#pragma mark -ResquestDataFromNte
- (void)ResquestDataFromNte
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    
    [manager GET:_urlLanalysis.pathArr[_currentIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"][@"list"];
        NSMutableArray *arr = [NSMutableArray array];

        for (NSDictionary *dict in array) {
            [arr addObject:dict];
        }
        
        self.dataArr = arr;
        [self changeTableViewAndLoadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_currentIndex == 0) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"  对不起！" message:@"网络不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
        }
    }];
    [self endRefresh];
}

#pragma mark -addRefreshControl
- (void)addRefreshControl
{
    _urlLanalysis = [[URLanalysis alloc] init];
    //属性传值
    [_urlLanalysis setValue:@(_time) forKey:@"times"];
    __weak ViewController *weakSelf = self;
    
    //下拉刷新
    _leftTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_time > 1) {
            _time--;
        }else{
            _time = 1;
        }
        [_urlLanalysis setValue:@(_time) forKey:@"times"];
        [weakSelf ResquestDataFromNte];
    }];
    //上拉加载
    _leftTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [_urlLanalysis setTimes:_time++];
        [weakSelf ResquestDataFromNte];
    }];
    
    _middleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _time = 1;
        [_urlLanalysis setValue:@(_time) forKey:@"times"];
        [weakSelf ResquestDataFromNte];
    }];
    _middleTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [_urlLanalysis setTimes:_time++];
        [weakSelf ResquestDataFromNte];
    }];
    
    _rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _time = 1;
        [_urlLanalysis setValue:@(_time) forKey:@"times"];
        [weakSelf ResquestDataFromNte];
    }];
    _rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [_urlLanalysis setTimes:_time++];
        [weakSelf ResquestDataFromNte];
    }];
}

- (void)endRefresh
{
    if (refresh.isRefreshing) {
        [refresh endRefreshing];
    }
    if (_leftTableView.mj_header.isRefreshing || _middleTableView.mj_header.isRefreshing || _rightTableView.mj_header.isRefreshing) {
        [_leftTableView.mj_header endRefreshing];
        [_middleTableView.mj_header endRefreshing];
        [_rightTableView.mj_header endRefreshing];
    }
    if (_leftTableView.mj_footer.isRefreshing || _middleTableView.mj_footer.isRefreshing || _rightTableView.mj_footer.isRefreshing) {
        [_leftTableView.mj_footer endRefreshing];
        [_middleTableView.mj_footer endRefreshing];
        [_rightTableView.mj_footer endRefreshing];
    }
}

#pragma mark -createItemsScrollView
- (void)createItemsScrollView
{
    _itemsView = [[itermsScrollView alloc] initWithButtonsArr:_itemsArr];
    
    //控制器通过block块来获取index值的变化
    __weak ViewController *weakSelf = self;
    void (^changeValue)(NSInteger) = ^(NSInteger currentIndex){
        _currentIndex = currentIndex;
        
        _time = 1;
        [weakSelf ResquestDataFromNte];
        [weakSelf changeTableViewAndLoadData];
    };
    [_itemsView setValue:changeValue forKey:@"changeIndexValue"];

    //设置阴影
    //1.创建一个layer
    CALayer *layer = [CALayer layer];
    //2.几何尺寸
    layer.bounds = CGRectMake(0, 0, kScreenW, 30);
    layer.position = CGPointMake(kScreenW/2, 15);
    layer.backgroundColor = [UIColor colorWithWhite:1.25 alpha:0.9].CGColor;
    [self.view.layer addSublayer:layer];
    
    layer.shadowOpacity = 0.1;
    layer.shadowRadius = 5;
    layer.shadowOffset = CGSizeMake(4, 10);
    
    [self.view addSubview:_itemsView];
}

#pragma mark -changeTableViewAndLoadData
- (void)changeTableViewAndLoadData
{
    //index = 0 情况，只需要刷新左边tableView和中间tableView
    if (_currentIndex == 0) {
        _leftArr = self.dataArr;
        _middleArr = self.dataArr;
        
        [_leftTableView reloadData];
        [_middleTableView reloadData];
        
        self.tablesScrollView.contentOffset = CGPointMake(0, 0);
        
        //index 是为最后的下标时，刷新右边tableView 和 中间 tableView
    }else if(_currentIndex == _itemsArr.count - 1){
        _rightArr = self.dataArr;
        _middleArr = self.dataArr;
        [_rightTableView reloadData];
        [_middleTableView reloadData];
        
        self.tablesScrollView.contentOffset = CGPointMake(kScreenW*2, 0);
        //除了上边两种情况，三个tableView 都要刷新，为了左右移动时都能够显示数据
    }else{
        _rightArr = self.dataArr;
        _middleArr = self.dataArr;
        _leftArr = self.dataArr;
        
        [_rightTableView reloadData];
        [_middleTableView reloadData];
        [_leftTableView reloadData];
        
        self.tablesScrollView.contentOffset = CGPointMake(kScreenW, 0);
    }
    
    _leftTableView.rowHeight = 100;
    _middleTableView.rowHeight = 100;
    _rightTableView.rowHeight = 100;
}

#pragma mark -createScrollViewAndTableViews
//在ScrollView中创建三个tableView
- (void)createScrollViewAndTableViews
{
    _tablesScrollView = [[BigScrollView alloc] initBigScroll];
    _tablesScrollView.delegate = self;
    [self.view addSubview:_tablesScrollView];
    
    //CGRect frame = _tablesScrollView.frame;
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 13, kScreenW,kScreenH-30) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.rowHeight = 80;
    _leftTableView.separatorInset = UIEdgeInsetsMake(0, 13, 0, 20);
    [_tablesScrollView addSubview:_leftTableView];
    
    //frame.origin.x = kScreenWidth;
    _middleTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenW, 13, kScreenW ,kScreenH-30) style:UITableViewStylePlain];
    _middleTableView.delegate = self;
    _middleTableView.dataSource = self;
    _middleTableView.rowHeight = 80;
    _middleTableView.separatorInset = UIEdgeInsetsMake(0, 13, 0, 20);
    [_tablesScrollView addSubview:_middleTableView];
    
    //frame.origin.x = 2*kScreenWidth;
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenW * 2, 13, kScreenW ,kScreenH-30) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.rowHeight = 80;
    _rightTableView.separatorInset = UIEdgeInsetsMake(0, 13, 0, 20);
    [_tablesScrollView addSubview:_rightTableView];
    
    //注意这里的contentOffset初始化为(0,0)
    _tablesScrollView.contentOffset = CGPointMake(0, 0);
}

//SrollView 的代理方法，停止滑动时，确定index 并且调用刷新 tableView 的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual: _tablesScrollView]) {
        
        CGPoint point = _tablesScrollView.contentOffset;
        //当ScrollView的contentOffSet的偏移量从 kScreenWidth 到 2*kScreenWidth 的情况
        if(point.x > _tablesScrollView.frame.size.width){
            
            _currentIndex +=1;
            if (_currentIndex > _itemsArr.count - 1) {
                _currentIndex = _itemsArr.count - 1;
            }
            [self changeTableViewAndLoadData];
            //当ScrollView的contentOffSet 的偏移量从 kScreenWidth 到 0 时的情况
        }else if(point.x == 0){
            
            _currentIndex -=1;
            if (_currentIndex < 0) {
                _currentIndex = 0;
            }
            [self changeTableViewAndLoadData];
        }
        //当下标为0，并且当ScrollView的contentOffSet 的偏移量从 0 到 kScreenWidth 的情况
        if (point.x == kScreenW && _currentIndex == 0){
            _currentIndex ++;
            [self changeTableViewAndLoadData];
        }
        
        //当下标为最后一个时，并且ScrollView 的ContentOffSet 的偏移量 从 2*kScreenWidth 到 kScreenWidth 的情况
        if (point.x == kScreenW && _currentIndex == _itemsArr.count-1) {
            _currentIndex --;
            [self changeTableViewAndLoadData];
        }
    }
    _itemsView.index = _currentIndex;
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_leftTableView]) {
        return  _leftArr.count;
    }else if([tableView isEqual:_middleTableView]){
        return _middleArr.count;
    }else{
        return _rightArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row % self.dataArr.count;
    static NSString *identifier = @"cell";
    
    NSDictionary *dict = self.dataArr[row];
    NSMutableArray *imageArr = [NSMutableArray array];
    NSMutableDictionary *totalDict = [NSMutableDictionary dictionary];
    
    totalDict = dict[@"comment_count_info"];
    imageArr = dict[@"pics"][@"list"];
    
    //一张大图
    if ([dict[@"feedShowStyle"] isEqualToString:@"big_img_show"]) {
        bigImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"bigImageTableViewCell" owner:self options:nil][0];
        }
        
        //夜间模式
        if (self.isOn) {
            cell.backgroundColor = [UIColor darkGrayColor];
            cell.title.textColor = [UIColor whiteColor];
        }else
        {
            cell.backgroundColor = [UIColor whiteColor];
            cell.title.textColor = [UIColor blackColor];
        }
        
        CGFloat height = cell.imgView.frame.size.height+cell.title.frame.size.height+34;
        //设置字体大小
        if ([self.CurrentBtnText isEqualToString:@"小"]) {
            cell.title.font = [UIFont systemFontOfSize:10];
        }else if ([self.CurrentBtnText isEqualToString:@"大"]){
            cell.title.font = [UIFont systemFontOfSize:18];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
        }
        
        //选择执行的tableView
        if (tableView == _leftTableView) {
            NSUInteger row = indexPath.row % self.leftArr.count;
            self.leftTableView.rowHeight = height;
            self.currentTableView = _leftTableView;
            cell.dict = self.leftArr[row];
            cell.totalDic = totalDict;
        }else if (tableView == _middleTableView) {
            NSUInteger row = indexPath.row % self.middleArr.count;
            self.middleTableView.rowHeight = height;
            self.currentTableView = _middleTableView;
            cell.dict = self.middleArr[row];
            cell.totalDic = totalDict;
        }else{
            NSUInteger row = indexPath.row % self.leftArr.count;
            self.leftTableView.rowHeight = height;
            self.currentTableView = _rightTableView;
            cell.dict = self.rightArr[row];
            cell.totalDic = totalDict;
        }
        return cell;
    }
    
    //一张居右小图片和文本
    if (imageArr.count < 3) {
        onePictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"onePictureTableViewCell" owner:self options:nil][0];
        }
        
        //夜间模式
        if (self.isOn) {
            cell.backgroundColor = [UIColor darkGrayColor];
            cell.label.textColor = [UIColor whiteColor];
            cell.update.textColor = [UIColor whiteColor];
        }else
        {
            cell.backgroundColor = [UIColor whiteColor];
            cell.label.textColor = [UIColor blackColor];
            cell.update.textColor = [UIColor blackColor];
        }
        
        CGFloat height = cell.imgView.frame.size.height + cell.total.frame.size.height + 19;
        //设置字体大小
        if ([self.CurrentBtnText isEqualToString:@"小"]) {
            cell.label.font = [UIFont systemFontOfSize:10];
            cell.update.font = [UIFont systemFontOfSize:7];
        }else if ([self.CurrentBtnText isEqualToString:@"大"]){
            cell.label.font = [UIFont systemFontOfSize:18];
            cell.update.font = [UIFont systemFontOfSize:14];
        }else{
            cell.label.font = [UIFont systemFontOfSize:14];
            cell.update.font = [UIFont systemFontOfSize:11];
        }
        
        //选择执行的tableView
        if (tableView == _leftTableView) {
            NSUInteger row = indexPath.row % self.leftArr.count;
            self.leftTableView.rowHeight = height;
            self.currentTableView = _leftTableView;
            cell.dict = self.leftArr[row];
            cell.totalDict = totalDict;
        }else if (tableView == _middleTableView) {
            NSUInteger row = indexPath.row % self.middleArr.count;
            self.middleTableView.rowHeight = height;
            self.currentTableView = _middleTableView;
            cell.dict = self.middleArr[row];
            cell.totalDict = totalDict;
        }else{
            NSUInteger row = indexPath.row % self.rightArr.count;
            self.leftTableView.rowHeight = height;
            self.currentTableView = _rightTableView;
            cell.dict = self.rightArr[row];
            cell.totalDict = totalDict;
        }
        return cell;
    }
    
    //三张图片
    _ThreePictureCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_ThreePictureCell == nil) {
        _ThreePictureCell = [[NSBundle mainBundle] loadNibNamed:@"threePictureTableViewCell" owner:self options:nil][0];
    }
    
    if (self.isOn) {
        _ThreePictureCell.backgroundColor = [UIColor darkGrayColor];
        _ThreePictureCell.label.textColor = [UIColor whiteColor];
    }else
    {
        _ThreePictureCell.backgroundColor = [UIColor whiteColor];
        _ThreePictureCell.label.textColor = [UIColor blackColor];
    }
    
    //设置字体大小
    if ([self.CurrentBtnText isEqualToString:@"小"]) {
        _ThreePictureCell.label.font = [UIFont systemFontOfSize:10];
    }else if ([self.CurrentBtnText isEqualToString:@"大"]){
        _ThreePictureCell.label.font = [UIFont systemFontOfSize:18];
    }else{
        _ThreePictureCell.label.font = [UIFont systemFontOfSize:14];
    }

    
    CGFloat height = _ThreePictureCell.label.frame.size.height + _ThreePictureCell.imgViewOne.frame.size.height + _ThreePictureCell.source.frame.size.height + 13;
    //选择执行的tableView
    if (tableView == _leftTableView) {
        NSUInteger row = indexPath.row % self.leftArr.count;
        self.leftTableView.rowHeight = height;
        self.currentTableView = _leftTableView;
        _ThreePictureCell.arr = imageArr;
        NSDictionary *dict = self.leftArr[row];
        _ThreePictureCell.label.text = dict[@"title"];
        _ThreePictureCell.source.text = dict[@"source"];
        _ThreePictureCell.totalDict = totalDict;
    }else if (tableView == _middleTableView) {
        NSUInteger row = indexPath.row % self.middleArr.count;
        self.middleTableView.rowHeight = height;
        self.currentTableView = _middleTableView;
        _ThreePictureCell.arr = imageArr;
        NSDictionary *dict = self.middleArr[row];
        _ThreePictureCell.label.text = dict[@"title"];
        _ThreePictureCell.source.text = dict[@"source"];
        _ThreePictureCell.totalDict = totalDict;
    }else{
        NSUInteger row = indexPath.row % self.rightArr.count;
        self.leftTableView.rowHeight = height;
        self.currentTableView = _rightTableView;
        _ThreePictureCell.arr = imageArr;
        NSDictionary *dict = self.rightArr[row];
        _ThreePictureCell.label.text = dict[@"title"];
        _ThreePictureCell.source.text = dict[@"source"];
        _ThreePictureCell.totalDict = totalDict;
    }
    return _ThreePictureCell;
}

#pragma mark -showWebView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *mode = self.dataArr[indexPath.row];
    NSURL *url = [[NSURL alloc] initWithString:mode[@"link"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [webView loadRequest:request];
    webView.delegate = self;
    webView.opaque = YES;
    
    UIViewController *viewControll = [[UIViewController alloc] init];
    [viewControll setView:webView];
    
    [self.navigationController pushViewController:viewControll animated:YES];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 5, 100, 40);
    [btn addTarget:self action:@selector(SouYe) forControlEvents:UIControlEventTouchUpInside];
    [webView addSubview:btn];
    
}

- (void)SouYe
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"post" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SwitchPost" object:nil];
}

@end
