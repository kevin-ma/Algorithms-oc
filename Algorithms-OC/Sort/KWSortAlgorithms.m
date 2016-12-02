//
//  KWSortAlgorithms.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWSortAlgorithms.h"
#import "KWMaxHeap.h"

@interface KWSortAlgorithms ()

@property (nonatomic, strong) NSArray *rightSort;

@end

@implementation KWSortAlgorithms

- (void)setArray:(NSArray *)array
{
    _array = [array copy];
    _rightSort = [self _rightSort];
}

- (NSArray *)selectionSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    // 循环，i就是目前要把元素放到的位置的索引
    for (NSInteger i = 0; i < _array.count; i++) {
        // 假定第一个是最小的
        NSInteger minIndex = i;
        // 对比从其他的数据中选择最小的
        for (NSInteger j = i + 1; j < _array.count; j++) {
            if ([tempArray[minIndex] integerValue] > [tempArray[j] integerValue]) {
                minIndex = j;
            }
        }
        // 将最小的元素放到i位置，即交换
        [tempArray exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    return [tempArray copy];
}

- (NSArray *)bubbleSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    // 两遍循环 比对两个相邻的元素的大小，如果不符合预期，则更换位置
    for (NSInteger i = 0; i < _array.count; i++) {
        for (NSInteger j = 0; j < _array.count - i - 1; j++) {
            if ([tempArray[j] integerValue] > [tempArray[j + 1] integerValue]) {
                [tempArray exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    return [tempArray copy];
}

- (NSArray *)heapSort
{
    KWMaxHeap *heap = [[KWMaxHeap alloc] init];
    for (NSNumber *item in _array) {
        [heap addItem:[item integerValue]];
    }
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_array];
    for (NSInteger i = temp.count - 1; i >=0; i--) {
        NSInteger v = [heap extractMaxItem];
        temp[i] = @(v);
    }
    return [temp copy];
}

- (NSArray *)quickSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    [self _quickSortWithArray:tempArray left:0 right:tempArray.count - 1];
    return [tempArray copy];
}

- (NSArray *)mergeSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    // 取出数据的范围，然后进入递归中
    [self _mergeSortWithArray:tempArray left:0 right:tempArray.count - 1];
    return [tempArray copy];
}

- (NSArray *)insertSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    // i 操作的元素的开始位置
    for (NSInteger i = 1; i < tempArray.count; i++) {
        // i 前面为排好的序列，j是开始在i位置的元素目前移动到的位置
        for (NSInteger j = i; j > 0; j--) {
            // 如果前面的元素比他大，就让他位置往前移动
            if (tempArray[j] < tempArray[j - 1]) {
                [tempArray exchangeObjectAtIndex:j withObjectAtIndex:j - 1];
            }
        }
    }
    return [tempArray copy];
}

- (NSString *)isRightWithResult:(NSArray *)result
{
    NSArray *array = [self rightSort];
    if (result.count != _array.count) {
        return @"数量不符";
    }
    for (NSInteger i = 0; i < array.count; i++) {
        if (result[i] != array[i]) {
            return [NSString stringWithFormat:@"索引:%ld 数值:%ld->%ld",(long)i,(long)[array[i] integerValue],(long)[result[i] integerValue]];
        }
    }
    return nil;
}

# pragma mark - 私有方法
# pragma mark 三路快速排序
- (void)_quickSortWithArray:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right
{
    if (left >= right) {
        return;
    }
    // 随机选一个index，然后和最左侧的交换，以避免数组过于有序
    [array exchangeObjectAtIndex:left withObjectAtIndex:arc4random() % (right - left + 1) + left];
    
    NSInteger index = left + 1;
    /* 等于的起始位置，不包含 */
    NSInteger lt = left;
    /* 等于的结束位置，不包含 */
    NSInteger gt = right + 1;
    while (index < gt) {
        if ([array[index] integerValue] > [array[left] integerValue]) {
            [array exchangeObjectAtIndex:index withObjectAtIndex:--gt];
        } else if ([array[index] integerValue] < [array[left] integerValue]) {
            [array exchangeObjectAtIndex:index++ withObjectAtIndex:++lt];
        } else {
            index++;
        }
    }
    [array exchangeObjectAtIndex:lt withObjectAtIndex:left];
    [self _quickSortWithArray:array left:left right:lt - 1];
    [self _quickSortWithArray:array left:gt right:right];
}

#pragma mark 归并排序
- (void)_mergeSortWithArray:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right
{
    if (left >= right) return;
    // 取出中间位置，用于分割成两个子序列
    NSInteger mid = (left + right) / 2;
    // 分成左右两部分，然后再进行分割，如此递归循环
    [self _mergeSortWithArray:array left:left right:mid];
    [self _mergeSortWithArray:array left:mid + 1 right:right];
    // 最后将分割的子序列一层一层合并
    [self _mergeWithArray:array left:left mid:mid right:right];
}

- (void)_mergeWithArray:(NSMutableArray *)array left:(NSInteger)left mid:(NSInteger)mid right:(NSInteger)right
{
    // 先创建一个和待处理的数组相同的数据，只需要从 left 到 right
    NSMutableArray *temp = [[array subarrayWithRange:NSMakeRange(left, right - left + 1)] mutableCopy];
    // i 表示前半部分子序列游标
    NSInteger i = left;
    // j 表示后半部分子序列游标
    NSInteger j = mid + 1;
    // k 表示父序列游标
    for (NSInteger k = left; k <= right; k++) {
        if (i > mid) {
            array[k] = temp[j - left];
            j++;
        } else if (j > right) {
            array[k] = temp[i - left];
            i++;
        } else if ([temp[i - left] integerValue] < [temp[j - left] integerValue]) {
            array[k] = temp[i - left];
            i++;
        } else {
            array[k] = temp[j - left];
            j++;
        }
    }
}

#pragma mark 正确排序
- (NSArray *)_rightSort
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
@end
