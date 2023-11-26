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

class Solution_WP_373 {
// MARK: #100139. 循环移位后的矩阵相似检查  
    
    /// #100139. 循环移位后的矩阵相似检查
    /// 题目难度 Easy
    
    /// 给你一个大小为 m x n 的整数矩阵 mat 和一个整数 k 。请你将矩阵中的 奇数 行循环 右 移 k 次，偶数 行循环 左 移 k 次。

    /// 如果初始矩阵和最终矩阵完全相同，则返回 true ，否则返回 false 。
    
    /// 示例 1：
    /// 输入：mat = [[1,2,1,2],[5,5,5,5],[6,3,6,3]], k = 2
    /// 输出：true
    /// 解释：
    /// 初始矩阵如图一所示。
    /// 图二表示对奇数行右移一次且对偶数行左移一次后的矩阵状态。
    /// 图三是经过两次循环移位后的最终矩阵状态，与初始矩阵相同。
    /// 因此，返回 true 。
    /// 示例 2：
    /// 输入：mat = [[2,2],[2,2]], k = 3
    /// 输出：true
    /// 解释：由于矩阵中的所有值都相等，即使进行循环移位，矩阵仍然保持不变。因此，返回 true 。
    /// 示例 3：
    /// 输入：mat = [[1,2]], k = 1
    /// 输出：false
    /// 解释：循环移位一次后，mat = [[2,1]]，与初始矩阵不相等。因此，返回 false 。

    /// 提示：

    /// 1 <= mat.length <= 25
    /// 1 <= mat[i].length <= 25
    /// 1 <= mat[i][j] <= 25
    /// 1 <= k <= 50
    bool areSimilar(vector<vector<int>>& mat, int k) {
        int m = (int)mat.size();
        int n = (int)mat[0].size();
        k %= n;
        // >>
        for (int i = 0; i < m; i += 2) {
            for (int j = 0; j < n; j++) {
                if (mat[i][j] != mat[i][(j+k)%n]) {
                    return false;
                }
            }
        }
        // <<
        for (int i = 1; i < m; i += 2) {
            for (int j = 0; j < n; j++) {
                if (mat[i][j] != mat[i][(j-k+n)%n]) {
                    return false;
                }
            }
        }
        return true;
    }
    
    // MARK: #100134. 统计美丽子字符串 I
    
    /// #100134. 统计美丽子字符串 I
    /// 题目难度 Medium
    ///
    /// 给你一个字符串 s 和一个正整数 k 。
    ///
    /// 用 vowels 和 consonants 分别表示字符串中元音字母和辅音字母的数量。
    ///
    /// 如果某个字符串满足以下条件，则称其为 美丽字符串 ：
    ///
    /// - vowels == consonants，即元音字母和辅音字母的数量相等。
    /// - (vowels * consonants) % k == 0，即元音字母和辅音字母的数量的乘积能被 k 整除。
    /// - 返回字符串 s 中 非空美丽子字符串 的数量。
    ///
    /// 子字符串是字符串中的一个连续字符序列。
    ///
    /// 英语中的 元音字母 为 'a'、'e'、'i'、'o' 和 'u' 。
    ///
    /// 英语中的 辅音字母 为除了元音字母之外的所有字母。
    ///
    /// 示例 1：
    /// 输入：s = "baeyh", k = 2
    /// 输出：2
    /// 解释：字符串 s 中有 2 个美丽子字符串。
    /// - 子字符串 "baeyh"，vowels = 2（["a","e"]），consonants = 2（["y","h"]）。
    /// 可以看出字符串 "aeyh" 是美丽字符串，因为 vowels == consonants 且 vowels * consonants % k == 0 。
    /// - 子字符串 "baeyh"，vowels = 2（["a","e"]），consonants = 2（["b","y"]）。
    /// 可以看出字符串 "baey" 是美丽字符串，因为 vowels == consonants 且 vowels * consonants % k == 0 。
    /// 可以证明字符串 s 中只有 2 个美丽子字符串。
    /// 示例 2：
    ///
    /// 输入：s = "abba", k = 1
    /// 输出：3
    /// 解释：字符串 s 中有 3 个美丽子字符串。
    /// - 子字符串 "abba"，vowels = 1（["a"]），consonants = 1（["b"]）。
    /// - 子字符串 "abba"，vowels = 1（["a"]），consonants = 1（["b"]）。
    /// - 子字符串 "abba"，vowels = 2（["a","a"]），consonants = 2（["b","b"]）。
    /// 可以证明字符串 s 中只有 3 个美丽子字符串。
    /// 示例 3：
    /// 输入：s = "bcdf", k = 1
    /// 输出：0
    /// 解释：字符串 s 中没有美丽子字符串。
    ///
    /// 提示：
    /// 1 <= s.length <= 1000
    /// 1 <= k <= 1000
    /// s 仅由小写英文字母组成。
    int beautifulSubstrings(string s, int k) {
        int n = (int)s.size();
        
        auto check = [](char ch) {
            if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u')  {
                return true;
            }
            return false;
        };
        
