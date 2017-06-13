//
//  AppDelegate+Jpush.h
//  XKBaseEngineering
//
//  Created by Sun on 2017/3/22.
//  Copyright © 2017年 孙晓康. All rights reserved.
//

#import "AppDelegate.h"
// 极光
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <UserNotifications/UserNotifications.h> // 这里是iOS10需要用到的框架

@interface AppDelegate (Jpush)<UIAlertViewDelegate,JPUSHRegisterDelegate>
-(void)initWithJpush:(UIApplication *)application WithOption:(NSDictionary *)launchOptions;
@end
