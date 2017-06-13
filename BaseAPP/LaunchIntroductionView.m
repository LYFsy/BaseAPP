//
//  LaunchIntroductionView.m
//  LaunchIntroduction
//
//  Created by 刘一峰 on 2017/6/13.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "LaunchIntroductionView.h"

#define kUIScreenWidth [[UIScreen mainScreen]bounds].size.width
#define kUIScreenHeight [[UIScreen mainScreen]bounds].size.height

static NSString *const kAppVersion = @"appVersion";


@interface LaunchIntroductionView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *containerView;
@property(nonatomic,strong)UIPageControl *page;
@property(nonatomic,strong)NSArray *imagesArr;
@property(nonatomic,copy)NSString *buttonTitle;
@property(nonatomic,strong)UIButton *guideButton;
@property(nonatomic,assign)NSInteger previousIndex;
@end


@implementation LaunchIntroductionView

- (instancetype)initWithImages:(NSArray *)images {
    self = [super initWithFrame:[[UIScreen mainScreen]bounds]];
    if (self) {
//        if (![self isFirstLauch]) {
//            [self removeFromSuperview];
//            return nil;
//        }
        self.imagesArr = [NSArray arrayWithArray:images];
        [self defaultSetting];
        [self setupLauncher];
    }
    return self;
}


-(instancetype)initWithImages:(NSArray *)images withButtonTitle:(NSString *)title {
    self = [super initWithFrame:[[UIScreen mainScreen]bounds]];
    if (self) {
//        if (![self isFirstLauch]) {
//            [self removeFromSuperview];
//            return nil;
//        }
        self.imagesArr = [NSArray arrayWithArray:images];
        self.buttonTitle = title;
        [self defaultSetting];
        [self setupLauncher];
    }
    return self;
}

- (void)defaultSetting {
    self.pointNormalColor = [UIColor grayColor];
    self.pointSelectedColor = [UIColor whiteColor];
    self.buttonBGColor = [UIColor clearColor];
    self.buttonTitleColor = [UIColor whiteColor];
    self.pageBGColor = [UIColor clearColor];
    self.btnBorderColor = [UIColor grayColor];
    self.btnBorderWidth = 1;
    self.btnCornerRadius = 3;
    
    [self addObserver:self forKeyPath:@"pointNormalColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"pointSelectedColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"buttonBGColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"pageBGColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"buttonTitleColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"btnBorderColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"btnBorderWidth" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"btnCornerRadius" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (UIButton *)guideButton {
    if (!_guideButton) {
        _guideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _guideButton.frame = CGRectMake(0, kUIScreenHeight - 100, 100, 30);
        CGRect rect = _guideButton.frame;
        rect.origin.x = self.center.x - rect.size.width / 2;
        _guideButton.frame = rect;
        [_guideButton setTitle:self.buttonTitle forState:UIControlStateNormal];
        _guideButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _guideButton.layer.borderWidth = self.btnBorderWidth;
        _guideButton.layer.borderColor = self.btnBorderColor.CGColor;
        _guideButton.layer.cornerRadius = self.btnCornerRadius;
        [_guideButton addTarget:self action:@selector(guiteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _guideButton;
}

- (UIPageControl *)page {
    if (!_page) {
        _page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kUIScreenHeight - 50, kUIScreenWidth, 30)];

        _page.defersCurrentPageDisplay = YES;
        _page.currentPageIndicatorTintColor = self.pointSelectedColor;
        _page.pageIndicatorTintColor = self.pointNormalColor;
        [self addSubview:_page];
        
    }
    return _page;
}

- (UIScrollView *)containerView {
    if (!_containerView) {
        _containerView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        _containerView.pagingEnabled = YES;
        _containerView.delegate = self;
        UIWindow *window = [[[UIApplication sharedApplication]windows] lastObject];
        [window.rootViewController.view addSubview:self];
        [self addSubview:_containerView];
    }
    return _containerView;
}

- (void)setupLauncher {

    self.containerView.contentSize = CGSizeMake(kUIScreenWidth * self.imagesArr.count, 0);
    for (int i = 0; i < self.imagesArr.count; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * kUIScreenWidth  , 0, kUIScreenWidth, kUIScreenHeight)];
        NSString *file = [NSString stringWithFormat:@"%@/%@.jpg", [[NSBundle mainBundle] resourcePath], self.imagesArr[i]];
        UIImage * image = [UIImage imageWithContentsOfFile:file];
        imageV.contentMode = UIViewContentModeScaleToFill;
        imageV.image = image;
        [self.containerView addSubview:imageV];
        if (self.buttonTitle.length > 0 && self.imagesArr.count - 1 == i) {
            [imageV addSubview:self.guideButton];
            imageV.userInteractionEnabled = YES;
        }
    }

    
    self.page.currentPage = 0;
    self.page.numberOfPages = self.imagesArr.count;
}


#pragma mark 隐藏引导页

- (void)hideGuide {
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}

-(BOOL )isFirstLauch{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:kAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}

//有按钮引导页的点击事件
- (void)guiteClick{
    [self hideGuide];
}


//滑动减速完毕后，进行逻辑处理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _containerView) {
        int currentIndex = (int)(scrollView.contentOffset.x / kUIScreenWidth);
        self.page.currentPage = currentIndex;
        
        //note: currentIndex == _imageArr.count -  //表示滑动到最后一张。
                //current == self.previousIndex，表示上一次滑动已经到最后一张了，再次滑动则隐藏引导页
        if (currentIndex == _imagesArr.count - 1  && self.buttonTitle.length <= 0 && currentIndex == self.previousIndex) {
            [self hideGuide];
        }else {
            self.previousIndex = currentIndex;
        }
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"pointNormalColor"]) {
        self.page.pageIndicatorTintColor = self.pointNormalColor;
    }
    if ([keyPath isEqualToString:@"pointSelectedColor"]) {
        self.page.currentPageIndicatorTintColor = self.pointSelectedColor;
    }
    if ([keyPath isEqualToString:@"pageBGColor"]) {
        self.page.backgroundColor = self.pageBGColor;
    }
    if ([keyPath isEqualToString:@"buttonBGColor"]) {
        self.guideButton.backgroundColor = self.buttonBGColor;
    }
    if ([keyPath isEqualToString:@"buttonTitleColor"]) {
        self.guideButton.titleLabel.textColor = self.buttonTitleColor;
    }
    if ([keyPath isEqualToString:@"btnBorderColor"]) {
        self.guideButton.layer.borderColor = self.btnBorderColor.CGColor;
    }
    if ([keyPath isEqualToString:@"btnBorderWidth"]) {
        self.guideButton.layer.borderWidth = self.btnBorderWidth;
    }
    if ([keyPath isEqualToString:@"btnCornerRadius"]) {
        self.guideButton.layer.cornerRadius = self.btnCornerRadius;
    }
}


- (void)dealloc {
    NSLog(@"释放了");
    [self removeObserver:self forKeyPath:@"pointNormalColor"];
    [self removeObserver:self forKeyPath:@"pointSelectedColor"];
    [self removeObserver:self forKeyPath:@"pageBGColor"];
    [self removeObserver:self forKeyPath:@"buttonBGColor"];
    [self removeObserver:self forKeyPath:@"buttonTitleColor"];
    [self removeObserver:self forKeyPath:@"btnBorderColor"];
    [self removeObserver:self forKeyPath:@"btnBorderWidth"];
    [self removeObserver:self forKeyPath:@"btnCornerRadius"];

}

@end
