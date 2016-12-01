//
//  KWIntArrayBuilder.h
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWIntArrayBuilder : NSObject

@property (nonatomic, assign) NSUInteger defaultMin;

@property (nonatomic, assign) NSUInteger defaultMax;

@property (nonatomic, assign) NSUInteger defaultCount;

- (NSArray *)randomArrayWithCount:(NSUInteger)count;

- (NSArray *)randomArrayFrom:(NSUInteger)from to:(NSUInteger)to;

- (NSArray *)randomArrayFrom:(NSUInteger)from to:(NSUInteger)to andCount:(NSUInteger)count;


@end
