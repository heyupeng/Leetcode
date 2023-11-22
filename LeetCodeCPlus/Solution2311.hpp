//
//  Solution2311.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/11/9.
//

#ifndef Solution2311_hpp
#define Solution2311_hpp

#include <stdio.h>

#include <math.h>

using namespace std;
#include <vector>
#include <map>
#include <stack>
#include <string>
#include <set>
#include <queue>
#include <numeric>

class Solution2311 {
public:
    
    /// #1
    /// 给你一个下标从 0 开始大小为 m x n 的二维整数数组 grid ，它表示一个网格图。每个格子为下面 3 个值之一：
    ///
    /// - 0 表示草地。
    /// - 1 表示着火的格子。
    /// - 2 表示一座墙，你跟火都不能通过这个格子。
    
    /// 一开始你在最左上角的格子 (0, 0) ，你想要到达最右下角的安全屋格子 (m - 1, n - 1) 。每一分钟，你可以移动到 相邻 的草地格子。每次你移动 之后 ，着火的格子会扩散到所有不是墙的 相邻 格子。
    ///
    /// 请你返回你在初始位置可以停留的 最多 分钟数，且停留完这段时间后你还能安全到达安全屋。如果无法实现，请你返回 -1 。如果不管你在初始位置停留多久，你 总是 能到达安全屋，请你返回 10^9 。
    ///
    /// - 注意，如果你到达安全屋后，火马上到了安全屋，这视为你能够安全到达安全屋。
    ///
    /// 如果两个格子有共同边，那么它们为 相邻 格子。
    int maximumMinutes(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> dirs = {{0,1}, {1,1}, {0,-1}, {-1,-1}};
        
        /// 着火点
        queue<vector<int>> q;
        for (int i = 0; i < m; i++)  {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    q.push({i,j});
                }
            }
        }
        
        auto isclamp = [](int v, int lo, int hi) {
            if (v >= lo && v <= hi) return true;
            return false;
        };
        
        /// 所有格子着火时间
        while (!q.empty()) {
            vector<int> coor = q.front();
            q.pop();
            int t = grid[coor[0]][coor[1]];
            t >>= 2; t += 1; t <<= 2;
            
            for (auto& dir : dirs) {
                int x = coor[0] + dir[0], y = coor[1] + dir[1];
                if (isclamp(x, 0, m-1) && isclamp(y, 0, n-1) &&
                    grid[x][y] == 0) {
                    grid[x][y] = t;
                    q.push({x, y});
                }
            }
        }
        
        if (grid[m-1][n-1] >> 2 == 0) {
            return 10e9;
        }
        
        /// 格子最短到达时间
        vector<vector<int>> steptime(m, vector<int>(n,-1));
        steptime[0][0] = 0;
        int t = 0;
        q.push({0,0});
        while (!q.empty()) {
            vector<int> coor = q.front();
            q.pop();
            t += 1;
            
            for (auto& dir : dirs) {
                int x1 = coor[0] + dir[0], y1 = coor[1] + dir[1];
                if (isclamp(x1, 0, m-1) && isclamp(y1, 0, n-1) &&
                    grid[x1][y1] == 0 && steptime[x1][y1] == -1) {
                    if (grid[x1][y1] >> 2 < t)
                        continue;
                    
                    steptime[x1][y1] = t;
                    q.push({x1, y1});
                }
            }
        }
        
        if (grid[m-1][n-1] >> 2 < steptime[m-1][n-1]) {
            return -1;
        }
        int ans = (grid[m-1][n-1] >> 2) - steptime[m-1][n-1];
        int last = min(steptime[m-1][n] > 0 ? : 1e9, steptime[m][n-1] > 0 ? : 1e9);
        if (last == steptime[m-1][n]) {
            if ((grid[m-1][n] >> 2) - steptime[m-1][n] == ans + 1) {
                ans--;
            }
        }
        else {
            if ((grid[m][n-1] >> 2) - steptime[m][n-1] == ans + 1) {
                ans--;
            }
        }
        return ans;
    }
    
    bool strongPasswordCheckerII(string password) {
        if (password.size() < 8)
            return false;
        
        bool hasdigit = false, haslower = false, hasupper = false;
//        for (int i = 0; i < password.size(); i++) {
//            if (!hasdigit)
//                isdigit(password[i]);
//            if (!haslower)
//                islower(password[i]);
//            if (!hasupper)
//                isupper(password[i]);
//        }
        
        return true;
    }
    
    int minSwapsCouples(vector<int>& row) {
        int n = row.size();
        int res = 0;
        for (int i = 0; i < n; i+=2) {
            int a = row[i];
            int b = a^1;
            if (row[i+1] == b) {
                continue;
            }
            for (int j = i+2; j < n; j ++) {
                if (row[j] == b) {
                    swap(row[j], row[i+1]);
                    res += 1;
                    break;
                }
            }
        }
        return res;
    }
    
