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
//    self.sorter.array = @[@30,@20,@34,@32,@54,@33,@12,@35,@43,@46,@23,@42];
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
    
    /* 快速排序 */
    result = [self.timeCounter timeCountWithTitle:@"快速排序" time:&time forAction:^id{
        @strongify(self);
        return [self.sorter quickSort];
    }];
    [self showResult:[self.sorter isRightWithResult:result]];
    
    /* 插入排序 */
    result = [self.timeCounter timeCountWithTitle:@"插入排序" time:&time forAction:^id{
        @strongify(self);
        return [self.sorter insertSort];
    }];
    [self showResult:[self.sorter isRightWithResult:result]];
    
    /* 归并排序 */
    result = [self.timeCounter timeCountWithTitle:@"归并排序" time:&time forAction:^id{
        @strongify(self);
        return [self.sorter mergeSort];
    }];
    [self showResult:[self.sorter isRightWithResult:result]];
    //    NSArray *right = [self.sorter rightSort];
//    for (NSInteger i = 0; i < result.count; i++) {
//        NSString *log = [NSString stringWithFormat:@"%@---%@",right[i],result[i]];
//        if ([right[i] integerValue] != [result[i] integerValue]) {
//            log = [log stringByAppendingString:@"有问题"];
//        }
//        NSLog(@"%@",log);
//    }
}

- (void)showResult:(NSString *)result
{
    if (!result) {
        NSLog(@"结果正确");
    } else {
        NSLog(@"结果错误:%@",result);
    }
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
