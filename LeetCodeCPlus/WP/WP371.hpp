//
//  WP371.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/11/12.
//

#ifndef WP371_hpp
#define WP371_hpp

#include <stdio.h>

#include <vector>
#include <string>
#include <numeric>
#include <stack>

using namespace std;

class Solution_WP371 {
    struct Node {
        vector<Node*> subnodes;
        int cnt = 0;

        void setupSubnodes() {
            if (subnodes.size() == 0) {
                subnodes.push_back(new Node());
                subnodes.push_back(new Node());
            }
        }
        
        Node* operator [](int idx) {
            setupSubnodes();
            return subnodes[idx];
        }
    };
    
public:
    /// MARK: #100120. 找出强数对的最大异或值 I
    
    /// #100120. 找出强数对的最大异或值 I
    ///
    /// 题目难度 Easy
    ///
    /// 给你一个下标从 0 开始的整数数组 nums 。如果一对整数 x 和 y 满足以下条件，则称其为 强数对 ：
    ///
    /// - |x - y| <= min(x, y)
    ///
    /// 你需要从 nums 中选出两个整数，且满足：这两个整数可以形成一个强数对，并且它们的按位异或（XOR）值是在该数组所有强数对中的 最大值 。
    ///
    /// 返回数组 nums 所有可能的强数对中的 最大 异或值。
    ///
    /// 注意，你可以选择同一个整数两次来形成一个强数对。
    int maximumStrongPairXor(vector<int>& nums) {
        int n = (int)nums.size();
        int res = 0;
        for (int i = 0; i < n; i++) {
            auto& x = nums[i];
            for (int j = i + 1; j < n; j++) {
                auto& y = nums[j];
                if (abs(x-y) <= min(x, y)) {
                    int temp = x^y;
                    if (res < temp) res = temp;
                }
            }
        }
        return res;
    }
    
    /// MARK: #100128. 高访问员工
    
    /// #100128. 高访问员工
    /// 题目难度 Medium
    ///
    /// 给你一个长度为 n 、下标从 0 开始的二维字符串数组 access_times 。对于每个 i（0 <= i <= n - 1 ），access_times[i][0] 表示某位员工的姓名，access_times[i][1] 表示该员工的访问时间。access_times 中的所有条目都发生在同一天内。
    ///
    /// 访问时间用 四位 数字表示， 符合 24 小时制 ，例如 "0800" 或 "2250" 。
    ///
    /// 如果员工在 同一小时内 访问系统 三次或更多 ，则称其为 高访问 员工。
    ///
    /// - 时间间隔正好相差一小时的时间 不 被视为同一小时内。例如，"0815" 和 "0915" 不属于同一小时内。
    ///
    /// - 一天开始和结束时的访问时间不被计算为同一小时内。例如，"0005" 和 "2350" 不属于同一小时内。
    ///
    /// 以列表形式，按任意顺序，返回所有 高访问 员工的姓名。
    ///
    /// @code
    /// 示例 1：
    /// 输入：access_times = [["a","0549"],["b","0457"],["a","0532"],["a","0621"],["b","0540"]]
    /// 输出：["a"]
    /// 解释："a" 在时间段 [05:32, 06:31] 内有三条访问记录，时间分别为 05:32 、05:49 和 06:21 。
    /// 但是 "b" 的访问记录只有两条。
    /// 因此，答案是 ["a"] 。
    ///
    /// 示例 2：
    /// 输入：access_times = [["d","0002"],["c","0808"],["c","0829"],["e","0215"],["d","1508"],["d","1444"],["d","1410"],["c","0809"]]
    /// 输出：["c","d"]
    /// 解释："c" 在时间段 [08:08, 09:07] 内有三条访问记录，时间分别为 08:08 、08:09 和 08:29 。
    /// "d" 在时间段 [14:10, 15:09] 内有三条访问记录，时间分别为 14:10 、14:44 和 15:08 。
    /// 然而，"e" 只有一条访问记录，因此不能包含在答案中，最终答案是 ["c","d"] 。
    ///
    /// 示例 3：
    /// 输入：access_times = [["cd","1025"],["ab","1025"],["cd","1046"],["cd","1055"],["ab","1124"],["ab","1120"]]
    /// 输出：["ab","cd"]
    /// 解释："ab"在时间段 [10:25, 11:24] 内有三条访问记录，时间分别为 10:25 、11:20 和 11:24 。
    /// "cd" 在时间段 [10:25, 11:24] 内有三条访问记录，时间分别为 10:25 、10:46 和 10:55 。
    /// 因此，答案是 ["ab","cd"] 。
    ///
    /// @endcode
    ///
    /// 提示：
    ///
    /// - 1 <= access_times.length <= 100
    /// - access_times[i].length == 2
    /// - 1 <= access_times[i][0].length <= 10
    /// - access_times[i][0] 仅由小写英文字母组成。
    /// - access_times[i][1].length == 4
    /// - access_times[i][1] 采用24小时制表示时间。
    /// - access_times[i][1] 仅由数字 '0' 到 '9' 组成。
    vector<string> findHighAccessEmployees(vector<vector<string>>& access_times) {
        sort(access_times.begin(), access_times.end(), [](vector<string>& a, vector<string>& b) {
            return a[0] < b[0] || (a[0] == b[0] && a[1] < b[1]);
        });
        
        vector<string> res;
        int n = (int)access_times.size();
        for (int i = 0; i < n - 2; i++) {
            auto& a = access_times[i];
            auto& b = access_times[i+2];
            if (!res.empty() && res.back() == a[1]) {
                continue;
            }
            if (a[0] == b[0] && strtol(a[1].c_str(), nullptr, 10) + 100 > strtol(b[1].c_str(), nullptr, 10)) {
                res.push_back(a[0]);
            }
        }
        return res;
    }
    
