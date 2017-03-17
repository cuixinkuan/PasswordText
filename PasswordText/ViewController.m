//
//  ViewController.m
//  PasswordText
//
//  Created by admin on 17/3/17.
//  Copyright © 2017年 CuiXinKuan. All rights reserved.
//

#import "ViewController.h"
#import "CCPasswordTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPWUI];
}

- (void)setupPWUI {
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 40)];
    label.text = @"请输入密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    NSInteger count = 6;
    CGFloat element_wh = 50;
    CCPasswordTextView * pwView = [[CCPasswordTextView alloc] initWithFrame:CGRectMake(0, 0, element_wh * count, element_wh)];
    pwView.center = CGPointMake(self.view.center.x, 140);
    pwView.elementCount = count; // 元素位数
    pwView.elementBorderColor = [UIColor lightGrayColor];// 边界线颜色
    pwView.elementBorderWidth = 1; // 边界线宽度
    pwView.elementMargin = 0;// 元素间间距
    [pwView setValidationBoardType:VALIDATION_BOARDTYPE_NUMBER]; // 键盘样式
    pwView.passwordDidChangeBlock = ^(NSString * password) {
        NSLog(@"----------> password:%@",password);
    };
    
    [self.view addSubview:pwView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
