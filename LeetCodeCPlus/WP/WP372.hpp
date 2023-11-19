//
//  WP372.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/11/19.
//

#ifndef WP372_hpp
#define WP372_hpp

#include <stdio.h>

#include <vector>
#include <string>
#include <numeric>
#include <stack>

using namespace std;
class Solution {
public:
    //MARK: #100131. 使三个字符串相等
    
    /// #100131. 使三个字符串相等
    /// (Easy)
    ///
    /// 给你三个字符串 s1、s2 和 s3。 你可以根据需要对这三个字符串执行以下操作 任意次数 。
    ///
    /// 在每次操作中，你可以选择其中一个长度至少为 2 的字符串 并删除其 最右位置上 的字符。
    ///
    /// 如果存在某种方法能够使这三个字符串相等，请返回使它们相等所需的 最小 操作次数；否则，返回 -1。
    /// @code
    /// 示例 1：
    /// 输入：s1 = "abc"，s2 = "abb"，s3 = "ab"
    /// 输出：2
    /// 解释：对 s1 和 s2 进行一次操作后，可以得到三个相等的字符串。
    /// 可以证明，不可能用少于两次操作使它们相等。
    ///
    /// 示例 2：
    /// 输入：s1 = "dac"，s2 = "bac"，s3 = "cac"
    /// 输出：-1
    /// 解释：因为 s1 和 s2 的最左位置上的字母不相等，所以无论进行多少次操作，它们都不可能相等。因此答案是 -1 。
    /// @endcode
    ///
    /// 提示：
    /// - 1 <= s1.length, s2.length, s3.length <= 100
    /// - s1、s2 和 s3 仅由小写英文字母组成。
    ///
    int findMinimumOperations(string s1, string s2, string s3) {
        int size = (int)min(min(s1.size(), s2.size()), s3.size());
        int cnt = 0;
        for (int i = 0; i < size; i++) {
            if (s1[i] == s2[i] && s1[i] == s3[i]) {
                cnt ++;
            } else {
                break;
            }
        }
        if (cnt == 0) {
            return -1;
        }
        return s1.size() + s2.size() + s3.size() - cnt * 3;
    }
    
    // MARK: #100122. 区分黑球与白球
    
