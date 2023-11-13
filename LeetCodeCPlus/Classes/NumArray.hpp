//
//  NumArray.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/11/13.
//

#ifndef NumArray_hpp
#define NumArray_hpp

#include <stdio.h>

#include <math.h>
#include <algorithm>
#include <vector>

#include "bit.hpp"

using namespace std;

/// MARK: #307. 区域和检索 - 数组可修改

/// #307. 区域和检索 - 数组可修改 (中等)
///
/// 给你一个数组 nums ，请你完成两类查询。
///
/// - 其中一类查询要求 更新 数组 nums 下标对应的值
/// - 另一类查询要求返回数组 nums 中索引 left 和索引 right 之间（ 包含 ）的nums元素的 和 ，其中 left <= right
///
/// 实现 NumArray 类：

/// - NumArray(int[] nums) 用整数数组 nums 初始化对象
/// - void update(int index, int val) 将 nums[index] 的值 更新 为 val
/// - int sumRange(int left, int right) 返回数组 nums 中索引 left 和索引 right 之间（ 包含 ）的nums元素的 和 （即，nums[left] + nums[left + 1], ..., nums[right]）
///
class NumArray {
    vector<int>& nums;
    vector<int> tree;
    vector<int> tns;
public:
    NumArray(vector<int>& nums): nums(nums) {
        int n = (int)nums.size();

        // self.tree = vector<int>(n * 4, 0);
        vector<int>& ns = tns;
        int tn = n;
        int total = 0;
        while (tn >> 1 > 0) {
            tn = (tn + 1) >> 1;
            printf("%d,", tn);
            ns.push_back(tn);
            total += tn;
        }
        
        tree = vector<int>(total, 0);
        printf("t: %zi, total: %d\n",ns.size(), total);

        for (int i = 0; i < n; i++) {
            auto& val = nums[i];
            int s = 0; int ii = i;
            ii = ii >> 1;
            for (int k = 0; k < ns.size(); s += ns[k],ii = ii >> 1, k++) {
                tree[s+ii] += val;
            }
        }
    }
    
    void update(int index, int val) {
        int diff = val - nums[index];
        nums[index] += diff;
        
        int s = 0; int ii = index;
        ii = ii >> 1;
        for (int k = 0; k < tns.size(); s += tns[k],ii = ii >> 1, k++) {
            tree[s+ii] += diff;
            // printf("<%d,%d,%d, %d>, ", k, ii, s+ii, tree[s+ii]);
        }
    }
    
    int sumRange(int left, int right) {
        int res = sumN(right) - sumN(left-1);
        return res;
    }

    int sumN(int index) {
        int res = 0;
        while (index >= 0) {
            int len = lowbit(index+1);
            if (len == 1) {
                res += nums[index];
                index -= 1;
                continue;
            }
            int ti = getTreeIndex(index >> 1, len >> 1);
            res += tree[ti];
            index -= len;
        }
        return res;
    }

    int getTreeIndex(int idx, int len) {
        int ti = 0;
        int k = 0;
        while (len > 1) {
            ti += tns[k];
            k++;
            len >>= 1;
            idx >>= 1;
        }
        ti += idx;
        return ti;
    }
};

/**
 * Your NumArray object will be instantiated and called as such:
 * NumArray* obj = new NumArray(nums);
 * obj->update(index,val);
 * int param_2 = obj->sumRange(left,right);
 */

#endif /* NumArray_hpp */
