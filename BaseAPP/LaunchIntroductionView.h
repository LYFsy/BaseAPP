//
//  LaunchIntroductionView.h
//  LaunchIntroduction
//
//  Created by 刘一峰 on 2017/6/13.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchIntroductionView : UIView

//按钮字体颜色
@property(nonatomic,strong)UIColor * buttonTitleColor;
//pageController 颜色
@property(nonatomic,strong)UIColor * pointNormalColor;
@property(nonatomic,strong)UIColor * pointSelectedColor;
@property(nonatomic,strong)UIColor *pageBGColor;
//按钮颜色
@property(nonatomic,strong)UIColor *buttonBGColor;
//按钮边框颜色
@property(nonatomic,strong)UIColor *btnBorderColor;
//按钮边框宽度
@property(nonatomic,assign)CGFloat btnBorderWidth;
//按钮圆角
@property(nonatomic,assign)CGFloat btnCornerRadius;

//包含按钮的引导页
-(instancetype)initWithImages:(NSArray *)images;
//含有按钮的引导页
-(instancetype)initWithImages:(NSArray *)images withButtonTitle:(NSString *)title;
@end
