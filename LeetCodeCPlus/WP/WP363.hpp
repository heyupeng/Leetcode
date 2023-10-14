//
//  WCP363.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/9/17.
//

#ifndef WCP363_hpp
#define WCP363_hpp

#include <stdio.h>
#include <vector>
#include <string>
#include <numeric>
#include <stack>

using namespace std;

#pragma - mark # 第 363 场周赛
class Solution_WCP_363 {
public:
    /// . 计算 K 置位下标对应元素的和
    /// (Easy)
    /// 给你一个下标从 0 开始的整数数组 nums 和一个整数 k 。
    ///
    /// 请你用整数形式返回 nums 中的特定元素之 和 ，这些特定元素满足：其对应下标的二进制表示中恰存在 k 个置位。
    ///
    /// 整数的二进制表示中的 1 就是这个整数的 置位 。
    ///
    /// 例如，21 的二进制表示为 10101 ，其中有 3 个置位。
    int sumIndicesWithKSetBits(vector<int>& nums, int k) {
        int sum = 0;
        for (int i = 0; i < nums.size(); i++) {
            int b = 0;
            int n = i;
            while (n) {
                b += (n & 0x1);
                n = n >> 1;
            }
            if (b == k) {
                sum += nums[i];
            }
        }
        return sum;
    }
    
    /// #100033. 最大合金数
    /// (Medium)
    ///
    /// 假设你是一家合金制造公司的老板，你的公司使用多种金属来制造合金。现在共有 n 种不同类型的金属可以使用，并且你可以使用 k 台机器来制造合金。每台机器都需要特定数量的每种金属来创建合金。
    ///
    /// 对于第 i 台机器而言，创建合金需要 composition[i][j] 份 j 类型金属。最初，你拥有 stock[i] 份 i 类型金属，而每购入一份 i 类型金属需要花费 cost[i] 的金钱。
    ///
    /// 给你整数 n、k、budget，下标从 1 开始的二维数组 composition，两个下标从 1 开始的数组 stock 和 cost，请你在预算不超过 budget 金钱的前提下，最大化 公司制造合金的数量。
    ///
    /// 所有合金都需要由同一台机器制造。
    ///
    /// 返回公司可以制造的最大合金数。
    int maxNumberOfAlloys(int n, int k, int budget, vector<vector<int>>& composition, vector<int>& stock, vector<int>& cost) {
        int maxNumber = 0;
        
        // 第 i 台机器是否支持制造数量为 num 的合金。
        auto composition_support_num_at_i = [&](int num, int i) {
            int rest = budget;
            for (int j = 0; j < n; j++) {
                if (stock[j] < composition[i][j] * num) {
                    rest -= cost[j] * (composition[i][j] * num - stock[j]);
                }
                if (rest < 0)
                    return 0;
            }
            return 1;
        };
        
        for (int i = 0; i < k; i++) {
            int num = 0;
            
            int ln = 0, rn = 10;
            // 确定右端
            while (composition_support_num_at_i(rn, i)) {
                num = rn;
                ln = rn;
                rn *= 2;
            }
            // 第i台机器可制造的最大合金数
            while (ln <= rn) {
                int cn = (ln + rn) / 2;
                if (!composition_support_num_at_i(cn, i)) {
                    rn = cn - 1;
                } else {
                    num = cn;
                    ln = cn + 1;
                }
            }
            maxNumber = max(maxNumber, num);
        }
        return maxNumber;
    }
};

class Solution_WCP_364 {
    /// . 最大二进制奇数
    /// (Easy)
    ///
    /// 给你一个 二进制 字符串 s ，其中至少包含一个 '1' 。
    ///
    /// 你必须按某种方式 重新排列 字符串中的位，使得到的二进制数字是可以由该组合生成的 最大二进制奇数 。
    ///
    /// 以字符串形式，表示并返回可以由给定组合生成的最大二进制奇数。
    ///
    /// 注意 返回的结果字符串 可以 含前导零。
    string maximumOddBinaryNumber(string s) {
        int count = 0;
        for (auto& ch: s) {
            if (ch == '1')
                count ++;
        }
        for (int i = 0; i < count-1; i++)
            s[i] = '1';
        for (int i = count-1; i < s.size(); i++)
            s[i] = '0';
        s[s.size()-1] = '1';
        return s;
    }
    
