
# PasswordText
## ☆☆☆ “好用的密码键盘” ☆☆☆
## 使用简单，两步就搞定啦，可以根据自己的需求修改和扩展。
### （1）导入CCPasswordText文件夹（只有两个文件哦）
### （2）引入头文件（#import "CCPasswordTextView.h"）
## 示例代码
### CCPasswordTextView * pwView = [[CCPasswordTextView alloc] initWithFrame:CGRectMake(0, 0, element_wh * count, element_wh)];
### pwView.center = CGPointMake(self.view.center.x, 140);
### pwView.elementCount = count; // 元素位数
### pwView.elementBorderColor = [UIColor lightGrayColor];// 边界线颜色
### pwView.elementBorderWidth = 1; // 边界线宽度
### pwView.elementMargin = 0;// 元素间间距
### [pwView setValidationBoardType:VALIDATION_BOARDTYPE_NUMBER]; // 键盘样式
### pwView.passwordDidChangeBlock = ^(NSString * password) {
### NSLog(@"----------> password:%@",password);
### };
### [self.view addSubview:pwView];

## PS:如需更详细的设置，进入CCPasswordTextView.m，写的有注释。
![](https://github.com/cuixinkuan/PasswordText/blob/master/15.gif)
