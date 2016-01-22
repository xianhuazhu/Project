//
//  SmallScrollView.h
//  TableView复用
//
//  Created by jinchao on 15/12/18.
//  Copyright © 2015年 青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface itermsScrollView : UIScrollView

@property (nonatomic) NSInteger index;
@property (nonatomic)int currentIndex;
@property (nonatomic, strong)UIColor *selectedColor;
@property (nonatomic, strong)void (^changeIndexValue)(NSInteger);
- (instancetype)initWithButtonsArr:(NSArray *)arr;

@end
