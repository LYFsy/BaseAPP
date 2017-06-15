/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//  NetworkManager.m
//  LaunchIntroduction
//
//  Created by 刘一峰 on 2017/6/13.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"


static NetworkManager *instance = nil;

@interface NetworkManager()

//@property(nonatomic,strong)SuccessCallback successCallback;
//@property(nonatomic,strong)FailureCallback failureCallback;

@end


@implementation NetworkManager

+ (instancetype)shareInstance {
    
    return [[NetworkManager alloc]init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [super allocWithZone:zone];
        
    });
    
    return instance;
}

/*防止使用copy时崩溃*/
- (id)copy {
    return instance;
}
- (id)mutableCopy {
    return instance;
}


- (AFHTTPSessionManager *)getAFHttpSessionManager {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://localhost"]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];

    return manager;
}

- (NSString *)UrlEncodingUTF8:(NSString *)urlString{
    
    NSString *encodedString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    return encodedString;
}


- (void)requestDataWithMethod:(RequestMethod)method Url:(NSString *)url PostParams:(NSDictionary *)params SuccessCallback:(SuccessCallback) successCallback FailureCallback:(FailureCallback)failureCallback {
    if (POST == method) {
        [self POSTRequestDataWithUrl:url PostParams:params SuccessCallback:successCallback FailureCallback:failureCallback];
    }else {
        [self GETRequestDataWithUrl:url SuccessCallback:successCallback FailureCallback:failureCallback];
    }
}

- (void)POSTRequestDataWithUrl:(NSString *) url PostParams:(NSDictionary *) params SuccessCallback:(SuccessCallback)successCallback  FailureCallback:(FailureCallback)failureCallback{
    
    //url,params,progress,success,failure
    [[self getAFHttpSessionManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successCallback(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureCallback(task,error);
    }];
}

//get 没必要用model请求的方式
- (void)GETRequestDataWithUrl:(NSString *)url SuccessCallback:(SuccessCallback)successCallback  FailureCallback:(FailureCallback)failureCallback{
    [[self getAFHttpSessionManager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successCallback(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureCallback(task,error);
    }];
}


@end
