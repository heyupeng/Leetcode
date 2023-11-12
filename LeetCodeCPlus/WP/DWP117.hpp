//
//  DWP117.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/11/12.
//

#ifndef DWP117_hpp
#define DWP117_hpp

#include <stdio.h>

#include <vector>
#include <string>
#include <numeric>
#include <stack>

using namespace std;

class Solution_DWP117 {
    
public:
    
    /// MARK: #100125. 给小朋友们分糖果
    
    /// #100125. 给小朋友们分糖果
    ///
    /// 题目难度 Easy
    ///
    /// 给你两个正整数 n 和 limit 。
    /// 请你将 n 颗糖果分给 3 位小朋友，确保没有任何小朋友得到超过 limit 颗糖果，请你返回满足此条件下的 总方案数 。
    int distributeCandies(int n, int limit) {
        function<int(int,int)> dfs = [&](int i, int nn) {
            if (i == 3) {
                return nn <= limit ? 1: 0;
            }
            if ((3 - i) * limit > nn) {
                return 0;
            }
            int res = 0;
            for (int k = 0; k <= limit; k++) {
                res += dfs(i+1, nn - k);
            }
            return res;
        };
        return dfs(0, n);
    }
    
    /// MARK: #100127. 给小朋友们分糖果 II
    
    /// #100127. 给小朋友们分糖果 II
    ///
    /// 题目难度 Middle
    ///
    /// 给你两个正整数 n 和 limit 。
    /// 请你将 n 颗糖果分给 3 位小朋友，确保没有任何小朋友得到超过 limit 颗糖果，请你返回满足此条件下的 总方案数 。
    long long  distributeCandiesII(int n, int limit) {
        long long res = 0;
        for (int k = max(0, n-limit*2); k <= min(n, limit); k++) {
            int nn = n - k;
            int k1min = max(0, nn - limit);
            int k1max = min(nn, limit);
            res += k1max - k1min + 1;
        }
        return res;
    }
};

#endif /* DWP117_hpp */
