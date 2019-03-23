//
//  HomeCellViewModel.h
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HomeRecommendItem.h"
#import "HomeRecommendCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCellViewModel : NSObject
    
@property (nonatomic, strong)HomeRecommendItem *item;
    
-(void)bindViewModel:(HomeRecommendCell *)bindView;

@end

NS_ASSUME_NONNULL_END
