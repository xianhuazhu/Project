//
//  SmallScrollView.m
//  TableView复用
//
//  Created by jinchao on 15/12/18.
//  Copyright © 2015年 青云信息技术有限公司. All rights reserved.
//

#import "itermsScrollView.h"
#import "Header.h"

@interface itermsScrollView()

@property (nonatomic, strong) NSArray *buttonsArr;
@property (nonatomic, strong) UIView *slidView;
@end

@implementation itermsScrollView

- (instancetype)initWithButtonsArr:(NSArray *)arr
{
    if (self = [super init]) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.directionalLockEnabled = YES;
        
        self.frame = CGRectMake(0, 0, kScreenW, 30);
        self.contentSize = CGSizeMake(arr.count*kButtonWidth, -30);
        //self.backgroundColor = [UIColor colorWithRed:19.61 green:-39.65 blue:-11.55 alpha:1];
        self.backgroundColor = [UIColor colorWithWhite:1.1 alpha:0.5];
        self.selectedColor = [UIColor redColor];
        
        [self createSlidView];
        
        //创建ScrollView上的所有Button
        NSMutableArray *muArr = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(kButtonWidth*i, 0, kButtonWidth, 30);
            [self addSubview:button];
            
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
            
            button.tag = 100 + i;
            
            [button addTarget:self action:@selector(buttonIsClicked:) forControlEvents:UIControlEventTouchUpInside];
            [muArr addObject:button];
        }
        self.buttonsArr = muArr;
        self.index = 0;
        
    }
    return self;
}

- (void)createSlidView
{
    _slidView = [[UIView alloc] initWithFrame:CGRectMake(0, 28, kButtonWidth, 2)];
    _slidView.backgroundColor = [UIColor redColor];
    [self addSubview:_slidView];

}
- (void)buttonIsClicked:(UIButton *)button
{
    self.index = button.tag - 100;
    //block的回调，当Item的index发生变化时，将index的传给控制器
    if (_changeIndexValue) {
        _changeIndexValue(self.index);
    }
}

- (void)setIndex:(NSInteger)index
{
    //给上一个button设置未选中状态
   
    UIButton *notSelctedButton = _buttonsArr[_index];
    notSelctedButton.selected = NO;
    
    UIButton *selectedButton = _buttonsArr[index];
    selectedButton.selected = YES;
    
    //设置选中的button居中
    CGFloat offSetX = selectedButton.frame.origin.x - kScreenW/2;
    offSetX = offSetX > 0 ? (offSetX + kButtonWidth/2):0;
    offSetX = offSetX > self.contentSize.width - kScreenW ? self.contentSize.width - kScreenW : offSetX;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(offSetX, 0);

    }];
    
    _index = index;
    CGRect frame = _slidView.frame;
    frame.origin.x = _index*kButtonWidth;
    [UIView animateWithDuration:0.3 animations:^{
        _slidView.frame = frame;
    }];

}


@end
