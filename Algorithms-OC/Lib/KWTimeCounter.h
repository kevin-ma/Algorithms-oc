//
//  KWTimeCounter.h
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWTimeCounter : NSObject

- (id)timeCountWithTitle:(NSString *)title forAction:(id (^)())action;

- (id)timeCountWithTitle:(NSString *)title time:(NSTimeInterval*)time forAction:(id (^)())action;

@end
