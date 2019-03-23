//
//  ViewController.m
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject


+ (void)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * progress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task , id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task , NSError * error))failure;

@end
