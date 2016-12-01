//
//  KWSortAlgorithms.h
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWSortAlgorithms : NSObject

@property (nonatomic, copy) NSArray *array;

/* 选择排序 */
- (NSArray *)selectionSort;

/* 冒泡排序 */
- (NSArray *)bubbleSort;

/* 插入排序 */
- (NSArray *)insertSort;

/* 归并排序 */
- (NSArray *)mergeSort;

/* 堆排序 */
- (NSArray *)heapSort;

/* 快速排序 */
- (NSArray *)quickSort;

/* 检查结果是否正确，nil表示正确 */
- (NSString *)isRightWithResult:(NSArray *)result;

/* 正确的排序结果 */
- (NSArray *)rightSort;

@end
