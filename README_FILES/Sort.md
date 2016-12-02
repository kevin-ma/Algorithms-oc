# 算法大练兵 - 排序算法

## 简述

排序算法时算法中相对简单的算法，所以我在这次复习中，首先从排序算法下手。收集到的排序算法有 *选择排序*、*冒泡排序*、*插入排序*、*归并排序*、*快速排序*、*堆排序*。

|排序|时间复杂度|稳定性|备注|
|---|----|----|---|
|选择排序|O(n2)|稳定||
|冒泡排序|O(n2)|稳定||
|插入排序|O(n2)|稳定|可以用于辅助排序|
|归并排序|O(n*log2n)|不稳定||
|快速排序|O(n*log2n)|不稳定|优化空间很大|
|堆排序|O(n*log2n)|不稳定||

在存储空间越来越廉价的今天，我们一般使用时间复杂度来判断一个算法的优劣，而很少去考虑空间复杂度，除非在一些空间成为瓶颈的地方。虽然可以从表中对这些排序算法排出优劣，但是在使用中还是要根据我们使用的地方去选择合适的算法，例如：快速排序快于插入排序，但是应用在一个近似有序的数据中，插入排序却更快于快速排序。

## 算法解说

默认按照从小到大排序整数

#### 选择排序

###### 思想

对比数组中前一个元素跟后一个元素的大小，如果后面的元素比前面的元素小则用一个变量k来记住他的位置，接着第二次比较，前面“后一个元素”现变成了“前一个元素”，继续跟他的“后一个元素”进行比较如果后面的元素比他要小则用变量k记住它在数组中的位置(下标)，等到循环结束的时候，我们应该找到了最小的那个数的下标了，然后进行判断，如果这个元素的下标不是第一个元素的下标，就让第一个元素跟他交换一下值，这样就找到整个数组中最小的数了。然后找到数组中第二小的数，让他跟数组中第二个元素交换一下值，以此类推。

###### 代码

```
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
```

#### 冒泡排序

###### 思想

比较相邻的元素。如果第一个比第二个大，就交换他们两个。对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。针对所有的元素重复以上的步骤，除了最后一个。持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。

###### 代码

```
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
```

#### 插入排序

###### 思想

和我们打牌时码牌差不多。<br>
⒈ 从第一个元素开始，该元素可以认为已经被排序<br>
⒉ 取出下一个元素，在已经排序的元素序列中从后向前扫描<br>
⒊ 如果该元素（已排序）大于新元素，将该元素移到下一位置<br>
⒋ 重复步骤3，直到找到已排序的元素小于或者等于新元素的位置<br>
⒌ 将新元素插入到下一位置中<br>
⒍ 重复步骤2~5<br>

###### 代码

```
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
```

#### 归并排序

###### 思想

先将待排序的序列从中间分割，再将子序列从中间分割，如此反复，直到足够少的数量（足够少根据实际情况决定，可以再足够少之后采用其他算法），然后再将这些子序列一层一层向上合并，关键点就是在合并的过程中。（需要用到递归思想）

###### 代码

```
- (NSArray *)mergeSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    // 取出数据的范围，然后进入递归中
    [self _mergeSortWithArray:tempArray left:0 right:tempArray.count - 1];
    return [tempArray copy];
}


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
```

#### 快速排序

###### 思想

先指定一个元素，一般取第一个（不过为了避免近似有序序列神马的，我们可以随机取，然后换到第一个位置），然后遍历一遍，比他大的一组，比他小的（或含相等的，或者再分一组相等的）一组，然后再把这些分组再取一个元素分组，以此达到整个数据变成有序序列。

###### 代码

```
- (NSArray *)quickSort
{
    NSMutableArray *tempArray = [_array mutableCopy];
    [self _quickSortWithArray:tempArray left:0 right:tempArray.count - 1];
    return [tempArray copy];
}

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
```

#### 堆排序

###### 思想

是应用最大堆（最小堆）实现的一种排序方法，所谓最大堆就是一种完全二叉树，满足父节点的值大于（含等于）它的左右子节点的值。按照从上层至下层的顺序可以将最大堆用数据的形式保存，那么它的每一组父节点与子节点在索引上都存在一定的关系。如果我们向堆中添加元素，那么它可能不再是一个最大堆，但是我们利用上面提到的这种关系可以快速将这个元素放到合适的位置，从而使其再次成为最大堆，移除元素同理。综上我们可以利用最大堆的这个性质完成对一个序列的排序，而且还可以实现优先队列。

###### 代码

新建最大堆类，以动态调整结构，使其满足最大堆特性。

```
#import "KWMaxHeap.h"

@interface KWMaxHeap ()

@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation KWMaxHeap

- (instancetype)init
{
    if (self = [super init]) {
        _list = [@[] mutableCopy];
    }
    return self;
}

- (void)addItem:(NSInteger)item
{
    [self.list addObject:@(item)];
    [self shiftUpFromIndex:self.list.count - 1];
}

- (NSInteger)extractMaxItem
{
    if (self.list.count > 0) {
        NSInteger value = [self.list[0] integerValue];
        [self.list exchangeObjectAtIndex:0 withObjectAtIndex:self.list.count - 1];
        [self.list removeLastObject];
        [self shiftDownFromIndex:0];
        return value;
    }
    return -1;
}

- (void)shiftUpFromIndex:(NSInteger)index
{
    while (index > 0 && self.list[(index - 1) / 2] < self.list[index]) {
        [self.list exchangeObjectAtIndex:(index - 1) / 2 withObjectAtIndex:index];
        index = (index - 1) / 2;
    }
}

- (void)shiftDownFromIndex:(NSInteger)index
{
    while (index * 2 + 1 < self.list.count) {
        NSInteger sub = index * 2 + 1;
        if (sub + 1 < self.list.count && self.list[sub + 1] > self.list[sub]) {
            sub++;
        }
        if (self.list[index] < self.list[sub]) {
            [self.list exchangeObjectAtIndex:index withObjectAtIndex:sub];
        }
        index = sub;
    }
}

@end
```

有了以上的最大堆类的添加元素和删除元素的方法，就可以很容易完成排序，只要把元素加到堆中，在逆向保存到数组即可。

```
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
```

#### 运行结果

以下结果以 0 ~ 1000 为取值范围，取 10000 个元素作为测试对象。

```
2016-12-01 16:06:40.591399 Algorithms-OC[26494:6351111] 准备在 KWSortPlayGround 操练场操练。。。
2016-12-01 16:06:43.170962 Algorithms-OC[26494:6351111] 《选择排序》操作用时:0.2569s
2016-12-01 16:06:43.171497 Algorithms-OC[26494:6351111] 结果正确
2016-12-01 16:06:46.909183 Algorithms-OC[26494:6351111] 《冒泡排序》操作用时:0.3736s
2016-12-01 16:06:46.909714 Algorithms-OC[26494:6351111] 结果正确
2016-12-01 16:09:39.767090 Algorithms-OC[26494:6351111] 《快速排序》操作用时:0.0017s
2016-12-01 16:09:39.767610 Algorithms-OC[26494:6351111] 结果正确
2016-12-01 16:09:41.009479 Algorithms-OC[26494:6351111] 《插入排序》操作用时:0.1241s
2016-12-01 16:09:41.010029 Algorithms-OC[26494:6351111] 结果正确
2016-12-01 16:09:41.027716 Algorithms-OC[26494:6351111] 《归并排序》操作用时:0.0018s
2016-12-01 16:09:41.028249 Algorithms-OC[26494:6351111] 结果正确
Program ended with exit code: 0
```

更多测试可以运行工程文件自行测试。