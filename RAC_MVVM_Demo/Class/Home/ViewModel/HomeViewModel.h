//
//  HomeViewModel.h
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject{
    RACCommand *_loadDataCommand;
}

@property (nonatomic, strong,readonly) RACCommand *loadDataCommand;
    
-(void)bindViewModel:(UITableView *)bindView;

@end


NS_ASSUME_NONNULL_END
