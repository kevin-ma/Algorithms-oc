//
//  KWIntArrayBuilder.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWIntArrayBuilder.h"

@implementation KWIntArrayBuilder

- (instancetype)init
{
    if (self = [super init]) {
        _defaultMin = 0;
        _defaultMax = 1000;
        _defaultCount = 10000;
    }
    return self;
}

- (NSArray *)randomArray
{
    return [self randomArrayFrom:_defaultMin to:_defaultMax andCount:_defaultCount];
}

- (NSArray *)randomArrayWithCount:(NSUInteger)count
{
    return [self randomArrayFrom:_defaultMin to:_defaultMax andCount:count];
}

- (NSArray *)randomArrayFrom:(NSUInteger)from to:(NSUInteger)to
{
    return [self randomArrayFrom:from to:to andCount:_defaultCount];
}

- (NSArray *)randomArrayFrom:(NSUInteger)from to:(NSUInteger)to andCount:(NSUInteger)count
{
    if (from > to) {
        return nil;
    }
    NSMutableArray *temp = [@[] mutableCopy];
    for (NSInteger i = 0; i < count; i++) {
        NSInteger value = arc4random() % (to - from) + from;
        BOOL exist = NO;
        if (_unique) {
            if ([temp containsObject:@(value)]) {
                exist = YES;
            }
        }
        if (!exist) {
            [temp addObject:@(value)];
        } else {
            i--;
        }
    }
    return [temp copy];
}


@end
