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


class Solution_DWP118 {
    //MARK: #100121. 查找包含给定字符的单词
    
    /// #100121. 查找包含给定字符的单词
    /// 题目难度 Easy
    ///
    /// 给你一个下标从 0 开始的字符串数组 words 和一个字符 x 。
    ///
    /// 请你返回一个 下标数组 ，表示下标在数组中对应的单词包含字符 x 。
    ///
    /// 注意 ，返回的数组可以是 任意 顺序。
    ///
    /// 示例 1：
    /// 输入：words = ["leet","code"], x = "e"
    /// 输出：[0,1]
    /// 解释："e" 在两个单词中都出现了："leet" 和 "code" 。所以我们返回下标 0 和 1 。
    /// 示例 2：
    /// 输入：words = ["abc","bcd","aaaa","cbc"], x = "a"
    /// 输出：[0,2]
    /// 解释："a" 在 "abc" 和 "aaaa" 中出现了，所以我们返回下标 0 和 2 。
    /// 示例 3：
    ///
    /// 输入：words = ["abc","bcd","aaaa","cbc"], x = "z"
    /// 输出：[]
    /// 解释："z" 没有在任何单词中出现。所以我们返回空数组。
    ///
    /// 提示：
    /// 1 <= words.length <= 50
    /// 1 <= words[i].length <= 50
    /// x 是一个小写英文字母。
    /// words[i] 只包含小写英文字母。
    vector<int> findWordsContaining(vector<string>& words, char x) {
        vector<int> res;
        int i = 0;
        for (auto& word: words) {
            for (auto& ch: word) {
                if (ch == x) {
                    res.push_back(i);
                    break;
                }
            }
            i ++;
        }
        return res;
    }
    
    // MARK: #100138. 最大化网格图中正方形空洞的面积
    
    /// #100138. 最大化网格图中正方形空洞的面积
    ///
    /// 题目难度 Medium
    /// 给你一个网格图，由 n + 2 条 横线段 和 m + 2 条 竖线段 组成，一开始所有区域均为 1 x 1 的单元格。
    ///
    /// 所有线段的编号从 1 开始。
    ///
    /// 给你两个整数 n 和 m 。
    ///
    /// 同时给你两个整数数组 hBars 和 vBars 。
    ///
    /// hBars 包含区间 [2, n + 1] 内 互不相同 的横线段编号。
    /// vBars 包含 [2, m + 1] 内 互不相同的 竖线段编号。
    /// 如果满足以下条件之一，你可以 移除 两个数组中的部分线段：
    ///
    /// - 如果移除的是横线段，它必须是 hBars 中的值。
    /// - 如果移除的是竖线段，它必须是 vBars 中的值。
    ///
    /// 请你返回移除一些线段后（可能不移除任何线段），剩余网格图中 最大正方形 空洞的面积，正方形空洞的意思是正方形 内部 不含有任何线段。
    ///
    /// 示例 1：
    /// 输入：n = 2, m = 1, hBars = [2,3], vBars = [2]
    /// 输出：4
    /// 解释：左边的图是一开始的网格图。
    /// 横线编号的范围是区间 [1,4] ，竖线编号的范围是区间 [1,3] 。
    /// 可以移除的横线段为 [2,3] ，竖线段为 [2] 。
    /// 一种得到最大正方形面积的方法是移除横线段 2 和竖线段 2 。
    /// 操作后得到的网格图如右图所示。
    /// 正方形空洞面积为 4。
    /// 无法得到面积大于 4 的正方形空洞。
    /// 所以答案为 4 。
    /// 示例 2：
    /// 输入：n = 1, m = 1, hBars = [2], vBars = [2]
    /// 输出：4
    /// 解释：左边的图是一开始的网格图。
    /// 横线编号的范围是区间 [1,3] ，竖线编号的范围是区间 [1,3] 。
    /// 可以移除的横线段为 [2] ，竖线段为 [2] 。
    /// 一种得到最大正方形面积的方法是移除横线段 2 和竖线段 2 。
    /// 操作后得到的网格图如右图所示。
    /// 正方形空洞面积为 4。
    /// 无法得到面积大于 4 的正方形空洞。
    /// 所以答案为 4 。
    /// 示例 3：
    /// 输入：n = 2, m = 3, hBars = [2,3], vBars = [2,3,4]
    /// 输出：9
    /// 解释：左边的图是一开始的网格图。
    /// 横线编号的范围是区间 [1,4] ，竖线编号的范围是区间 [1,5] 。
    /// 可以移除的横线段为 [2,3] ，竖线段为 [2,3,4] 。
    /// 一种得到最大正方形面积的方法是移除横线段 2、3 和竖线段 3、4 。
    /// 操作后得到的网格图如右图所示。
    /// 正方形空洞面积为 9。
    /// 无法得到面积大于 9 的正方形空洞。
    /// 所以答案为 9 。
    ///
    /// 提示：
    /// - 1 <= n <= 10^9
    /// - 1 <= m <= 10^9
    /// - 1 <= hBars.length <= 100
    /// - 2 <= hBars[i] <= n + 1
    /// - 1 <= vBars.length <= 100
    /// - 2 <= vBars[i] <= m + 1
    /// - hBars 中的值互不相同。
    /// - vBars 中的值互不相同。
    int maximizeSquareHoleArea(int n, int m, vector<int>& hBars, vector<int>& vBars) {
        sort(hBars.begin(), hBars.end());
        sort(vBars.begin(), vBars.end());
        
        int hlen = 1, hmax = 1;
        for (int i = 0; i < hBars.size(); i ++) {
            if (i > 0 && hBars[i] != hBars[i-1] + 1) {
                hlen = 1;
            }
            hlen ++;
            hmax = max(hmax, hlen);
        }
        
        int vlen = 1, vmax = 1;
        for (int i = 0; i < vBars.size(); i ++) {
            if (i > 0 && vBars[i] != vBars[i-1] + 1) {
                vlen = 1;
            }
            vlen ++;
            vmax = max(vmax, vlen);
        }
        return min(hmax, vmax) * min(hmax, vmax);
    }
    
    
    
};
#endif /* DWP117_hpp */
