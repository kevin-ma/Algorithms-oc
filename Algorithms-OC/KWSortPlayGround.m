//
//  KWSortPlayGround.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWSortPlayGround.h"
#import "KWIntArrayBuilder.h"
#import "KWSortAlgorithms.h"

@interface KWSortPlayGround ()

@property (nonatomic, strong) KWIntArrayBuilder *arrayBuilder;

@property (nonatomic, strong) KWSortAlgorithms *sorter;

@end

@implementation KWSortPlayGround

- (void)play
{
    self.sorter.array = [self.arrayBuilder randomArrayFrom:0 to:1000 andCount:10000];
    NSTimeInterval time = 0;
    NSArray *result = nil;
    @weakify(self);
    /* 选择排序 */
    result = [self.timeCounter timeCountWithTitle:@"选择排序" time:&time forAction:^id{
        @strongify(self);
        return [self.sorter selectionSort];
    }];
    [self showResult:[self.sorter isRightWithResult:result]];
    
    /* 冒泡排序 */
    result = [self.timeCounter timeCountWithTitle:@"冒泡排序" time:&time forAction:^id{
        @strongify(self);
        return [self.sorter bubbleSort];
    }];
    [self showResult:[self.sorter isRightWithResult:result]];
}

- (void)showResult:(BOOL)result
{
    NSLog(@"%@",result ? @"结果正确" : @"结果错误");
}

#pragma mark - getter
- (KWIntArrayBuilder *)arrayBuilder
{
    if (!_arrayBuilder) {
        _arrayBuilder = [[KWIntArrayBuilder alloc] init];
    }
    return _arrayBuilder;
}

- (KWSortAlgorithms *)sorter
{
    if (!_sorter) {
        _sorter = [[KWSortAlgorithms alloc] init];
    }
    return _sorter;
}


@end
