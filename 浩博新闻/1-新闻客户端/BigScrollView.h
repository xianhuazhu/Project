//
//  BigScrollView.h
//  TableView复用
//
//  Created by jinchao on 15/12/18.
//  Copyright © 2015年 青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigScrollView : UIScrollView

@property (nonatomic, assign) CGFloat tableViewContentSize;
- (instancetype)initBigScroll;
@end
