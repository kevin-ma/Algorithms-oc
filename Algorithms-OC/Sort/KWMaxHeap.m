//
//  KWMaxHeap.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/12/2.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

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
