//
//  KWTimeCounter.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWTimeCounter.h"
#include <time.h>

@implementation KWTimeCounter

- (id)timeCountWithTitle:(NSString *)title forAction:(id (^)())action
{
    return [self timeCountWithTitle:title time:nil forAction:action];
}

- (id)timeCountWithTitle:(NSString *)title time:(NSTimeInterval *)time forAction:(id (^)())action
{
    id obj = nil;
    clock_t start = clock();
    if (action) {
        obj = action();
    }
    clock_t end = clock();
    
    NSTimeInterval use = (end - start) * 0.1 / CLOCKS_PER_SEC;
    use = MAX(use, 0);
    NSLog(@"《%@》操作用时:%.4fs",title,use);
    if (time) {
        *time = use;
    }
    return obj;
}
@end
