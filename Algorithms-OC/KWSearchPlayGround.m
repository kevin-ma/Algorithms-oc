//
//  KWSearchGround.m
//  Algorithms-OC
//
//  Created by 凯文马 on 2016/12/4.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWSearchPlayGround.h"
#import "KWIntArrayBuilder.h"
#import "KWSortAlgorithms.h"
#import "KWBinarySearchTree.h"

@interface KWSearchPlayGround ()

@property (nonatomic, strong) KWIntArrayBuilder *arrayBuilder;

@end

@implementation KWSearchPlayGround

- (void)play
{
    NSInteger count = 10000;
    NSArray *array = [self.arrayBuilder randomArrayFrom:0 to:1000 andCount:count];
    
    // 二分查找
    KWSortAlgorithms *sort = [[KWSortAlgorithms alloc] init];
    sort.array = array;
    NSArray * sortArray = [sort rightSort];
    
    NSInteger randomIndex = arc4random() % array.count;
    
    NSArray *values = @[sortArray[randomIndex],@(count + 1)];

    for (NSNumber *indexObj in values) {
        NSNumber *searchindexObj = [self.timeCounter timeCountWithTitle:@"二分查找" forAction:^id{
            return @([self binarySearchFromList:sortArray withValue:[indexObj integerValue]]);
        }];
        NSInteger searchIndex = searchindexObj.integerValue;
        
        if (searchIndex == NSNotFound) {
            if (indexObj.integerValue > count) {
                NSLog(@"查找正确：无");
            } else {
                NSLog(@"查找出错：有");
            }
        } else if ([sortArray[searchIndex] integerValue] == indexObj.integerValue) {
            NSLog(@"查找正确：%ld",(long)searchIndex);
        } else {
            NSLog(@"查找出错：%ld-%ld",(long)[sortArray[searchIndex] integerValue],(long)indexObj.integerValue);
        }
    }
    
    array = @[@64,@53,@60,@49,@78,@75,@93,@70];
    
    // 二分搜索树查找
    for (NSNumber *indexObj in values) {
        KWBinarySearchTree *tree = [[KWBinarySearchTree alloc] init];
        NSNumber *value = [self.timeCounter timeCountWithTitle:@"二分搜索树查找" forAction:^id{
            for (NSNumber *valueObj in array) {
                int key = valueObj.intValue;
                int val = valueObj.intValue + 10;
                [tree insertValue:val forKey:key];
            }
            int *res = [tree getValueForKey:[indexObj intValue]];
            if (res == NULL) {
                return nil;
            }
            int r = *res;
            return  @(r);
        }];
        if (!value) {
            if (indexObj.integerValue > count) {
                NSLog(@"查找正确：无");
            } else {
                NSLog(@"查找出错：有");
            }
        } else if (value.integerValue - 10 == indexObj.integerValue) {
            NSLog(@"查找正确：%ld",(long)indexObj.integerValue);
        } else {
            NSLog(@"查找出错：%ld-%ld",(long)indexObj.integerValue,(long)(value.integerValue - 10));
        }
    }
    
    // 查找最大值 && 查找最小值
    KWBinarySearchTree *tree = [[KWBinarySearchTree alloc] init];
    for (NSNumber *valueObj in array) {
        int key = valueObj.intValue;
        int val = valueObj.intValue;
        [tree insertValue:val forKey:key];
    }
    int max = *([tree maxValue]);
    int min = *([tree minValue]);
    NSLog(max == [sortArray.lastObject intValue] ? @"最大值正确" : @"最大值有误");
    NSLog(min == [sortArray.firstObject intValue] ? @"最小值正确" : @"最小值有误");
    
    // 遍历
    [self logArray:array withTitle:@"原始"];
    NSArray *orderList;
    orderList = [tree DLRTraversal];
    [self logArray:orderList withTitle:@"前序"];
    orderList = [tree LDRTraversal];
    [self logArray:orderList withTitle:@"中序"];
    orderList = [tree LRDTraversal];
    [self logArray:orderList withTitle:@"后序"];
    orderList = [tree LevelTraversal];
    [self logArray:orderList withTitle:@"层序"];
}

// 二分查找
- (NSInteger)binarySearchFromList:(NSArray *)list withValue:(NSInteger)value
{
    NSInteger left = 0;
    NSInteger right = list.count - 1;
    while (left <= right) {
        NSInteger mid = (right - left) / 2 + left;
        NSInteger midV = [list[mid] integerValue];
        if (midV == value) {
            return mid;
        } else if (midV > value) {
            right = mid - 1;
        } else if (midV < value) {
            left = mid + 1;
        }
    }
    return NSNotFound;
}

- (void)logArray:(NSArray *)array withTitle:(NSString *)title
{
    NSLog(@"%@:%@",title,[array componentsJoinedByString:@","]);
}

#pragma mark - getter
- (KWIntArrayBuilder *)arrayBuilder
{
    if (!_arrayBuilder) {
        _arrayBuilder = [[KWIntArrayBuilder alloc] init];
    }
    return _arrayBuilder;
}
@end