    /// 美丽塔 I
    long long maximumSumOfHeights(vector<int>& maxHeights) {
        long res = 0;
        int n = (int)maxHeights.size();
        
        vector<long> leftmaxs(n, 0);
        vector<long> rightmaxs(n, 0);
        
        vector<int> nearests(n, -1);
        for (int i = 1; i < n; i++) {
            int idx = i-1;
            while (idx >= 0 && maxHeights[i] < maxHeights[idx]) {
                idx = nearests[idx];
            }
            nearests[i] = idx;
            
            if (idx < 0) {
                leftmaxs[i] = (long)i * maxHeights[i];
            } else {
                leftmaxs[i] = leftmaxs[idx] + maxHeights[idx] + (long)(i-(idx+1)) * maxHeights[i];
            }
        }
        
        nearests[n-1] = -1;
        for (int i = n-1-1; i >= 0; i--) {
            int idx = i+1;
            while (idx >= 0 && maxHeights[i] < maxHeights[idx]) {
                idx = nearests[idx];
            }
            nearests[i] = idx;
            
            long sum = 0;
            if (idx < 0) {
                sum = (long)(n-1-i) * maxHeights[i];
            } else {
                sum = (long)-(i-(idx-1)) * maxHeights[i];
                sum += rightmaxs[idx] + maxHeights[idx];
            }
            rightmaxs[i] = sum;
        }
        
        for (int i = 0; i < n; i++) {
            long sum = leftmaxs[i] + rightmaxs[i] + maxHeights[i];
            //            printf("i = %d, sum = %ld (%ld + %ld) \n", i, sum, leftmaxs[i], rightmaxs[i]);
            res = max(res, sum);
        }
        return res;
    }
    
    /// #100047. 统计树中的合法路径数目
    ///
    /// 题目难度 Hard
    /// 给你一棵 n 个节点的无向树，节点编号为 1 到 n 。给你一个整数 n 和一个长度为 n - 1 的二维整数数组 edges ，其中 edges[i] = [ui, vi] 表示节点 ui 和 vi /// 在树中有一条边。
    ///
    /// 请你返回树中的 合法路径数目 。
    ///
    /// 如果在节点 a 到节点 b 之间 恰好有一个 节点的编号是质数，那么我们称路径 (a, b) 是 合法的 。
    ///
    /// 注意：
    ///
    /// - 路径 (a, b) 指的是一条从节点 a 开始到节点 b 结束的一个节点序列，序列中的节点 互不相同 ，且相邻节点之间在树上有一条边。
    /// - 路径 (a, b) 和路径 (b, a) 视为 同一条 路径，且只计入答案 一次 。
    ///
    /// ```
    /// 示例 1：
    ///
    /// 输入：n = 5, edges = [[1,2],[1,3],[2,4],[2,5]]
    /// 输出：4
    /// 解释：恰好有一个质数编号的节点路径有：
    /// - (1, 2) 因为路径 1 到 2 只包含一个质数 2 。
    /// - (1, 3) 因为路径 1 到 3 只包含一个质数 3 。
    /// - (1, 4) 因为路径 1 到 4 只包含一个质数 2 。
    /// - (2, 4) 因为路径 2 到 4 只包含一个质数 2 。
    /// 只有 4 条合法路径。
    /// 示例 2：
    ///
    /// 输入：n = 6, edges = [[1,2],[1,3],[2,4],[3,5],[3,6]]
    /// 输出：6
    /// 解释：恰好有一个质数编号的节点路径有：
    /// - (1, 2) 因为路径 1 到 2 只包含一个质数 2 。
    /// - (1, 3) 因为路径 1 到 3 只包含一个质数 3 。
    /// - (1, 4) 因为路径 1 到 4 只包含一个质数 2 。
    /// - (1, 6) 因为路径 1 到 6 只包含一个质数 3 。
    /// - (2, 4) 因为路径 2 到 4 只包含一个质数 2 。
    /// - (3, 6) 因为路径 3 到 6 只包含一个质数 3 。
    /// 只有 6 条合法路径。
    ///
    ///```
    /// 提示：
    /// - 1 <= n <= 1E5
    /// - edges.length == n - 1
    /// - edges[i].length == 2
    /// - 1 <= ui, vi <= n
    /// - 输入保证 edges 形成一棵合法的树。
    ///
    long long countPaths(int n, vector<vector<int>>& edges) {
        if (n < 2)
            return 0;
        // 质数
        vector<bool> flags(n+1, 1);
        flags[0] = 0; flags[1] = 0;
        for (int i = 2; i < flags.size(); i++) {
            if (flags[i] == 0)
                continue;
            int m = 2;
            while (flags[i] * m < flags.size()) {
                flags[flags[i]*m] = 0;
            }
        }
        
        vector<vector<int>> g(n);
        for (auto edge: edges) {
            if (flags[edge[0]] == 1 && flags[edge[0]] == 1)
                continue;
            g[edge[0]-1].push_back(edge[1]);
            g[edge[1]-1].push_back(edge[0]);
        }
        
        //        auto dfs = [&](int idx) {
        //            for (
        //        };
        //        vector<int> cnts(n, 0);
        //        for (int i = 2; i <= n; i++) {
        //            if (flags[i] == 0)
        //                continue;
        //            int j = i;
        //
        //        }
        return 0;
    }
};

#endif /* WCP363_hpp */
