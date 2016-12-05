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

KWTreeNode *KWTreeNodeCopy(KWTreeNode *aNode);

@interface KWBinarySearchTree : NSObject

- (int)size;

- (BOOL)isEmpty;

- (int *)minValue;

- (int *)maxValue;

/** 前序遍历 */
- (NSArray *)DLRTraversal;

/** 中序遍历 */
-(NSArray *)LDRTraversal;

/** 后序遍历 */
- (NSArray *)LRDTraversal;

- (NSArray *)LevelTraversal;

- (void)insertValue:(int)value forKey:(int)key;

- (int *)getValueForKey:(int)key;


/** 删除*/
- (void)deleteValue:(int)value;

@end
