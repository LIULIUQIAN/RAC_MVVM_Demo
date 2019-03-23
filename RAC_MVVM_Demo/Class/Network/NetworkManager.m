//
//  ViewController.m
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//

#import "NetworkManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>

static NSString * const salt = @"gn1002015";

@implementation NetworkManager

//  MD5
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString
{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];

    return result;
}

//     参数md5 key值
+ (NSString *)md5ForParamas:(NSDictionary *)paramas time:(int) aiTime
{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramas options:NSJSONReadingAllowFragments error:nil];
    // NSJSONReadingAllowFragments : 使用这个
    // NSJSONWritingPrettyPrinted 会有\n，不需要
    NSString *jsonParserString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString *myString = [NSString stringWithFormat:@"%@%d%@",jsonParserString,aiTime, salt];
    
    NSString *keyMD5 = [self getMd5_32Bit_String:myString];
    NSString *keymd5 = [self getMd5_32Bit_String:keyMD5];
    
    
    return keymd5;
}

// 获取当前时间
+ (int)getDateByInt
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    int liDate = (int) dateInterval;
    return liDate;
}

    // Version
+ (NSString *)Version {
    
    NSString *string = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:string];
    NSString *version = [dic objectForKey:@"CFBundleVersion"];
    return version;
    
}
    
#pragma mark - 获取首页参数
+ (NSDictionary *)paramWithHome
{
    NSDictionary * params = @{@"city":@"中国",
                              @"cityId":@0,
                              @"condition":@"35,33,32,35,34",
                              @"teacherSeach":@"1000,1000,1000"
                              };
    NSString *version = [self Version];
    
    //   获取当前的时间
    int liTime = [self getDateByInt];
    NSString *keymd5 = [self md5ForParamas:params time:liTime];
    NSDictionary *myparamses =@{
                                @"u":@"i",
                                @"v":version,
                                @"time":@(liTime),
                                @"params":params,
                                @"key":keymd5
                                };

    return myparamses;
}

+ (NSString *)urlWithHome
{
    return @"https://www.yunke.com/interface/main/home";
}

@end
