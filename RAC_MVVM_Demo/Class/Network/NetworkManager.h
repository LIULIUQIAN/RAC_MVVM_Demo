//
//  ViewController.m
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

/**
    获取首页参数
 */
+ (NSDictionary *)paramWithHome;


/**
    获取首页URL
 */
+ (NSString *)urlWithHome;


@end
