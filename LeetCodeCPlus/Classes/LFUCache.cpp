//
//  LFUCache.cpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/9/24.
//

#include "LFUCache.hpp"

void testLFCache() {
//    输入：
//    ["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
//    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
//    输出：
//    [null, null, null, 1, null, -1, 3, null, -1, 3, 4]
//
//    解释：
    // cnt(x) = 键 x 的使用计数
    // cache=[] 将显示最后一次使用的顺序（最左边的元素是最近的）
    LFUCache lfu = LFUCache(2);
    lfu.put(1, 1);   // cache=[1,_], cnt(1)=1
    lfu.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
    int v1 = lfu.get(1);      // 返回 1
                     // cache=[1,2], cnt(2)=1, cnt(1)=2
    lfu.put(3, 3);   // 去除键 2 ，因为 cnt(2)=1 ，使用计数最小
                     // cache=[3,1], cnt(3)=1, cnt(1)=2
    int v2 = lfu.get(2);      // 返回 -1（未找到）
    int v3 = lfu.get(3);      // 返回 3
                     // cache=[3,1], cnt(3)=2, cnt(1)=2
    lfu.put(4, 4);   // 去除键 1 ，1 和 3 的 cnt 相同，但 1 最久未使用
                     // cache=[4,3], cnt(4)=1, cnt(3)=2
    int v4 = lfu.get(1);      // 返回 -1（未找到）
    int v5 = lfu.get(3);      // 返回 3
                     // cache=[3,4], cnt(4)=1, cnt(3)=3
    int v6 = lfu.get(4);      // 返回 4
                     // cache=[3,4], cnt(4)=2, cnt(3)=3
     
};
