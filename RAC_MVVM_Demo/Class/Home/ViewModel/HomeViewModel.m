//
//  HomeViewModel.m
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//

#import "HomeViewModel.h"
#import "HttpManager.h"
#import "NetworkManager.h"
#import "HomeRecommendItem.h"
#import "MJExtension.h"
#import "HomeRecommendCell.h"
#import "HomeCellViewModel.h"

static NSString * const CELLID = @"homeCellId";

@interface HomeViewModel()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation HomeViewModel
    
-(RACCommand *)loadDataCommand{
    
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [HttpManager POST:[NetworkManager urlWithHome] parameters:[NetworkManager paramWithHome] progress:^(NSProgress *progress) {
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *result = responseObject[@"result"];
                NSDictionary *recommendsDict = result[@"recommends"];
                NSArray *recommends = [HomeRecommendItem mj_objectArrayWithKeyValuesArray:recommendsDict[@"courses"]];
                
                self.dataSourceArray = [[recommends.rac_sequence map:^id _Nullable(id  _Nullable value) {
                    HomeCellViewModel *model = [[HomeCellViewModel alloc] init];
                    model.item = value;
                    return model;
                }] array];
                
                [subscriber sendNext:recommends];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [subscriber sendError:error];
            }];
            
            return nil;
        }];
    }];
}
    
#pragma mark - UITableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    HomeCellViewModel *cellViewModel = self.dataSourceArray[indexPath.row];
    [cellViewModel bindViewModel:cell];

    return cell;
}

-(void)bindViewModel:(UITableView *)bindView{
    
    bindView.delegate = self;
    bindView.dataSource = self;
    [bindView registerNib:[UINib nibWithNibName:@"HomeRecommendCell" bundle:nil] forCellReuseIdentifier:CELLID];
}

@end
