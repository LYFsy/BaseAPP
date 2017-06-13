//
//  RegularTool.h
//  BaseAPP
//
//  Created by Sun on 2017/6/13.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularTool : NSObject
#pragma

+ (NSString *)htmlShuangyinhao:(NSString *)values;
#pragma

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
#pragma 判断fromString是否为空，如果为空 返回nullStr；

+ (NSString *) nullDefultString: (NSString *)fromString null:(NSString *)nullStr;

#pragma 正则匹配邮箱号
+ (BOOL)checkMailInput:(NSString *)mail;

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;

+(BOOL)checkMobel:(NSString *)mobel;
#pragma 正则匹配用户密码6-18位数字和字母组合

+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文

+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号

+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹员工号,12位的数字

+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则匹配URL

+ (BOOL)checkURL : (NSString *) url;
#pragma 正则匹配昵称

+ (BOOL) checkNickname:(NSString *) nickname;
#pragma 正则匹配以C开头的18位字符

+ (BOOL) checkCtooNumberTo18:(NSString *) nickNumber;
#pragma 正则匹配以C开头字符

+ (BOOL) checkCtooNumber:(NSString *) nickNumber;
#pragma 正则匹配银行卡号是否正确

+ (BOOL) checkBankNumber:(NSString *) bankNumber;
#pragma 正则匹配17位车架号

+ (BOOL) checkCheJiaNumber:(NSString *) CheJiaNumber;
#pragma 正则只能输入数字和字母

+ (BOOL) checkTeshuZifuNumber:(NSString *) CheJiaNumber;
#pragma 车牌号验证

+ (BOOL) checkCarNumber:(NSString *) CarNumber;
@end