    /// #100122. 区分黑球与白球
    /// (Medium)
    ///
    /// 桌子上有 n 个球，每个球的颜色不是黑色，就是白色。
    ///
    /// 给你一个长度为 n 、下标从 0 开始的二进制字符串 s，其中 1 和 0 分别代表黑色和白色的球。
    ///
    /// 在每一步中，你可以选择两个相邻的球并交换它们。
    ///
    /// 返回「将所有黑色球都移到右侧，所有白色球都移到左侧所需的 最小步数」。
    ///
    /// @code
    /// 示例 1：
    /// 输入：s = "101"
    /// 输出：1
    /// 解释：我们可以按以下方式将所有黑色球移到右侧：
    /// - 交换 s[0] 和 s[1]，s = "011"。
    /// 最开始，1 没有都在右侧，需要至少 1 步将其移到右侧。
    /// 示例 2：
    /// 输入：s = "100"
    /// 输出：2
    /// 解释：我们可以按以下方式将所有黑色球移到右侧：
    /// - 交换 s[0] 和 s[1]，s = "010"。
    /// - 交换 s[1] 和 s[2]，s = "001"。
    /// 可以证明所需的最小步数为 2 。
    /// 示例 3：
    /// 输入：s = "0111"
    /// 输出：0
    /// 解释：所有黑色球都已经在右侧。
    /// @endcode
    /// 提示：
    /// - 1 <= n == s.length <= 10^5
    /// - s[i] 不是 '0'，就是 '1'。
    ///
    long long minimumSteps(string s) {
        int n = (int)s.size();
        int r = n - 1;
        long long step = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (s[i] == '0') {
                continue;
            }
            step += r - i;
            r --;
        }
        return step;
    }
    
    // MARK: #100119. 最大异或乘积
    
    /// 100119. 最大异或乘积
    /// (Medium)
    ///
    /// 给你三个整数 a ，b 和 n ，请你返回 (a XOR x) * (b XOR x) 的 最大值 且 x 需要满足 0 <= x < 2n。
    ///
    /// 由于答案可能会很大，返回它对 109 + 7 取余 后的结果。
    ///
    /// 注意，XOR 是按位异或操作。
    /// @code
    /// 示例 1：
    /// 输入：a = 12, b = 5, n = 4
    /// 输出：98
    /// 解释：当 x = 2 时，(a XOR x) = 14 且 (b XOR x) = 7 。所以，(a XOR x) * (b XOR x) = 98 。
    /// 98 是所有满足 0 <= x < 2n 中 (a XOR x) * (b XOR x) 的最大值。
    /// 示例 2：
    ///
    /// 输入：a = 6, b = 7 , n = 5
    /// 输出：930
    /// 解释：当 x = 25 时，(a XOR x) = 31 且 (b XOR x) = 30 。所以，(a XOR x) * (b XOR x) = 930 。
    /// 930 是所有满足 0 <= x < 2n 中 (a XOR x) * (b XOR x) 的最大值。
    /// 示例 3：
    ///
    /// 输入：a = 1, b = 6, n = 3
    /// 输出：12
    /// 解释： 当 x = 5 时，(a XOR x) = 4 且 (b XOR x) = 3 。所以，(a XOR x) * (b XOR x) = 12 。
    /// 12 是所有满足 0 <= x < 2n 中 (a XOR x) * (b XOR x) 的最大值。
    /// @endcode
    ///
    /// 提示：
    /// - 0 <= a, b < 2^50
    /// - 0 <= n <= 50
    ///
    ///
    int maximumXorProduct(long long a, long long b, int n) {
        const int limit = 1e9 + 7;
        long long maximumX = 1; maximumX <<= n;
        
        /*
        // v1 * v2 溢出
        long long maximumval = 0;
        for (int i = 0; i < nn; i++) {
            long long v1 = (a ^ i), v2 = (b ^ i);
            if (maximumval < v1 * v2) {
                maximumval = v1 * v2;
            }
        }
        maximumval %= limit;
        return maximumval;
         */
        
        /*
         5 * 6 = 30 =  (4+1)(4+2) = 16 + 8 + 4 + 2
         1 01
         1 10
         100 * 100 + 100 * 10 + 1 * 100 + 1 * 10
         4 * 4 + 4 * 2 + 1 * 4 + 2 = 16 + 8  + 6 + 2 =
         */
        long long m1 = min(a, b), m2 = max(a, b);
        long long x = 0;
        printf("%lld, %lld, %d", m1, m2, n);
        printf("x < 2 ^ %d = %lld \n", n, maximumX);
        
        /* 2. 分片存储计算。（maximumX 引发超时）
        long long mc1 = 0, mc2 = 0;
        long long seg = 0xffffffff;
        for (long i = 0; i < maximumX; i++) {
            long long v1 = (a ^ i);
            long long v2 = (b ^ i);
            // high | low
            long long h = 0, l = 0;
            h += (v1 >> 32) * (v2 >> 32);
            h += (v1 >> 32) * (v2 & seg);
            h += (v2 >> 32) * (v1 & seg);
            l += (v2 & seg) * (v1 & seg);
            if (mc1 < h || (mc1 == h && mc2 < l)) {
                m1 = v1; m2 = v2;
                mc1 = h; mc2 = l;
                x = i;
            }
         printf("x = %lld \n", x);
         m1 %= limit;
         m2 %= limit;
         return m1*m2%limit;
        }
         */
        
        /* 3. 位运算。way 2 升级。*/
        long long unit = 1;
        long long res = 0;
        for (long long  i = n-1; i >= 0 && a >= 0 && b >= 0; i--) {
            long long bita = a >> i & 1;
            long long bitb = b >> i & 1;
            // printf("%d  %d \n", bita, bitb);
            if (bita == 1 && bitb == 1) {
            }
            else if (bita == 0 && bitb == 0) {
                bita = 1;
                x |= bita << i;
            }
            else {
                long long ha = (a^x) >> (i+1), la = a & ( (unit << i) -1);
                long long hb = (b^x) >> (i+1), lb = b & ( (unit << i) -1);
                if (ha < hb) {
                    x |= bitb << i;
                }
                else if (ha > hb) {
                    x |= bita << i;
                }
            }
        }
        
        m1 = (m1 ^ x) % limit;
        m2 = (m2 ^ x) % limit;
        res =  m1 * m2 % limit;
        printf("x = %lld, res = %lld\n", x, res);
        return (int)res;
    }
    
    // MARK: #100110. 找到 Alice 和 Bob 可以相遇的建筑
    /// #100110. 找到 Alice 和 Bob 可以相遇的建筑
    /// 题目难度 Hard
    /// 给你一个下标从 0 开始的正整数数组 heights ，其中 heights[i] 表示第 i 栋建筑的高度。
    ///
    /// 如果一个人在建筑 i ，且存在 i < j 的建筑 j 满足 heights[i] < heights[j] ，那么这个人可以移动到建筑 j 。
    ///
    /// 给你另外一个数组 queries ，其中 queries[i] = [ai, bi] 。第 i 个查询中，Alice 在建筑 ai ，Bob 在建筑 bi 。
    ///
    /// 请你能返回一个数组 ans ，其中 ans[i] 是第 i 个查询中，Alice 和 Bob 可以相遇的 最左边的建筑 。如果对于查询 i ，Alice 和 Bob 不能相遇，令 ans[i] 为 -1 。
    /// @code
    /// 示例 1：
    /// 输入：heights = [6,4,8,5,2,7], queries = [[0,1],[0,3],[2,4],[3,4],[2,2]]
    /// 输出：[2,5,-1,5,2]
    /// 解释：第一个查询中，Alice 和 Bob 可以移动到建筑 2 ，因为 heights[0] < heights[2] 且 heights[1] < heights[2] 。
    /// 第二个查询中，Alice 和 Bob 可以移动到建筑 5 ，因为 heights[0] < heights[5] 且 heights[3] < heights[5] 。
    /// 第三个查询中，Alice 无法与 Bob 相遇，因为 Alice 不能移动到任何其他建筑。
    /// 第四个查询中，Alice 和 Bob 可以移动到建筑 5 ，因为 heights[3] < heights[5] 且 heights[4] < heights[5] 。
    /// 第五个查询中，Alice 和 Bob 已经在同一栋建筑中。
    /// 对于 ans[i] != -1 ，ans[i] 是 Alice 和 Bob 可以相遇的建筑中最左边建筑的下标。
    /// 对于 ans[i] == -1 ，不存在 Alice 和 Bob 可以相遇的建筑。
    /// 示例 2：
    /// 输入：heights = [5,3,8,2,6,1,4,6], queries = [[0,7],[3,5],[5,2],[3,0],[1,6]]
    /// 输出：[7,6,-1,4,6]
    /// 解释：第一个查询中，Alice 可以直接移动到 Bob 的建筑，因为 heights[0] < heights[7] 。
    /// 第二个查询中，Alice 和 Bob 可以移动到建筑 6 ，因为 heights[3] < heights[6] 且 heights[5] < heights[6] 。
    /// 第三个查询中，Alice 无法与 Bob 相遇，因为 Bob 不能移动到任何其他建筑。
    /// 第四个查询中，Alice 和 Bob 可以移动到建筑 4 ，因为 heights[3] < heights[4] 且 heights[0] < heights[4] 。
    /// 第五个查询中，Alice 可以直接移动到 Bob 的建筑，因为 heights[1] < heights[6] 。
    /// 对于 ans[i] != -1 ，ans[i] 是 Alice 和 Bob 可以相遇的建筑中最左边建筑的下标。
    /// 对于 ans[i] == -1 ，不存在 Alice 和 Bob 可以相遇的建筑。
    /// @endcode
    /// 提示：
    /// 1 <= heights.length <= 5 * 10^4
    /// 1 <= heights[i] <= 10^9
    /// 1 <= queries.length <= 5 * 10^4
    /// queries[i] = [ai, bi]
    /// 0 <= ai, bi <= heights.length - 1
    ///
    vector<int> leftmostBuildingQueries(vector<int>& heights, vector<vector<int>>& queries) {
        int n = (int)heights.size();
        vector<vector<int>> dp(n, vector(n, -1)); // #942.超出内存
        for (int i = 0; i < n; i++) {
            dp[i][i] = i;
        }
        vector<int> mp(n, -1);
        for (int i = n - 1; i >= 0; i--) {
            for (int j = i-1; j >= 0; j--) {
                if (heights[j] < heights[i]) {
                    dp[i][j] = i;
//                    dp[j][i] = i; // 超时
                    mp[j] = i;
                    continue;
                }
                dp[i][j] = mp[j];
//                dp[j][i] = mp[j];
            }
        }
        
        vector<int> res;
        for (auto& q: queries) {
            int x = min(q[0], q[1]), y = max(q[0], q[1]);
            res.push_back(dp[y][x]);
        }
        return res;
    }
};

#endif /* WP372_hpp */