#pragma mark - dayly 11/14 - #1334. 阈值距离内邻居最少的城市

    /// #1334. 阈值距离内邻居最少的城市
    ///
    /// 有 n 个城市，按从 0 到 n-1 编号。给你一个边数组 edges，其中 edges[i] = [fromi, toi, weighti] 代表 fromi 和 toi 两个城市之间的双向加权边，距离阈值是一个整数 distanceThreshold。
    ///
    /// 返回能通过某些路径到达其他城市数目最少、且路径距离 最大 为 distanceThreshold 的城市。如果有多个这样的城市，则返回编号最大的城市。
    ///
    /// 注意，连接城市 i 和 j 的路径的距离等于沿该路径的所有边的权重之和。
    int findTheCity(int n, vector<vector<int>>& edges, int distanceThreshold) {
        vector<vector<int>> g(n);
        vector<vector<int>> wm(n, vector<int>(n, distanceThreshold*2));
        
        auto f2t = [&](int f, int t, int w) {
            bool add = 1;
            if (wm[f][t] != distanceThreshold*2) add = 0;
            wm[f][t] = w;
            wm[t][f] = w;
            if (!add) return;
            wm[f][f] ++;
            wm[t][t] ++;
        };
        
        // wm[i][i] 记录
        for (int i = 0; i < n; i++) wm[i][i] = 0;
        for (auto& edge: edges) {
            if (edge[2] > distanceThreshold)
                continue;
            int f = edge[0], t = edge[1], w = edge[2];
            g[f].push_back(t);
            g[t].push_back(f);
            f2t(f, t, w);
        }
        
        for (int k = 0; k < n; k++) {
            auto& gg = g[k];
            // 以编号 k 的节点为锚点，连接左右两个点。
            for (int i = 0; i < gg.size(); i++) {
                for (int j = i+1; j < gg.size(); j++) {
                    int &x = gg[i], &y = gg[j];
                    int d = wm[k][x] + wm[k][y];
                    if (d > distanceThreshold || d > wm[x][y])
                        continue;
                    if (wm[x][y] > distanceThreshold) {
                        g[x].push_back(y);
                        g[y].push_back(x);
                    }
                    f2t(x, y, d);
                }
            }
        }
        int res = 0;
        for (int i = 0; i < n; i++)
            if (wm[i][i] <= wm[res][res])
                res = i;
        
        return res;
    }
    
    int findTheCity_2(int n, vector<vector<int>>& edges, int distanceThreshold) {
        vector<vector<int>> wm(n, vector<int>(n, distanceThreshold*2));
        vector<int> cnts(n);
        
        auto f2t = [&](int f, int t, int w) {
            if (wm[f][t] <= w || w > distanceThreshold)
                return;
            bool add = wm[f][t] == distanceThreshold*2;
            wm[f][t] = w;
            wm[t][f] = w;
            if (!add) return;
            cnts[f] ++;
            cnts[t] ++;
        };
        
        for (auto& edge: edges) {
            if (edge[2] > distanceThreshold)
                continue;
            int f = edge[0], t = edge[1], w = edge[2];
            f2t(f, t, w);
        }
        
        for (int k = 0; k < n; ++k) {
            // 以 k 点为锚点连接两个点
            wm[k][k] = 0;
            for (int i = 0; i < n; ++i) {
                for (int j = i+1; j < n; ++j) {
                    f2t(i, j, wm[i][k] + wm[k][j]);
                }
            }
        }
        
        int res = -1;
        int maxcnt = distanceThreshold*2;
        for (int i = 0; i < n; i++) {
            if (cnts[i] <= maxcnt) {
                res = i; maxcnt = cnts[i];
            }
        }
        return res;
    }
    
