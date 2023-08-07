//
//  LRUCache.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/7/2.
//

#ifndef LRUCache_hpp
#define LRUCache_hpp

#include <stdio.h>
#include <vector>
#include <map>

//namespace LC {

using namespace std;

/// #155. 最小栈
///
///请你设计并实现一个满足  LRU (最近最少使用) 缓存 约束的数据结构。
///
/// 实现 LRUCache 类：
///
///     - LRUCache(int capacity) 以 正整数 作为容量 capacity 初始化 LRU 缓存
///     - int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
///     - void put(int key, int value) 如果关键字 key 已经存在，则变更其数据值 value ；如果不存在，则向缓存中插入该组 key-value  。如果插入操作导致关键字数量超过 capacity ，则应该 逐出 最久未使用的关键字。
/// 函数 get 和 put 必须以 O(1) 的平均时间复杂度运行。
///
class LRUCache {
    typedef pair<int, int> LinkPair;
    int _size;
    int _capacity;
    
    // { key, {value, {pre, next} }
    map<int, pair<int, LinkPair>> mp;
public:
    LRUCache(int capacity) {
        _capacity = capacity;
        _size = 0;
        // 用于记录首尾key。
        mp[-1] = {-1, {-1, -1}};
    }
    
    int get(int key) {
        auto it = mp.find(key);
        if (it == mp.end()) {
            return -1;
        }
        
        // 更新访问记录。
        auto &item = mp[key];
        _remove(item);
        _append(key, item);
        
        return it->second.first;
    }
    
    void put(int key, int value) {
        
        if (mp.count(key) > 0) {
            _remove(mp[key]);
            _size --;
        }
        
        mp[key] = {value, {-1, -1}};
        _size ++;
        // 更新访问记录
        _append(key, mp[key]);
        
        if (_size > _capacity) {
            key = mp[-1].second.second;
            _remove(mp[key]);
            
            mp.erase(key);
            _size --;
        }
    }
    
    void _remove(pair<int, LinkPair> & item) {
        auto link = item.second;
        mp[link.first].second.second = link.second;
        mp[link.second].second.first = link.first;
    }
    
    void _append(int key, pair<int, LinkPair> & item) {
        auto & root = mp[-1].second;
        mp[root.first].second.second = key;
        item.second = {root.first, -1};
        root.first = key;
    }
};

inline void test146() {
    printf("Test #146. LRUCache: \n");

    LRUCache lRUCache = LRUCache(2);
    lRUCache.put(1, 1);             // 缓存是 {1=1}
    lRUCache.put(2, 2);             // 缓存是 {1=1, 2=2}
    auto res1 = lRUCache.get(1);    // 返回 1
    lRUCache.put(3, 3);             // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
    auto res2 = lRUCache.get(2);    // 返回 -1 (未找到)
    lRUCache.put(4, 4);             // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
    auto res3 = lRUCache.get(1);    // 返回 -1 (未找到)
    auto res4 = lRUCache.get(3);    // 返回 3
    auto res5 = lRUCache.get(4);    // 返回 4
    
    if (res1 == 1 && res2 == -1 && res3 == -1 && res4 == 3 && res5 == 4) {
        printf("  It is successful. \n");
    } else {
        printf("  The ans is not what you want!! \n");
    }
    return;
}

//};

#endif /* LRUCache_hpp */
