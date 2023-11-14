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
        vector<int> cnts(n);
        
        auto f2t = [&](int f, int t, int w) {
            bool add = 1;
            if (wm[f][t] != distanceThreshold*2) add = 0;
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
            if (cnts[i] <= cnts[res])
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
        for (int i = 0; i < n; ++i) {
            int cnt = 0;
            for (int j = 0; j < n; ++j) {
                if (wm[i][j] <= distanceThreshold) {
                    cnt++;
                }
            }
            if (cnt <= maxcnt) {
                res = i; maxcnt = cnt;
            }
        }
        for (int i = 0; i < n; i++) {
            if (cnts[i] <= maxcnt) {
                res = i; maxcnt = cnts[i];
            }
        }
        return res;
    }
};

void test_s2311();

#endif /* Solution2311_hpp */
