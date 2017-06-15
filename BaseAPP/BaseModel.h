/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//  BaseModel.h
//  LaunchIntroduction
//
//  Created by 刘一峰 on 2017/6/13.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessCallback)(NSURLSessionDataTask *task,id responsObject );

typedef void(^FailureCallback)(NSURLSessionDataTask *task,NSError * error );

@interface BaseModel : NSObject

/**
 NOTE:
 这只是一个基类Model，所有POST请求的参数Fetch，都可以定义为model，使用model调用网络请求，只是提供一种写法，请结合实际情况选择。
 请求参数
 eg:
 @property(nonatomic,strong)NSString *name

 */

- (NSString *)api;

- (NSString *)modelApi;

- (NSMutableDictionary *)postParms;

- (void)requestDatasSuccessCallback:(SuccessCallback)successCallback FailureCallback:(FailureCallback)failureCallback;
@end
