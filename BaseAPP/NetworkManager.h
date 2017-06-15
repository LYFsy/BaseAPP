/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//  NetworkManager.h
//  LaunchIntroduction
//
//  Created by 刘一峰 on 2017/6/13.
//  Copyright © 2017年 刘一峰. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethod) {
    GET = 0,
    POST,
};

typedef void(^SuccessCallback)(NSURLSessionDataTask *task,id responsObject );

typedef void(^FailureCallback)(NSURLSessionDataTask *task,NSError * error );

@interface NetworkManager : NSObject

+ (instancetype)shareInstance;

- (void)requestDataWithMethod:(RequestMethod)method Url:(NSString *)url PostParams:(NSDictionary *)params SuccessCallback:(SuccessCallback) successCallback FailureCallback:(FailureCallback)failureCallback;

- (void)GETRequestDataWithUrl:(NSString *)url SuccessCallback:(SuccessCallback)successCallback  FailureCallback:(FailureCallback)failureCallback;

- (void)POSTRequestDataWithUrl:(NSString *) url PostParams:(NSDictionary *) params SuccessCallback:(SuccessCallback)successCallback  FailureCallback:(FailureCallback)failureCallback;

@end
