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

天啊~感觉又回到了小学。