        vector<vector<int>> dp(2, vector(n+1,0));
        for (int i = 0; i < n; i++) {
            bool flag = check(s[i]);
            dp[flag][i+1] = dp[flag][i] + 1;
            dp[1-flag][i+1] = dp[1-flag][i];
        }
        
        int count = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = i - 1; j > 0; j -= 2) {
                int vow = dp[1][i] - dp[1][j-1];
                int con = dp[0][i] - dp[0][j-1];
                if (vow == con && (vow * con) % k == 0) {
                    count ++;
                }
            }
        }
        return count;
    }
    
    // MARK: #100142. 交换得到字典序最小的数组
    
    /// #100142. 交换得到字典序最小的数组
    /// 题目难度 Medium
    ///
    /// 给你一个下标从 0 开始的 正整数 数组 nums 和一个 正整数 limit 。
    ///
    /// 在一次操作中，你可以选择任意两个下标 i 和 j，如果 满足 |nums[i] - nums[j]| <= limit ，则交换 nums[i] 和 nums[j] 。
    ///
    /// 返回执行任意次操作后能得到的 字典序最小的数组 。
    ///
    /// 如果在数组 a 和数组 b 第一个不同的位置上，数组 a 中的对应字符比数组 b 中的对应字符的字典序更小，则认为数组 a 就比数组 b /// 字典序更小。例如，数组 [2,10,3] 比数组 [10,2,3] 字典序更小，下标 0 处是两个数组第一个不同的位置，且 2 < 10 。
    ///
    /// 示例 1：
    /// 输入：nums = [1,5,3,9,8], limit = 2
    /// 输出：[1,3,5,8,9]
    /// 解释：执行 2 次操作：
    /// - 交换 nums[1] 和 nums[2] 。数组变为 [1,3,5,9,8] 。
    /// - 交换 nums[3] 和 nums[4] 。数组变为 [1,3,5,8,9] 。
    /// 即便执行更多次操作，也无法得到字典序更小的数组。
    /// 注意，执行不同的操作也可能会得到相同的结果。
    /// 示例 2：

    /// 输入：nums = [1,7,6,18,2,1], limit = 3
    /// 输出：[1,6,7,18,1,2]
    /// 解释：执行 3 次操作：
    /// - 交换 nums[1] 和 nums[2] 。数组变为 [1,6,7,18,2,1] 。
    /// - 交换 nums[0] 和 nums[4] 。数组变为 [2,6,7,18,1,1] 。
    /// - 交换 nums[0] 和 nums[5] 。数组变为 [1,6,7,18,1,2] 。
    /// 即便执行更多次操作，也无法得到字典序更小的数组。
    /// 示例 3：

    /// 输入：nums = [1,7,28,19,10], limit = 3
    /// 输出：[1,7,28,19,10]
    /// 解释：[1,7,28,19,10] 是字典序最小的数组，因为不管怎么选择下标都无法执行操作。
    ///

    /// 提示：

    /// 1 <= nums.length <= 10^5
    /// 1 <= nums[i] <= 10^9
    /// 1 <= limit <= 10^9
    vector<int> lexicographicallySmallestArray(vector<int>& nums, int limit) {
        int n = (int)nums.size();
        vector<int> resNums = nums;
                
        vector<pair<int, int>> vp(n);
        for (int i = 0; i < n; i++) {
            vp[i] = {nums[i], i};
        }
        sort(vp.begin(), vp.end(), [](pair<int, int> a, pair<int, int> b) {
            return a.first < b.first;
        });
        
        for (int i = 0; i < n; i++) {
            auto it = find(vp.begin(), vp.end(), pair<int,int>(resNums[i], i));
            
            bool isSwap = false;
            auto cnt = it - vp.begin();
            // Todo: 这里应该持续向前交换. 数量大时超时，换二分法向前查找。
            for (int j = (int)cnt - 1; j >= 0; j--) {
                if (resNums[i] - vp[j].first <= limit) {
                    swap(resNums[i], resNums[vp[j].second]);
                    isSwap = true;
                    (*it).second = vp[j].second;
                    it = vp.begin() + j;
                } else {
                    break;
                }
            }
            vp.erase(it);
        }
        return resNums;
    }
};

#endif /* WP372_hpp */
