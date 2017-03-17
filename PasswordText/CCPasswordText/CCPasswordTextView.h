//
//  CCPasswordTextView.h
//  PasswordText
//
//  Created by admin on 17/3/17.
//  Copyright © 2017年 CuiXinKuan. All rights reserved.
//
/*
 简单的自定义密码输入框
 */

#import <UIKit/UIKit.h>

typedef enum {
    VALIDATION_BOARDTYPE_DEFAULT = 0, // 默认键盘
    VALIDATION_BOARDTYPE_NUMBER = 1, // 数字键盘
    
}ValidationBoardType;

@interface CCPasswordTextView : UIView
/**输入框内容回调*/
@property (nonatomic,copy)void (^passwordDidChangeBlock)(NSString * password);

/**密码位数*/
@property (nonatomic,assign)NSInteger elementCount;
/**元素边界线颜色*/
@property (nonatomic,strong)UIColor * elementBorderColor;
/**元素间的间距*/
@property (nonatomic,assign)CGFloat elementMargin;
/**元素边界线宽度*/
@property (nonatomic,assign)CGFloat elementBorderWidth;
/**键盘处理*/
@property (nonatomic,assign)BOOL autoHiddenKeyboard;

/**设置键盘样式*/
- (void)setValidationBoardType:(ValidationBoardType)validationBoardType;

- (void)clearPassword;
- (void)showKeyboard;
- (void)hideKeyboard;

@end
