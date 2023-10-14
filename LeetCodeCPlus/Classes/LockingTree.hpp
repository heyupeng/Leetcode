//
//  LockingTree.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/9/23.
//

#ifndef LockingTree_hpp
#define LockingTree_hpp

#include <stdio.h>
using namespace std;

#include <vector>
#include <queue>

/// #1993. 树上的操作
///
/// 给你一棵 n 个节点的树，编号从 0 到 n - 1 ，以父节点数组 parent 的形式给出，其中 parent[i] 是第 i 个节点的父节点。树的根节点为 0 号节点，所以 parent[0] = -1 ，因为它没有父节点。你想要设计一个数据结构实现树里面对节点的加锁，解锁和升级操作。
///
/// 数据结构需要支持如下函数：
///
/// - Lock：指定用户给指定节点 上锁 ，上锁后其他用户将无法给同一节点上锁。只有当节点处于未上锁的状态下，才能进行上锁操作。
/// - Unlock：指定用户给指定节点 解锁 ，只有当指定节点当前正被指定用户锁住时，才能执行该解锁操作。
/// - Upgrade：指定用户给指定节点 上锁 ，并且将该节点的所有子孙节点 解锁 。只有如下 3 个条件 全部 满足时才能执行升级操作：
///     - 指定节点当前状态为未上锁。
///     - 指定节点至少有一个上锁状态的子孙节点（可以是 任意 用户上锁的）。
///     - 指定节点没有任何上锁的祖先节点。
///
/// 提交效率
/// - 时间: 击败 53.70%使用 C++ 的用户
/// - 内存: 118.02MB 击败 87.04%使用 C++ 的用户
class LockingTree {
    vector<int> parents;
    vector<int> flags;
    
    vector<vector<int>> children;
    
public:
    LockingTree(vector<int>& parent) {
        parents = parent;
        flags = vector<int>(parent.size(), 0);
        children = vector<vector<int>>(parents.size());
        for(int i = 1; i < parents.size(); i++)
            children[parents[i]].push_back(i);
    }
    
    bool lock(int num, int user) {
        if (flags[num] != 0) {
            return false;
        }
        flags[num] = user;
        return true;
    }
    
    bool unlock(int num, int user) {
        if (flags[num] != user) {
            return false;
        }
        flags[num] = 0;
        return true;
    }
    
    bool upgrade(int num, int user) {
        if (flags[num] != 0)
            return false;
        
        // 检查父节点上锁状态。
        int parent = num;
        while (parent != -1) {
            if (flags[parent] != 0)
                return false;
            parent = parents[parent];
        }
        
        // 检查子孙节点上锁状态，并且解锁。
        bool isunclocked = false;
        unclockChildren(num, isunclocked);
        
        if (isunclocked) {
            flags[num] = user;
        }
        
        return isunclocked;
    }
    
private:
    void unclockChildren(int num, bool& isunclocked) {
        for (auto& c: children[num]) {
            if (flags[c] != 0) {
                flags[c] = 0;
                isunclocked = true;
            }
            if (children[c].size() == 0)
                continue;
            unclockChildren(c, isunclocked);
        }
    }
    
};

/**
 * Your LockingTree object will be instantiated and called as such:
 * LockingTree* obj = new LockingTree(parent);
 * bool param_1 = obj->lock(num,user);
 * bool param_2 = obj->unlock(num,user);
 * bool param_3 = obj->upgrade(num,user);
 */

#endif /* LockingTree_hpp */
