/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//  BaseModel.m
//  LaunchIntroduction
//
//  Created by 刘一峰 on 2017/6/13.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "BaseModel.h"
#import "NetworkManager.h"
#import "YYModel.h"
@implementation BaseModel

- (NSString *)api {
    NSAssert(0,@"must override this method");
    return nil;
}

- (NSString *)modelApi {
    NSAssert(0,@"must override this method");
    return nil;
}

//模型转化为字典，作为post参数
- (NSMutableDictionary *)postParms {
    return [self yy_modelToJSONObject];
}
- (void)requestDatasSuccessCallback:(SuccessCallback)successCallback FailureCallback:(FailureCallback)failureCallback {
    NSString *api = [[NSString stringWithFormat:@"%@.app?actionMethod=",[self api]] stringByAppendingString:[self modelApi]];
    [[NetworkManager shareInstance]requestDataWithMethod:POST Url:api PostParams:[self postParms] SuccessCallback:successCallback FailureCallback:failureCallback];
}

@end
