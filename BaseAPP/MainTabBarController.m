/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//
//  MainTabBarController.m
//  BaseAPP
//
//  Created by 刘一峰 on 2017/6/15.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "MainTabBarController.h"
#import "RegularTool.h"

#define RGB(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0  alpha:1.0]
@interface MainTabBarController ()
@property(nonatomic,strong)NSArray *tabbarArray;
@end

@implementation MainTabBarController

- (NSArray *)tabbarArray {
    if (!_tabbarArray) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Tabbar" ofType:@"plist"];
        _tabbarArray = [NSArray arrayWithContentsOfFile:plistPath];
    }
    return _tabbarArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabbarArray enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[@"class"]) new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[@"name"];
        item.image = [UIImage imageNamed:dict[@"img_unSelect"]];
        item.selectedImage = [[UIImage imageNamed:dict[@"img_select"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        unsigned long UnSelectColor = strtoul([dict[@"title_unSelect"] UTF8String],0,0);
        unsigned long selectColor = strtoul([dict[@"title_select"] UTF8String],0,0);
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(selectColor)} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(UnSelectColor)} forState:UIControlStateNormal];
        [self addChildViewController:nav];
        //31  185 34
    }];
    
  
    
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
