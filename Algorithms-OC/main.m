//
//  main.m
//  Algorithms-OC
//
//  Created by chi_yu on 2016/11/30.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KWPalyGround.h"
#import <objc/runtime.h>

NSArray *subclassOfClass(Class class);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *playGrounds = subclassOfClass([KWPalyGround class]);
        for (Class playGround in playGrounds) {
            
            [[[playGround alloc] init] play];
        }
        
    }
    return 0;
}

NSArray *subclassOfClass(Class class)
{
    NSMutableArray *subClass = [@[] mutableCopy];
    unsigned int numCls;
    Class *classes = objc_copyClassList(&numCls);
    for (unsigned int ci = 0; ci < numCls; ci++) {
        Class superClass = classes[ci];
        do {
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != class);
        if (superClass) {
            [subClass addObject:classes[ci]];
        }
    }
    free(classes);
    return subClass;
}