    /// MARK: #100117. 最大化数组末位元素的最少操作次数
    
    /// #100117. 最大化数组末位元素的最少操作次数
    /// 题目难度 Medium
    ///
    /// 给你两个下标从 0 开始的整数数组 nums1 和 nums2 ，这两个数组的长度都是 n 。
    ///
    /// 你可以执行一系列 操作（可能不执行）。
    ///
    /// 在每次操作中，你可以选择一个在范围 [0, n - 1] 内的下标 i ，并交换 nums1[i] 和 nums2[i] 的值。
    ///
    /// 你的任务是找到满足以下条件所需的 最小 操作次数：
    ///
    /// - nums1[n - 1] 等于 nums1 中所有元素的 最大值 ，即 nums1[n - 1] = max(nums1[0], nums1[1], ..., nums1[n - 1]) 。
    /// - nums2[n - 1] 等于 nums2 中所有元素的 最大值 ，即 nums2[n - 1] = max(nums2[0], nums2[1], ..., nums2[n - 1]) 。
    /// 以整数形式，表示并返回满足上述 全部 条件所需的 最小 操作次数，如果无法同时满足两个条件，则返回 -1 。
    ///
    /// @code
    ///
    /// 示例 1：
    /// 输入：nums1 = [1,2,7]，nums2 = [4,5,3]
    /// 输出：1
    /// 解释：在这个示例中，可以选择下标 i = 2 执行一次操作。
    /// 交换 nums1[2] 和 nums2[2] 的值，nums1 变为 [1,2,3] ，nums2 变为 [4,5,7] 。
    /// 同时满足两个条件。
    /// 可以证明，需要执行的最小操作次数为 1 。
    /// 因此，答案是 1 。
    ///
    /// 示例 2：
    /// 输入：nums1 = [2,3,4,5,9]，nums2 = [8,8,4,4,4]
    /// 输出：2
    /// 解释：在这个示例中，可以执行以下操作：
    /// 首先，选择下标 i = 4 执行操作。
    /// 交换 nums1[4] 和 nums2[4] 的值，nums1 变为 [2,3,4,5,4] ，nums2 变为 [8,8,4,4,9] 。
    /// 然后，选择下标 i = 3 执行操作。
    /// 交换 nums1[3] 和 nums2[3] 的值，nums1 变为 [2,3,4,4,4] ，nums2 变为 [8,8,4,5,9] 。
    /// 同时满足两个条件。
    /// 可以证明，需要执行的最小操作次数为 2 。
    /// 因此，答案是 2 。
    ///
    /// 示例 3：
    /// 输入：nums1 = [1,5,4]，nums2 = [2,5,3]
    /// 输出：-1
    /// 解释：在这个示例中，无法同时满足两个条件。
    /// 因此，答案是 -1 。
    /// @endcode
    ///
    /// 提示：
    ///
    /// 1 <= n == nums1.length == nums2.length <= 1000
    /// 1 <= nums1[i] <= 10^9
    /// 1 <= nums2[i] <= 10^9
    ///
    int minOperations(vector<int>& nums1, vector<int>& nums2) {
        // Todo:
        return 0;
    }
    
    /// MARK: #100124. 找出强数对的最大异或值 II
    
    /// #100124. 找出强数对的最大异或值 II
    /// 题目难度 Hard
    ///
    /// 给你一个下标从 0 开始的整数数组 nums 。如果一对整数 x 和 y 满足以下条件，则称其为 强数对 ：
    ///
    /// - |x - y| <= min(x, y)
    ///
    /// 你需要从 nums 中选出两个整数，且满足：这两个整数可以形成一个强数对，并且它们的按位异或（XOR）值是在该数组所有强数对中的 最大值 。
    ///
    /// 返回数组 nums 所有可能的强数对中的 最大 异或值。
    ///
    /// 注意，你可以选择同一个整数两次来形成一个强数对。
    int maximumStrongPairXorII(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = (int)nums.size();
        int res = 0;
        
        auto highbit = [&](int num) {
            int bitcount = 0;
            while (num > 0) {
                num >>= 1;
                bitcount ++;
            }
            return bitcount;
        };
        
        // 31 - __builtin_clz(nums.back());
        int maxbitcount = highbit(nums.back());
        
        /*
         01000100
         01000101
         01000110
         10000111
         10001000
         10001001
         */
        
        auto root = new Node();
        auto addnode = [maxbitcount, root](int num) {
            Node* node = root;
            for (int i = maxbitcount; i >= 0; i--) {
                int bit = (num >> i) & 1;
                node->setupSubnodes();
                node = node->subnodes[bit];
                node->cnt ++;
            }
        };
        auto removenode = [maxbitcount, root](int num) {
            Node* node = root;
            for (int i = maxbitcount; i >= 0; i--) {
                int bit = (num >> i) & 1;
                node->setupSubnodes();
                node = node->subnodes[bit];
                node->cnt --;
            }
        };
        
        for (int i = 0, left = 0; i < n; i++) {
            auto& y = nums[i];
            
            addnode(y);
            while (nums[left] * 2 < y) {
                removenode(nums[left]);
                left ++;
            }
            int ans = 0;
            Node* node = root;
            for (int i = maxbitcount; i >= 0; i--) {
                int bit = (y >> i) & 1;
                node->setupSubnodes();
                if (node->subnodes[bit^1]->cnt) {
                    ans |= 1 << i;
                    bit ^= 1;
                }
                node = node->subnodes[bit];
            }
            res = max(res, ans);
        }
        return res;
    }
};

#endif /* WP371_hpp */
