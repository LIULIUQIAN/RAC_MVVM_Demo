//
//  ViewController.m
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewModel.h"

@interface ViewController ()

@property (nonatomic, strong) HomeViewModel *homeVM;

@end

@implementation ViewController

-(HomeViewModel *)homeVM{
    if (_homeVM == nil) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.homeVM bindViewModel:self.tableView];
    
    @weakify(self)
    [[self.homeVM.loadDataCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.tableView reloadData];
    } error:^(NSError * _Nullable error) {
        NSLog(@"error = %@",error.localizedDescription);
    }];
    

}

@end
