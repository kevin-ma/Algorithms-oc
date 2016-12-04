//
//  KWBinarySearchTree.h
//  Algorithms-OC
//
//  Created by 凯文马 on 2016/12/4.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct KWTreeNode {
    struct KWTreeNode *left;
    struct KWTreeNode *right;
    int key;
    int value;
} KWTreeNode;

KWTreeNode *KWTreeNodeMake(int key,int value);

@interface KWBinarySearchTree : NSObject

- (NSInteger)size;

- (BOOL)isEmpty;

- (int *)minValue;

- (int *)maxValue;

- (void)insertValue:(int)value forKey:(int)key;

- (int *)getValueForKey:(int)key;

@end
