//
//  AppDelegate.m
//  BaseAPP
//
//  Created by 刘一峰 on 2017/6/5.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 激光推送
    [self  initWithJpush:application WithOption:launchOptions];
    return YES;
}




// 如果有多个使用token的情况下需要在APPdelegate中注册,以防止出现token注册失败
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];
    
}

// 实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 极光清空角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [JPUSHService resetBadge];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 极光清空角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [JPUSHService resetBadge];
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
