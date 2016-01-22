//
//  GuidVC.m
//  1-新闻客户端
//
//  Created by qingyun on 16/1/16.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "GuidVC.h"
#import "AppDelegate.h"

@interface GuidVC () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;

@end

@implementation GuidVC

//拖拽结束，开始减速时
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //不减速，滚动结束
    if (!decelerate) {
        self.pageControll.currentPage = self.scrollView.contentOffset.x/self.view.frame.size.width;
    }
}

//减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControll.currentPage = self.scrollView.contentOffset.x/self.view.frame.size.width;
}

- (IBAction)ComeBtnClick:(UIButton *)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate guidEnd];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
