//
//  KWPalyGround.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWPalyGround.h"

@interface KWPalyGround ()

@end

@implementation KWPalyGround

- (void)play
{
    NSLog(@"\n%@目前闲置",NSStringFromClass([self class]));
}

- (KWTimeCounter *)timeCounter
{
    if (!_timeCounter) {
        _timeCounter = [[KWTimeCounter alloc] init];
    }
    return _timeCounter;
}
@end
