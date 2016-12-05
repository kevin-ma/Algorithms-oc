# 算法大练兵 - 二叉搜索树

## 简述

二叉搜索树，又称为二叉排序树，好像还有其他名字，浮云，略过。

二叉搜索树或者是一棵空树，或者是具有下列性质的二叉树：<br>
	（1）若左子树不空，则左子树上所有结点的值均小于它的根结点的值；<br>
	（2）若右子树不空，则右子树上所有结点的值均大于或等于它的根结点的值；<br>
	（3）左、右子树也分别为二叉搜索树；<br>
	
二叉搜索树不同于前面说过的最大数，二叉搜索树不一定是完全二叉树。

以下内容主要围绕下面一些内容展开：

* 二分查找法
* 二分搜索树的查找
* 获取最大值（最小值）
* 深度优先搜索（前序、中序、后序）
* 广度优先搜索
* ...

## 正文解说

#### 二分查找法

如果说到讲二叉搜索树，那么在这之前呢先说说二分查找法，因为二分查找法是查找方面算法的一个基础。

二分查找法只能对一个已经有序的数列才会有效，so我们能领悟到它的思想就可以了。二分查找法是一个非常简单的算法，它的思想就是不断地取数列中间位置，然后将要查找的元素与中间位置的元素对比，如果相等，那么恭喜你，找到了，如果不相等，那么只有两种可能，要么大，要么小，这不是废话嘛~如果中间元素大，那就将范围重新限定到起始到中间-1，如果中间元素小，那就将范围重新限定到中间+1到终点位置。通过递归或者是while语句，不断缩小范围，直至找到元素或者遍历所有元素未找到结束。

废话少说，代码说明一切。

```
// 二分查找
- (NSInteger)binarySearchFromList:(NSArray *)list withValue:(NSInteger)value
{
    NSInteger left = 0;
    NSInteger right = list.count - 1;
    while (left <= right) {
        NSInteger mid = (right - left) / 2 + left;
        NSInteger midV = [list[mid] integerValue];
        if (midV == value) {
            return mid;
        } else if (midV > value) {
            right = mid - 1;
        } else if (midV < value) {
            left = mid + 1;
        }
    }
    return NSNotFound;
}
```

不用多解释代码了吧~已经够简单了。我这个是用while语句实现的，你也可以尝试用递归去做，代码差不多的！

#### 二叉搜索树

**接下来就是我们这篇的重头戏，但是在开始之前，我们先约定下我们的树，已经定义如下**

节点结构体

```
/** 节点定义 */
typedef struct KWTreeNode {
    struct KWTreeNode *left;
    struct KWTreeNode *right;
    int key;
    int value;
} KWTreeNode;

/** 创建节点函数 */
KWTreeNode *KWTreeNodeMake(int key,int value)
{
    KWTreeNode *node = malloc(sizeof(KWTreeNode));
    node->left = NULL;
    node->right = NULL;
    node->key = key;
    node->value = value;
    return node;
}
```

树类

```
@interface KWBinarySearchTree ()

/** 根节点 */
@property (nonatomic, assign) KWTreeNode *root;

@property (nonatomic, assign) int count;

@end
```

以上是基本的定义，在下面的内容中再为这个类添砖加瓦。

#####  插入元素

正如最大堆一样，我们的二叉搜索树也是需要在其内部将数据按照一定的逻辑爆粗，所以在最开始的时候我们就应该为二叉搜索树添加元素提供一个方法。我们已知二叉搜索树满足左子节点小于父节点，右子节点大于父节点，那么我们可以用待插入的元素的去从上到下一层一层比较key的大小，从而确定插入的位置，如果待插入的元素key比该节点的key大，那去找该节点的右子节点，反之，找到左子节点，遇到相等的就替换原有的值，如果不存在子节点就直接创建节点并作为该节点的子节点。重复以上步骤，直至插入到树中。

代码如下：

```
- (void)insertValue:(int)value forKey:(int)key;
{
    self.root = [self insertFromNode:self.root withKey:key andValue:value];
}

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
```

##### 查找元素

当我们按照我们的上面的方法将元素插入到树中之后，那么查找对我们来说就很容易了，为什么这么说呢？因为查找和插入是一样的方式，我们来分析一下，我们在插入元素时是一个不断寻找合适插入元素的过程，而查找元素呢，是一个不断寻找元素的过程，而两者寻找的方式都是按照二叉搜索树的规律一直向子节点方向进行的，不信我们来看下代码，相似度90%以上。

```
/** - valueForKey: 是Foundation中方法，前加get已做区分 */
- (int *)getValueForKey:(int)key
{
    return [self searchFromNode:self.root withKey:key];
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
```

是不是基本一样~看完我上面定义的方法名，是不是感觉和 *NSMutableDictonary* 中的方法名字差不多，暂且不说*NSMutableDictonary*是怎么实现的，我们现在封装好的*KWBinarySearchTree*用来当*NSMutableDictonary*使用，而且效率也是很可观的。

##### 获取最大值（最小值）

这个事情对于二叉搜索树来说真是*so easy*，不想多说，两句话你就明白了。右子节点 > 父节点 > 左子节点，所以最小的是左子节点的左子节点的左子节点...，最大的是右子节点的右子节点的右子节点...。

上代码：

```
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
```

天啊~感觉又回到了小学时代了！！！

##### 深度优先搜索（前序、中序、后序）

这一部分主要说的就是二叉树的一种遍历算法，注意不仅仅是适用于二叉搜索树。我们用深度优先搜索来作为标题只是用来吸引眼球，因为深度优先搜索是一个很大的话题，它的适用范围非常广，而不是仅仅二叉树，但我们说的二叉树的前序遍历、中序遍历、后序遍历是深度优先搜索的一种体现。所谓深度，通俗点儿说，就是一条路走到黑，撞了南墙再回头。那在二叉树中就是说从一个节点A，然后看是否有左子节点B，如果有那这个B就变成节点A，然后再找左子节点B，如此下去直到不再有左子节点，返回上一层，再同理寻找右子节点。

那前序、中序、后序是怎么一说呢？为什么就在一个小标题下说明呢？我们假设有一节点A，它有左子节点B，右子节点C，假定我们遍历的顺序是A->B->A->C->A，可以画图理解一下，然后我们再假定A节点上有三盏灯，经过一次我们点亮一盏灯，那么前序就是在A节点第一盏灯点亮的时候对A做处理，中序就是第二盏灯点亮的时候对A做处理，后序就是第三盏灯点亮的时候对A做处理。SO总结如下：前序、中序、后序它们三者唯一的区别就是做操作或者说是记录的位置不同，遍历的顺序其实是一样的。再分析一下似不似这样滴吧~

##### 广度优先搜索

所谓的广度优先在二叉树中就是按照层的顺序遍历数，遍历方法如下：先创建一个队列，如果这个队列不为空就一直执行操作。将根节点推入队列中，然后开始队列的操作，先将队列中最前面的节点推出队列，然后对其操作或者记录，最后分别取出该节点的子节点推入队列。这就是一个完整的二叉树广度优先搜索的过程。

我拿了一些数据联合深度优先搜索做了下测试，结果如下

|类型|结果|其他|
|---|---|---|
|-|64,53,60,49,78,75,93,70|-|
|前序|64,53,49,60,78,75,70,93|-|
|中序|49,53,60,64,70,75,78,93|在二叉搜索树中这个是有序的|
|后序|49,60,53,70,75,93,78,64|-|
|层序|64,53,78,49,60,75,93,70|-|


代码如下

```
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
```




