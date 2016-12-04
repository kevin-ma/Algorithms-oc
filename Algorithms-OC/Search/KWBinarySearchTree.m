//
//  KWBinarySearchTree.m
//  Algorithms-OC
//
//  Created by 凯文马 on 2016/12/4.
//  Copyright © 2016年 makaiwen. All rights reserved.
//

#import "KWBinarySearchTree.h"

KWTreeNode *KWTreeNodeMake(int key,int value)
{
    KWTreeNode *node = malloc(sizeof(KWTreeNode));
    node->left = NULL;
    node->right = NULL;
    node->key = key;
    node->value = value;
    return node;
}

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

- (NSInteger)size
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

@end
