//
//  AppDelegate+Jpush.m
//  XKBaseEngineering
//
//  Created by Sun on 2017/3/22.
//  Copyright © 2017年 孙晓康. All rights reserved.
//

#import "AppDelegate+Jpush.h"

@implementation AppDelegate (Jpush)


-(void)initWithJpush:(UIApplication *)application WithOption:(NSDictionary *)launchOptions{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) // iOS10
    {
        //  自定义消息通知
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
        
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) // iOS8, iOS9
    {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    }
    else // iOS7
    {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    // 注册极光推送
    [JPUSHService setupWithOption:launchOptions appKey:jpushAPPkey channel:jpushAppChannel apsForProduction:YES advertisingIdentifier:nil];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0)
        {
            // iOS10获取registrationID放到这里了, 可以存到缓存里, 用来标识用户单独发送推送
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self goToMssageViewControllerWith:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self goToMssageViewControllerWith:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
}

#endif


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    [self goToMssageViewControllerWith:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"extras"]; //服务端中Extras字段，key是自己定义的
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
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
// 极光跳转
- (void)goToMssageViewControllerWith:(NSDictionary *)userInfor{
    
    // 极光消息处理 跳转操作等
    
}
#pragma mark - 自定义消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NSDictionary *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *contenType = [userInfo valueForKey:@"content_type"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];

    if ([contenType isEqualToString:@"message"]) {
        NSLog(@"收到新的消息");
    }
    [self getToken:content];
    
}


- (void)getToken:(NSString *)tok {

    // 自定义消息处理
}



@end
