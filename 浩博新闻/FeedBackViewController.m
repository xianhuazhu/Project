//
//  FeedBackViewController.m
//  1-新闻客户端
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "FeedBackViewController.h"
#import "settingViewController.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _backBtn.transform = CGAffineTransformScale(_backBtn.transform, .5, .5);
    _textField.layer.cornerRadius=5.0f;
    _textField.layer.masksToBounds=YES;
    _textField.layer.borderColor=[[UIColor whiteColor]CGColor];
    _textField.layer.borderWidth= 2.0f;
    [[_textField layer] setBorderColor:[[UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1.0] CGColor]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}

- (IBAction)BtnClick:(UIButton *)sender {
    _textField.text = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickBackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