// MARK: #30. 串联所有单词的子串
    
    /// #30. 串联所有单词的子串
    /// (困难)
    ///
    /// 给定一个字符串 s 和一个字符串数组 words。 words 中所有字符串 长度相同。
    ///
    ///  s 中的 串联子串 是指一个包含  words 中所有字符串以任意顺序排列连接起来的子串。
    ///
    /// 例如，如果 words = ["ab","cd","ef"]， 那么 "abcdef"， "abefcd"，"cdabef"， "cdefab"，"efabcd"， 和 "efcdab" 都是串联子串。 "acdbef" 不是串联子串，因为他不是任何 words 排列的连接。
    ///
    /// 返回所有串联子串在 s 中的开始索引。你可以以 任意顺序 返回答案。
    ///
    /// @code
    /// 示例 1：
    /// 输入：s = "barfoothefoobarman", words = ["foo","bar"]
    /// 输出：[0,9]
    /// 解释：因为 words.length == 2 同时 words[i].length == 3，连接的子字符串的长度必须为 6。
    /// 子串 "barfoo" 开始位置是 0。它是 words 中以 ["bar","foo"] 顺序排列的连接。
    /// 子串 "foobar" 开始位置是 9。它是 words 中以 ["foo","bar"] 顺序排列的连接。
    /// 输出顺序无关紧要。返回 [9,0] 也是可以的。
    ///
    /// 示例 2：
    /// 输入：s = "wordgoodgoodgoodbestword", words = ["word","good","best","word"]
    /// 输出：[]
    /// 解释：因为 words.length == 4 并且 words[i].length == 4，所以串联子串的长度必须为 16。
    /// s 中没有子串长度为 16 并且等于 words 的任何顺序排列的连接。
    /// 所以我们返回一个空数组。
    ///
    /// 示例 3：
    /// 输入：s = "barfoofoobarthefoobarman", words = ["bar","foo","the"]
    /// 输出：[6,9,12]
    /// 解释：因为 words.length == 3 并且 words[i].length == 3，所以串联子串的长度必须为 9。
    /// 子串 "foobarthe" 开始位置是 6。它是 words 中以 ["foo","bar","the"] 顺序排列的连接。
    /// 子串 "barthefoo" 开始位置是 9。它是 words 中以 ["bar","the","foo"] 顺序排列的连接。
    /// 子串 "thefoobar" 开始位置是 12。它是 words 中以 ["the","foo","bar"] 顺序排列的连接。
    ///
    /// @endcode
    ///
    /// 提示：
    /// - 1 <= s.length <= 104
    /// - 1 <= words.length <= 5000
    /// - 1 <= words[i].length <= 30
    /// - words[i] 和 s 由小写英文字母组成
    ///
    vector<int> findSubstring(string s, vector<string>& words) {
        int n = (int)words.size();
        int wl = (int)words[0].size();
        int sl = (int)s.size();
        
        vector<int> res;
        map<string, int> mp;
        for (auto & word: words) {
            mp[word] ++;
        }
        
        vector<int> flags(sl, 0);
        int cnt = n;
        int si = 0;
        auto cstr = s.c_str();
        for (int k = 0; k < sl - n * wl + 1; k++) {
            if (flags[k] != 0) continue;
            if (cnt != n) {
                mp.clear();
                for (auto & word: words) {
                    mp[word] ++;
                }
            }
            cnt = n; si = k;
            
            for (int i = k; i < sl - wl + 1; ) {
                if (flags[si] != 0) break;
                
                string sub = s.substr(i, wl);
                if (!mp.count(sub)) {
                    for (int j = si; j < i+1; j+=wl) flags[j] = -1;
                    break;
                }
                if (mp[sub] == 0) {
                    string ss = s.substr(si, wl);
                    while (ss != sub) {
                        flags[si] = -1;
                        mp[ss] ++;
                        cnt ++;
                        si += wl;
                        ss = s.substr(si, wl);
                    }
                    flags[si] = -1;
                    si += wl;
                    if (flags[si] != 0)
                        break;
                } else {
                    mp[sub] --;
                    cnt --;
                }
                
                i += wl;
                if (cnt == 0) {
                    res.push_back(si);
                    flags[si] = 1;
                    sub = s.substr(si, wl);
                    mp[sub] ++;
                    cnt ++;
                    si += wl;
                }
            }
        }
        return res;
    }
    
    // MARK: #59. 螺旋矩阵 II
    
    /// #59. 螺旋矩阵 II
    /// (中等)
    ///
    /// 给你一个正整数 n ，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的 n x n 正方形矩阵 matrix 。
    /// @code
    /// 示例 1：
    /// 输入：n = 3
    /// 输出：[[1,2,3],[8,9,4],[7,6,5]]
    ///
    /// 示例 2：
    /// 输入：n = 1
    /// 输出：[[1]]
    /// @endcode
    ///
    /// 提示：
    /// - 1 <= n <= 20
    ///
    vector<vector<int>> generateMatrix(int n) {
        vector<vector<int>> mat(n, vector<int>(n,0));
        mat[n/2][n/2] = n*n;
        int l = 0;
        int v = 0;
        while (l <= n/2) {
            for (int i = 0; i < n-1-2*l; i++) {
                mat[l][l+i] = ++v;
            }
            for (int i = 0; i < n-1-2*l; i++) {
                mat[l+i][n-1-l] = ++v;
            }
            for (int i = 0; i < n-1-2*l; i++) {
                mat[n-1-l][n-1-l-i] = ++v;
            }
            for (int i = 0; i < n-1-2*l; i++) {
                mat[n-1-l-i][l] = ++v;
            }
            l++;
        }
         return mat;
     }
    
    // MARK: #54. 螺旋矩阵
    
    /// #54. 螺旋矩阵
    /// (中等)
    ///
    /// 给你一个 m 行 n 列的矩阵 matrix ，请按照 顺时针螺旋顺序 ，返回矩阵中的所有元素。
    ///
    /// @code
    /// 示例 1：
    /// 输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]
    /// 输出：[1,2,3,6,9,8,7,4,5]
    ///
    /// 示例 2：
    /// 输入：matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
    /// 输出：[1,2,3,4,8,12,11,10,9,5,6,7]
    /// @endcode
    ///
    /// 提示：
    ///
    /// - m == matrix.length
    /// - n == matrix[i].length
    /// - 1 <= m, n <= 10
    /// - -100 <= matrix[i][j] <= 100
    ///
    vector<int> spiralOrder(vector<vector<int>>& matrix) {
        int m = (int)matrix.size();
        int n = (int)matrix[0].size();
        vector<int> mat(m*n,0);
        
        int l = 0; int r = n - 1;
        int t = 0; int b = m - 1;
        int k = 0;
        while (k < m*n) {
            //printf("1-%d, ", k);
            for (int i = l; i <= r; i++) {
                mat[k] = matrix[l][i];
                k++;
            }
            t ++;
            //printf("2-%d, ", k);
            for (int i = t; i <= b; i++) {
                mat[k] = matrix[i][r];
                k++;
            }
            r --;
            //printf("3-%d, ", k);
            for (int i = r; i >= l && k < m*n; i--) {
                mat[k] = matrix[b][i];
                k++;
            }
            b --;
            //printf("4-%d, ", k);
            for (int i = b; i >= t && k < m*n; i--) {
                mat[k] = matrix[i][l];
                k++;
            }
            l++;
        }
        return mat;
    }

    // MARK: #2736. 最大和查询
    
    /// #2736. 最大和查询
    /// (困难)
    ///
    /// 给你两个长度为 n 、下标从 0 开始的整数数组 nums1 和 nums2 ，另给你一个下标从 1 开始的二维数组 queries ，其中 queries[i] = [xi, yi] 。
    ///
    /// 对于第 i 个查询，在所有满足 nums1[j] >= xi 且 nums2[j] >= yi 的下标 j (0 <= j < n) 中，找出 nums1[j] + nums2[j] 的 最大值 ，如果不存在满足条件的 j 则返回 -1 。
    ///
    /// 返回数组 answer ，其中 answer[i] 是第 i 个查询的答案。
    vector<int> maximumSumQueries(vector<int>& nums1, vector<int>& nums2, vector<vector<int>>& queries) {
        int n = (int)nums1.size();
        int qn = (int)queries.size();
        
        vector<pair<int,int>> nums;
        for (int i = 0; i < n; i++) {
            nums.push_back({nums1[i], nums2[i]});
        }
        sort(nums.begin(), nums.end(), [](pair<int,int>& p1, pair<int,int>& p2){
            return p1.first > p2.first || (p1.first == p2.first && p1.second > p2.second);
        });
        
        for (int i = 0; i < qn; i++) {
            queries[i].push_back(i);
        }
        sort(queries.begin(), queries.end(), [](vector<int>& a, vector<int>& b){
            return a[0] > b[0] || ( a[0] == b[0] && a[1] > b[1]);
        });
        
        vector<int> res(qn, -1);
        vector<pair<int, int>> dp;
        auto l = nums.begin();
        int j = 0;
        for (auto& q: queries) {
            int &x = q[0], &y = q[1];
            while (j < n && nums[j].first >= x) {
                auto [a1, a2] = nums[j];
                while (dp.size() > 0 && dp.back().second <= a1 + a2) {
                    // 删减掉 a1[j-1] + a2[j-1] <= a1 + a2。
                    dp.pop_back();
                }
                if (dp.size() == 0 || dp.back().first < a2) {
                    // 保存 a2 > a2[j-1] 的情况，后方可能需要。
                    dp.push_back({a2, a1+a2});
                }
                j++;
            }
            long k = lower_bound(dp.begin(), dp.end(), make_pair(y, 0)) - dp.begin();
            if (k < dp.size()) {
                res[q[2]] = dp[k].second;
            }
        }
        return res;
    }
    
    // MARK: #2342. 数位和相等数对的最大和
    
    /// #2342. 数位和相等数对的最大和
    /// (中等)
    ///
    /// 给你一个下标从 0 开始的数组 nums ，数组中的元素都是 正 整数。请你选出两个下标 i 和 j（i != j），且 nums[i] 的数位和 与  nums[j] 的数位和相等。
    ///
    /// 请你找出所有满足条件的下标 i 和 j ，找出并返回 nums[i] + nums[j] 可以得到的 最大值 。
    ///
    /// 示例 1：
    /// 输入：nums = [18,43,36,13,7]
    /// 输出：54
    /// 解释：满足条件的数对 (i, j) 为：
    /// - (0, 2) ，两个数字的数位和都是 9 ，相加得到 18 + 36 = 54 。
    /// - (1, 4) ，两个数字的数位和都是 7 ，相加得到 43 + 7 = 50 。
    /// 所以可以获得的最大和是 54 。
    ///
    /// 示例 2：
    /// 输入：nums = [10,12,19,14]
    /// 输出：-1
    /// 解释：不存在满足条件的数对，返回 -1 。
    ///
    /// 提示：
    /// - 1 <= nums.length <= 1e5
    /// - 1 <= nums[i] <= 1e9
    ///
    int maximumSum(vector<int>& nums) {
        // 存储遍历最大位数和的数值。
        vector<int> dp(100, 0);
        int res = -1;
        for (auto num: nums) {
            int sum = 0;
            int temp = num;
            while (temp != 0) {
                sum += temp%10;
                temp /= 10;
            }
            if (dp[sum] > 0) {
                res = max(res, dp[sum] + num);
            }
            if (dp[sum] < num) {
                dp[sum] = num;
            }
        }
        return res;
    }
    
    // MARK: #689. 三个无重叠子数组的最大和
    
    /// #689. 三个无重叠子数组的最大和
    /// (困难)
    ///
    /// 给你一个整数数组 nums 和一个整数 k ，找出三个长度为 k 、互不重叠、且全部数字和（3 * k /// 项）最大的子数组，并返回这三个子数组。
    ///
    /// 以下标的数组形式返回结果，数组中的每一项分别指示每个子数组的起始位置（下标从 0 /// 开始）。如果有多个结果，返回字典序最小的一个。
    ///
    /// @code
    /// 示例 1：
    /// 输入：nums = [1,2,1,2,6,7,5,1], k = 2
    /// 输出：[0,3,5]
    /// 解释：子数组 [1, 2], [2, 6], [7, 5] 对应的起始下标为 [0, 3, 5]。
    /// 也可以取 [2, 1], 但是结果 [1, 3, 5] 在字典序上更大。
    /// 示例 2：
    /// 输入：nums = [1,2,1,2,1,2,1,2,1], k = 2
    /// 输出：[0,2,4]
    /// @endcode
    ///
    /// 提示：
    /// - 1 <= nums.length <= 2 * 10^4
    /// - 1 <= nums[i] < 2^16
    /// - 1 <= k <= floor(nums.length / 3)
    ///
    vector<int> maxSumOfThreeSubarrays(vector<int>& nums, int k) {
        int n = (int)nums.size();
        int m = n - k + 1;
        vector<long> sums(m+1, 0);
        
        long sum = 0;
        for (int i = 0; i < k; i++) {
            sum += nums[i];
        }
        sums[0] = sum;
        for (int i = k; i < n; i++) {
            sum += nums[i] - nums[i-k];
            sums[i-k+1] = sum;
        }
        // 左向最大值
        vector<int> lmax(m, 0);
        iota(lmax.begin(), lmax.end(), 0);
        for (int i = 1; i < m; i++) {
            if (sums[i] <= sums[lmax[i-1]]) {
                lmax[i] = lmax[i-1];
            }
        }
        // 右向最大值
        vector<int> rmax(m+1, 0);
        iota(rmax.begin(), rmax.end(), 0);
        for (int i = m - 1  ; i >= 0; i--) {
            if (sums[i] < sums[rmax[i+1]]) {
                rmax[i] = rmax[i+1];
            }
        }
        
        sum = 0;
        vector<int> res;
        for (int i = k; i < m-k; i++) {
            int l = lmax[i-k], r = rmax[i+k];
            long v = sums[l] + sums[i] + sums[r];
            if (sum < v) {
                sum = v;
                res = {l, i, r};
            }
        }
        return res;
    }
    
    // MARK: #53. 最大子数组和
    
    /// #53. 最大子数组和
    /// (中等)
    /// [数组，贪心]
    ///
    /// 给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
    ///
    /// 子数组 是数组中的一个连续部分。
    /// @code
    /// 示例 1：
    /// 输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
    /// 输出：6
    /// 解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
    /// 示例 2：
    /// 输入：nums = [1]
    /// 输出：1
    /// 示例 3：
    /// 输入：nums = [5,4,-1,7,8]
    /// 输出：23
    /// @endcode
    /// 提示：
    /// 1 <= nums.length <= 10^5
    /// -10^4 <= nums[i] <= 10^4
    int maxSubArray(vector<int>& nums) {
        int res = nums[0];
        int sum = 0;
        for (auto& num: nums) {
            sum += num;
            res = max(res, sum);
            sum = max(sum, 0);
        }
        return res;
    }
    
    
    // MARK: #2216. 美化数组的最少删除数
    
    /// #2216. 美化数组的最少删除数
    /// (中等)
    /// [数组，贪心]
    ///
    /// 给你一个下标从 0 开始的整数数组 nums ，如果满足下述条件，则认为数组 nums 是一个 美丽数组 ：
    /// - nums.length 为偶数
    /// - 对所有满足 i % 2 == 0 的下标 i ，nums[i] != nums[i + 1] 均成立
    ///
    /// 注意，空数组同样认为是美丽数组。
    ///
    /// 你可以从 nums 中删除任意数量的元素。当你删除一个元素时，被删除元素右侧的所有元素将会向左移动一个单位以填补空缺，而左侧的元素将会保持 不变 。
    ///
    /// 返回使 nums 变为美丽数组所需删除的 最少 元素数目。
    /// @code
    /// 示例 1：
    /// 输入：nums = [1,1,2,3,5]
    /// 输出：1
    /// 解释：可以删除 nums[0] 或 nums[1] ，这样得到的 nums = [1,2,3,5] 是一个美丽数组。可以证明，要想使 nums 变为美丽数组，至少需要删除 1 个元素。
    /// 示例 2：
    /// 输入：nums = [1,1,2,2,3,3]
    /// 输出：2
    /// 解释：可以删除 nums[0] 和 nums[5] ，这样得到的 nums = [1,2,2,3] 是一个美丽数组。可以证明，要想使 nums 变为美丽数组，至少需要删除 2 个元素。
    /// @endcode
    /// 提示：
    /// - 1 <= nums.length <= 105
    /// - 0 <= nums[i] <= 105
    int minDeletion(vector<int>& nums) {
        int n = (int)nums.size();
        int size = 0;
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] != nums[i+1]) {
                size += 2;
                i++;
            }
        }
        return n - size;
    }
    
    // MARK: - #2304. 网格中的最小路径代价
    
    /// #2304. 网格中的最小路径代价
    /// (中等)
    /// (动态规划，数组）
    ///
    /// 给你一个下标从 0 开始的整数矩阵 grid ，矩阵大小为 m x n ，由从 0 到 m * n - 1 的不同整数组成。你可以在此矩阵中，从一个单元格移动到 下一行 的任何其他单元格。如果你位于单元格 (x, y) ，且满足 x < m - 1 ，你可以移动到 (x + 1, 0), (x + 1, 1), ..., (x + 1, n - 1) 中的任何一个单元格。注意： 在最后一行中的单元格不能触发移动。
    ///
    /// 每次可能的移动都需要付出对应的代价，代价用一个下标从 0 开始的二维数组 moveCost 表示，该数组大小为 (m * n) x n ，其中 moveCost[i][j] 是从值为 i 的单元格移动到下一行第 j 列单元格的代价。从 grid 最后一行的单元格移动的代价可以忽略。
    ///
    /// grid 一条路径的代价是：所有路径经过的单元格的 值之和 加上 所有移动的 代价之和 。从 第一行 任意单元格出发，返回到达 最后一行 任意单元格的最小路径代价。
    /// @code
    /// 示例 1：
    /// 输入：grid = [[5,3],[4,0],[2,1]], moveCost = [[9,8],[1,5],[10,12],[18,6],[2,4],[14,3]]
    /// 输出：17
    /// 解释：最小代价的路径是 5 -> 0 -> 1 。
    /// - 路径途经单元格值之和 5 + 0 + 1 = 6 。
    /// - 从 5 移动到 0 的代价为 3 。
    /// - 从 0 移动到 1 的代价为 8 。
    /// 路径总代价为 6 + 3 + 8 = 17 。
    /// 示例 2：
    /// 输入：grid = [[5,1,2],[4,0,3]], moveCost = [[12,10,15],[20,23,8],[21,7,1],[8,1,13],[9,10,25],[5,3,2]]
    /// 输出：6
    /// 解释：
    /// 最小代价的路径是 2 -> 3 。
    /// - 路径途经单元格值之和 2 + 3 = 5 。
    /// - 从 2 移动到 3 的代价为 1 。
    /// 路径总代价为 5 + 1 = 6 。
    /// @endcode
    /// 提示：
    /// - m == grid.length
    /// - n == grid[i].length
    /// - 2 <= m, n <= 50
    /// - grid 由从 0 到 m * n - 1 的不同整数组成
    /// - moveCost.length == m * n
    /// - moveCost[i].length == n
    /// - 1 <= moveCost[i][j] <= 100
    ///
    int minPathCost(vector<vector<int>>& grid, vector<vector<int>>& moveCost) {
        int m = (int)grid.size();
        int n = (int)grid[0].size();
        vector<int> dp[2] = {grid[0], grid[0]};
        int flag = 0;
        for (int i = 1; i < m; i++) {
            int next = 1 - flag;
            for (int j = 0; j < n; j++) {
                // 计算上一行到达当前行单元格的代价。
                int minCost = INT_MAX;
                for (int k = 0; k < n; k++) {
                    int cost = grid[i-1][k];
                    cost = dp[flag][k] + moveCost[cost][j];
                    minCost = min(minCost, cost);
                }
                dp[next][j] = minCost + grid[i][j];
            }
            flag = next;
        }
        int res = *min_element(dp[flag].begin(), dp[flag].end());
        return res;
    }
};

void test_s2311();

#endif /* Solution2311_hpp */
