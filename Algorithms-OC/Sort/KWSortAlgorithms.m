//
//  KWSortAlgorithms.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWSortAlgorithms.h"

@interface KWSortAlgorithms ()

@end

@implementation KWSortAlgorithms

- (void)setArray:(NSArray *)array
{
    _array = [array copy];
    
}

- (NSArray *)rightSort
{
    NSArray *temp = [_array copy];
    temp = [temp sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSInteger a = [obj1 integerValue];
        NSInteger b = [obj2 integerValue];
        if (a < b)  return NSOrderedAscending;
        if (a == b) return NSOrderedSame;
        if (a > b) return NSOrderedDescending;
        return NSOrderedSame;
    }];
    return temp;
}

- (NSArray *)selectionSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    for (NSInteger i = 0; i < _array.count; i++) {
        NSInteger minIndex = i;
        for (NSInteger j = i + 1; j < _array.count; j++) {
            if ([tempArray[minIndex] integerValue] > [tempArray[j] integerValue]) {
                minIndex = j;
            }
        }
        [tempArray exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    return [tempArray copy];
}

- (NSArray *)bubbleSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    for (NSInteger i = 0; i < _array.count; i++) {
        for (NSInteger j = 0; j < _array.count - i - 1; j++) {
            if ([tempArray[j] integerValue] > [tempArray[j+1] integerValue]) {
                [tempArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return [tempArray copy];
}

- (NSArray *)heapSort
{
    return nil;
}

- (NSArray *)quickSort
{
    return nil;
}

- (NSArray *)mergeSort
{
    return nil;
}

- (NSArray *)insertSort
{
    return nil;
}

- (BOOL)isRightWithResult:(NSArray *)result
{
    NSArray *array = [self rightSort];
    if (result.count != _array.count) {
        return NO;
    }
    for (NSInteger i = 0; i < array.count; i++) {
        if (result[i] != array[i]) {
            return NO;
        }
    }
    return YES;
}

@end
