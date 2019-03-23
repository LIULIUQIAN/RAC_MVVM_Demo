//
//  ViewController.m
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//


#import "HttpManager.h"
#import "AFNetworking.h"

@implementation HttpManager

+ (void)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 自定义请求，为JSON格式
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 自定义响应
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    mgr.responseSerializer = responseSerializer;
    
    [mgr POST:URLString parameters:parameters progress:nil success:success failure:failure];
    
}

@end
