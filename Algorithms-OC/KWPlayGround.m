//
//  KWPalyGround.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWPlayGround.h"

@interface KWPlayGround ()

@end

@implementation KWPlayGround

- (void)play
{
    NSLog(@"\n%@ 没有操练队列",NSStringFromClass([self class]));
}

- (KWTimeCounter *)timeCounter
{
    if (!_timeCounter) {
        _timeCounter = [[KWTimeCounter alloc] init];
    }
    return _timeCounter;
}
@end
