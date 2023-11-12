//
//  RangeModule.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/11/12.
//

#ifndef RangeModule_hpp
#define RangeModule_hpp

#include <stdio.h>
#include <math.h>
#include <algorithm>

using namespace std;
#if 1

#include <map>

/// #715. Range 模块;
///
/// Range模块是跟踪数字范围的模块。设计一个数据结构来跟踪表示为 半开区间 的范围并查询它们。
///
/// 半开区间 [left, right) 表示所有 left <= x < right 的实数 x 。
///
/// 实现 RangeModule 类:
///
/// - RangeModule() 初始化数据结构的对象。
/// - void addRange(int left, int right) 添加 半开区间 [left, right)，跟踪该区间中的每个实数。添加与当前跟踪的数字部分重叠的区间时，应当添加在区间 [left, right) 中尚未跟踪的任何数字到该区间中。
/// - boolean queryRange(int left, int right) 只有在当前正在跟踪区间 [left, right) 中的每一个实数时，才返回 true ，否则返回 false 。
///
/// - void removeRange(int left, int right) 停止跟踪 半开区间 [left, right) 中当前正在跟踪的每个实数。
///
class RangeModule {
    /// intervals, [k, v).
    map<int, int> ins;
public:
    RangeModule() {
        
    }
    
    void addRange(int left, int right) {
        auto it = ins.upper_bound(left); // key > left;
        if (it != ins.begin()) {
//            auto pre = it_lu; pre --;
            auto start = prev(it);
            if (start->second >= right) {
                // l <= left <= right < r;
                return;
            }
            if (start->second >= left) {
                // l <= left <= r < right;
                left = start->first;
                ins.erase(start);
            }
        }
        // 合并可能交叉的区间
        while (it != ins.end() && it->first <= right) {
            right = max(right, it->second);
            it = ins.erase(it);
        }
        ins[left] = right;
    }
    
    bool queryRange(int left, int right) {
        auto it = ins.upper_bound(left);
        if (it == ins.begin()) {
            return false;
        }
        it = prev(it);
        return right <= it->second;
    }
    
    void removeRange(int left, int right) {
        auto it = ins.upper_bound(left);
        if (it != ins.begin()) {
            auto start = prev(it);
            if (start->second >= right) {
                // l <= left <= right < r => [l, left), [right, r);
                int ri = start->second;
                if (start->first == left) {
                    ins.erase(start);
                }
                else {
                    start->second = left;
                }
                if (right != ri) {
                    ins[right] = ri;
                }
                return;
            }
            else if (start->second > left) {
                // l <= left <= r < right;
                if (start->first == left) {
                    ins.erase(start);
                }
                else {
                    start->second = left;
                }
            }
        }
        while (it != ins.end() && it->first < right) {
            if (it->second <= right) {
                it = ins.erase(it);
            }
            else {
                ins[right] = it->second;
                ins.erase(it);
                break;
            }
        }
    }
};

#else

class RangeModule {
    struct RangeNode {
        int l; int r;
        bool visit;
        int add = false;
        RangeNode * left;
        RangeNode * right;
        
        RangeNode(int l, int r): l(l), r(r), visit(0), left(nullptr), right(nullptr) {}
    };
    
    RangeNode * root;
    
public:
    RangeModule() {
        root = new RangeNode(1, 1e9);
    }
    
    void addRange(int left, int right) {
        _add(left, right-1, root);
    }
    
    bool queryRange(int left, int right) {
        return _query(left, right-1, root);
    }
    
    void removeRange(int left, int right) {
        _remove(left, right-1, root);
    }

    void _add(int l, int r, RangeNode * node) {
        if (l <= node->l && node->r <= r) {
            node->visit = 1;
            node->add = 1;
            printf("+<%d,%d,[%d,%d]>", l, r, node->l, node->r);
            return;
        }
        _loadNode(node);
        int mid = (node->l + node->r) / 2;
        if (l <= mid) {
            _add(l, min(mid, r), node->left);
        }
        if (r > mid) {
            _add(max(mid+1, l), r, node->right);
        }
        
        _updateVist(root);
    }
    
    void _loadNode(RangeNode *node) {
        int mid = (node->l + node->r) / 2;
        if (!node->left)
            node->left = new RangeNode(node->l, mid);
        if (!node->right)
            node->right = new RangeNode(mid+1, node->r);
        if (node->add) {
            node->left->visit = node->right->visit = node->visit;
            node->left->add = node->right->add = node->add;
            node->add = 0;
        }
    }

    void _updateVist(RangeNode *node) {
        node->visit = node->left && node->left->visit && node->right && node->right->visit;
    }
    
    void _remove(int l, int r, RangeNode * node) {
        if (l <= node->l && node->r <= r) {
            node->visit = 0;
            node->add = 0;
            printf("-<%d,%d,[%d,%d] %d>", l, r, node->l, node->r, node->visit);
            return;
        }
        _loadNode(node);
        int mid = (node->l + node->r) / 2;
        if (l <= mid) {
            _remove(l, min(mid, r), node->left);
        }
        if (r > mid) {
            _remove(max(mid+1, l), r, node->right);
        }
        
        _updateVist(node);
    }

    bool _query(int l, int r, RangeNode * node) {
        if (l <= node->l && node->r <= r) {
            printf("#<%d,%d,[%d,%d] %d> ", l, r, node->l, node->r, node->visit);
            return node->visit;
        }
        _loadNode(node);
        int mid = (node->l + node->r) / 2;
        int v = true;
        if (l <= mid) {
            v = v && _query(l, min(mid, r), node->left);
        }
        if (r > mid) {
            v = v && _query(max(mid+1, l), r, node->right);
        }
        return v;
    }
};
#endif
/**
 * Your RangeModule object will be instantiated and called as such:
 * RangeModule* obj = new RangeModule();
 * obj->addRange(left,right);
 * bool param_2 = obj->queryRange(left,right);
 * obj->removeRange(left,right);
 */

#endif /* RangeModule_hpp */
