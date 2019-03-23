//
//  HomeCellViewModel.m
//  RAC_MVVM_Demo
//
//  Created by Liuliuqian on 2019/3/23.
//  Copyright © 2019年 LLQ. All rights reserved.
//

#import "HomeCellViewModel.h"
#import "UIImageView+WebCache.h"

@implementation HomeCellViewModel

    
-(void)bindViewModel:(HomeRecommendCell *)bindView{
    
    NSString *imageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553334682780&di=3e50226c8c4f6fa57fc8983821cb668d&imgtype=0&src=http%3A%2F%2Fp1.qhimgs4.com%2Ft01480c7e09aa18169a.jpg";
    [bindView.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    bindView.nameView.text = self.item.courseName;
    [bindView.numView setTitle:self.item.studentNum forState:UIControlStateNormal];
}
@end
