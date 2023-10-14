//
//  LFUCache.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/9/24.
//

#ifndef LFUCache_hpp
#define LFUCache_hpp

#include <stdio.h>
using namespace std;

#include <vector>
#include <map>
//#include <queue>
#include <set>

/// 460. LFU 缓存 (困难)
///
/// 请你为 最不经常使用（LFU）缓存算法设计并实现数据结构。
///
/// 实现 LFUCache 类：
///
/// - LFUCache(int capacity) - 用数据结构的容量 capacity 初始化对象
/// - int get(int key) - 如果键 key 存在于缓存中，则获取键的值，否则返回 -1 。
/// - void put(int key, int value) - 如果键 key 已存在，则变更其值；如果键不存在，请插入键值对。当缓存达到其容量 capacity /// 时，则应该在插入新项之前，移除最不经常使用的项。在此问题中，当存在平局（即两个或更多个键具有相同使用频率）时，应该去除 最近最久未使用 的键。
///
/// 为了确定最不常使用的键，可以为缓存中的每个键维护一个 使用计数器 。使用计数最小的键是最久未使用的键。
///
/// 当一个键首次插入到缓存中时，它的使用计数器被设置为 1 (由于 put 操作)。对缓存中的键执行 get 或 put 操作，使用计数器的值将会递增。
///
/// 函数 get 和 put 必须以 O(1) 的平均时间复杂度运行。
///
/// ```
/// 示例：
///
/// 输入：
/// ["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
/// [[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
/// 输出：
/// [null, null, null, 1, null, -1, 3, null, -1, 3, 4]
///
/// 解释：
/// // cnt(x) = 键 x 的使用计数
/// // cache=[] 将显示最后一次使用的顺序（最左边的元素是最近的）
/// LFUCache lfu = new LFUCache(2);
/// lfu.put(1, 1);   // cache=[1,_], cnt(1)=1
/// lfu.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
/// lfu.get(1);      // 返回 1
///                  // cache=[1,2], cnt(2)=1, cnt(1)=2
/// lfu.put(3, 3);   // 去除键 2 ，因为 cnt(2)=1 ，使用计数最小
///                  // cache=[3,1], cnt(3)=1, cnt(1)=2
/// lfu.get(2);      // 返回 -1（未找到）
/// lfu.get(3);      // 返回 3
///                  // cache=[3,1], cnt(3)=2, cnt(1)=2
/// lfu.put(4, 4);   // 去除键 1 ，1 和 3 的 cnt 相同，但 1 最久未使用
///                  // cache=[4,3], cnt(4)=1, cnt(3)=2
/// lfu.get(1);      // 返回 -1（未找到）
/// lfu.get(3);      // 返回 3
///                  // cache=[3,4], cnt(4)=1, cnt(3)=3
/// lfu.get(4);      // 返回 4
///                  // cache=[3,4], cnt(4)=2, cnt(3)=3
///
///```
/// 提示：
///
/// - 1 <= capacity <= 1E4
/// - 0 <= key <= 1E5
/// - 0 <= value <= 1E9
/// - 最多调用 2 * 1E5 次 get 和 put 方法
///
class LFUCache {
    struct Item {
        int key;
        int timeID;
        
        bool operator < (Item rhs) const {
            return timeID < rhs.timeID;
        }
    };
    
    int _capacity;
    int _size;
    
    /// <key, value>
    map<int, int> mp;
    
    ///  <key, count>
    map<int, int> _cntmp;
    
    int _timeID;
    ///  <key, time>
    map<int, int> _timemp;

//     <count, [key, time]>
//    map<int, map<int, int>> _frqmp;
    map<int, set<Item>> _frqmp;
        
public:
    LFUCache(int capacity) {
        _capacity = capacity;
        _size = 0;
        _timeID = 0;
    }
    
    int get(int key) {
        if (mp.count(key) <= 0) {
            return -1;
        }
        
        int& count = _cntmp[key];

        Item item = {key, _timemp[key]};
        _frqmp[count].erase(item);
        item.timeID = ++_timeID;
        _frqmp[count+1].insert(item);

        _timemp[key] = _timeID;
        _cntmp[key] ++;

        return mp[key];
    }
    
    void put(int key, int value) {
        if (mp.count(key) > 0) {
            mp[key] = value;
        
            int& count = _cntmp[key];

            Item item = {key, _timemp[key]};
            _frqmp[count].erase(item);
            item.timeID = ++_timeID;
            _frqmp[count+1].insert(item);

            _timemp[key] = _timeID;
            _cntmp[key] ++;
            return;
        }
        if (_size >= _capacity) {
//            _removeCacheForFirstElement(key);
        }
        
        mp[key] = value;
        _size ++;
        _timeID ++;
        
        // update countmp.
        Item item = {key, _timeID};
        _frqmp[1].insert(item);
        _cntmp[key] = 1;
        _timemp[key] = _timeID;
    }
    
    void _removeCacheForFirstElement(int key) {
        int firstKey = -1;
        int timeID = 0;
        auto begin = _frqmp.begin();
        
        Item item = {-1, 0};
        while (begin != _frqmp.end()) {
            auto keys = begin->second;
            auto it = keys.begin();
            
            while (it != keys.end()) {
                if (it->key == key) {
                    item = *it;
                    break;
                } else {
                    it ++;
                }
            }
            if (item.key != -1)
                break;
            begin ++;
        }
        
        firstKey = item.key;
        if (firstKey == -1)
            return;
        
        begin->second.erase(item);
        
        mp.erase(firstKey);
        _size --;
    }
};

void testLFCache();

/**
 * Your LFUCache object will be instantiated and called as such:
 * LFUCache* obj = new LFUCache(capacity);
 * int param_1 = obj->get(key);
 * obj->put(key,value);
 */


#endif /* LFUCache_hpp */
