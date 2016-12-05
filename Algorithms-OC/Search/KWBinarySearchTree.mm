//
//  KWBinarySearchTree.m
//  Algorithms-OC
//
//  Created by 凯文马 on 2016/12/4.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWBinarySearchTree.h"
#import "KWQueue.h"

KWTreeNode *KWTreeNodeMake(int key,int value)
{
    KWTreeNode *node = (KWTreeNode *)malloc(sizeof(KWTreeNode));
    node->left = NULL;
    node->right = NULL;
    node->key = key;
    node->value = value;
    return node;
}

typedef enum : NSUInteger {
    KWTreeNodeTraversalDLR,
    KWTreeNodeTraversalLDR,
    KWTreeNodeTraversalLRD,
} KWTreeNodeTraversal;

@interface KWBinarySearchTree ()

@property (nonatomic, assign) KWTreeNode *root;

@property (nonatomic, assign) int count;

@end

@implementation KWBinarySearchTree

- (void)insertValue:(int)value forKey:(int)key
{
    self.root = [self insertFromNode:self.root withKey:key andValue:value];
}

- (int *)getValueForKey:(int)key;
{
    return [self searchFromNode:self.root withKey:key];
}

- (int *)minValue
{
    KWTreeNode *node = self.root;
    while (node->left) {
        node = node->left;
    }
    return &node->value;
}

- (int *)maxValue
{
    KWTreeNode *node = self.root;
    while (node->right) {
        node = node->right;
    }
    return &node->value;
}

# pragma mark - 遍历

/** 前序遍历 */
- (NSArray *)DLRTraversal
{
    NSMutableArray *temp = [@[] mutableCopy];
    [self traversalWithType:KWTreeNodeTraversalDLR fromNode:self.root toList:temp];
    return [temp copy];
}

/** 中序遍历 */
-(NSArray *)LDRTraversal
{
    NSMutableArray *temp = [@[] mutableCopy];
    [self traversalWithType:KWTreeNodeTraversalLDR fromNode:self.root toList:temp];
    return [temp copy];
}

/** 后序遍历 */
- (NSArray *)LRDTraversal
{
    NSMutableArray *temp = [@[] mutableCopy];
    [self traversalWithType:KWTreeNodeTraversalLRD fromNode:self.root toList:temp];
    return [temp copy];
}

- (NSArray *)LevelTraversal
{
    NSMutableArray *temp = [@[] mutableCopy];
    [self levelTraversalFromNode:self.root toList:temp];
    return [temp copy];
}

# pragma mark 其他属性
- (int)size
{
    return _count;
}

- (BOOL)isEmpty
{
    return _count == 0;
}

#pragma mark - private
- (KWTreeNode*)insertFromNode:(KWTreeNode *)node withKey:(int)key andValue:(int)value
{
    if (node == NULL) {
        self.count++;
        return KWTreeNodeMake(key, value);
    }
    if (key == node->key) {
        node->value = value;
    } else if (key < node->key) {
        node->left = [self insertFromNode:node->left withKey:key andValue:value];
    } else if (key > node->key) {
        node->right = [self insertFromNode:node->right withKey:key andValue:value];
    }
    return node;
}

- (int *)searchFromNode:(KWTreeNode *)node withKey:(int)key
{
    if (node == NULL) {
        return NULL;
    }
    if (key == node->key) {
        return &(node->value);
    } else if (key > node->key) {
        return [self searchFromNode:node->right withKey:key];
    } else if (key < node->key) {
        return [self searchFromNode:node->left withKey:key];
    }
    return NULL;
}

- (void)traversalWithType:(KWTreeNodeTraversal)type fromNode:(KWTreeNode *)node toList:(NSMutableArray *)list
{
    if (node == NULL) {
        return;
    }
    if (type == KWTreeNodeTraversalDLR) {
        [list addObject:@(node->value)];
    }
    if (node->left) {
        [self traversalWithType:type fromNode:node->left toList:list];
    }
    if (type == KWTreeNodeTraversalLDR) {
        [list addObject:@(node->value)];
    }
    if (node->right) {
        [self traversalWithType:type fromNode:node->right toList:list];
    }
    if (type == KWTreeNodeTraversalLRD) {
        [list addObject:@(node->value)];
    }
}

- (void)levelTraversalFromNode:(KWTreeNode *)node toList:(NSMutableArray *)list
{
    if (node == NULL) {
        return;
    }
    queue<KWTreeNode *> queue;
    queue.push(node);
    while (!queue.empty()) {
        KWTreeNode *aNode = queue.front();
        [list addObject:@(aNode->value)];
        queue.pop();
        if (aNode->left) {
            queue.push(aNode->left);
        }
        if (aNode->right) {
            queue.push(aNode->right);
        }
    }
}

@end
