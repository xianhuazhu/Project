//
//  discourseViewController.m
//  1-新闻客户端
//
//  Created by qingyun on 15/11/25.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "discourseViewController.h"
#import "Header.h"

@interface discourseViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIWebViewDelegate>

@property (nonatomic, strong) URLanalysis *urlL;
@property (nonatomic, strong) UIRefreshControl *refresh;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datasArr;
@property (nonatomic, strong) SmileCVC *cell;
@property (nonatomic, assign) NSInteger time;

@property (nonatomic, assign) BOOL SwitchIs;

@end

@implementation discourseViewController

static NSString *identifer = @"cell";

//懒加载
- (NSMutableArray *)datasArr
{
    if (_datasArr == nil) {
        _datasArr = [NSMutableArray array];
    }
    return _datasArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCollectionView];
    [self addRefresh];
    [self requestDataFromNet];
    
    [self.collectionView reloadData];
}

#pragma mark -creatCollectionView
- (void)createCollectionView
{
    //设置流布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置section的页眉页脚高
    layout.headerReferenceSize = CGSizeMake(10, 10);
    layout.footerReferenceSize = CGSizeMake(10, 10);
    
    layout.itemSize = CGSizeMake(300, 185);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    
    //设置数据源和代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.25 alpha:0.9];
    //注册item
    [_collectionView registerNib:[UINib nibWithNibName:@"SmileCVC" bundle:nil] forCellWithReuseIdentifier:identifer];
    //注册补充头尾视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifer];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifer];
}

#pragma mark -addRefresh
- (void)addRefresh
{
    _urlL = [[URLanalysis alloc] init];
    _time =1;
    [_urlL setValue:@(_time) forKey:@"GXtimes"];
    
    __weak discourseViewController *weakSelf = self;
    //下拉刷新
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _time = 1;
        [_urlL setValue:@(_time) forKey:@"GXtimes"];
        [weakSelf requestDataFromNet];
    }];
    
    //上拉加载
    _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _time++;
        [_urlL setValue:@(_time) forKey:@"GXtimes"];
        [weakSelf requestDataFromNet];
    }];
}

- (void)endRefresh
{
    if (_refresh.isRefreshing) {
        [_refresh endRefreshing];
    }
    
    if ([_collectionView.mj_header isRefreshing]) {
        [_collectionView.mj_header endRefreshing];
    }
    if ([_collectionView.mj_footer isRefreshing]) {
        [_collectionView.mj_footer endRefreshing];
    }
}

#pragma mark -requestDataFromNet
- (void)requestDataFromNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/javascript",@"application/json", nil];

    [manager GET:_urlL.urlGaoXiao parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"data"][@"list"];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            [array addObject:dict];
        }
        [self.datasArr addObjectsFromArray:array];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    [self endRefresh];
}

#pragma mark -UITableViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    _cell.layer.shadowOpacity = 1;
    _cell.layer.shadowRadius = 30;
    _cell.layer.cornerRadius = 10;
    _cell.layer.shadowOffset = CGSizeMake(-6, 6);

    if ([[setting shared].value isEqualToString:@"小"]) {
        _cell.title.font = [UIFont systemFontOfSize:10];
    }else if([[setting shared].value isEqualToString:@"大"]){
        _cell.title.font = [UIFont systemFontOfSize:18];
    }else{
        _cell.title.font = [UIFont systemFontOfSize:14];
    }
    
    //夜间模式
    if ([setting shared].switchValue) {
        self.view.backgroundColor = [UIColor darkGrayColor];
        self.collectionView.backgroundColor = [UIColor darkGrayColor];
        [_cell setBackgroundColor:[UIColor lightGrayColor]];
        _cell.title.textColor = [UIColor whiteColor];
    }else{
        self.view.backgroundColor = [UIColor colorWithWhite:1.25 alpha:0.9];
        self.collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        [_cell setBackgroundColor:[UIColor whiteColor]];
        _cell.title.textColor = [UIColor blackColor];
    }
    
    NSDictionary *dict = self.datasArr[indexPath.row];
    _cell.title.text = dict[@"title"];
    [_cell.imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"kpic"]]];
    
    return _cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat white = kScreenW - 60;
    CGFloat height = kScreenH /4;
    return CGSizeMake(white, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIWebView *web = [[UIWebView alloc] init];
    web.delegate = self;
    NSDictionary *mode = self.datasArr[indexPath.row];
    NSURL *url = [[NSURL alloc] initWithString:mode[@"link"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    web.opaque = NO;
    web.backgroundColor = [UIColor clearColor];
    
    UIViewController *viewControll = [[UIViewController alloc] init];
    [viewControll setView:web];
    [self.navigationController pushViewController:viewControll animated:YES];
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
