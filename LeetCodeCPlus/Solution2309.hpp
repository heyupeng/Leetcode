//
//  Solution2309.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/9/22.
//

#ifndef Solution2309_hpp
#define Solution2309_hpp

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

#include "ListNode.hpp"
#include "string_to_any.hpp"
struct A {
    
};
struct B: A {
    
};
class Solution_2309 {
public:
#pragma mark - --23/09/17
    
    /// #213. 打家劫舍 II
    int robII(vector<int>& nums) {
        if (nums.size() < 2)
            return nums[0];
        
        int ans1 = _robII_part(nums, 0, (int)nums.size() - 1);
        int ans2 = _robII_part(nums, 1, (int)nums.size());
        return max(ans1, ans2);
    }
    
    int _robII_part(vector<int>& nums, int start, int end) {
        // 0: 不偷；1: 偷
        vector<int> dp = {0, 0};
        int temp1 = 0, temp2 = 0;
        for (int i = start; i < end; i++) {
            temp1 = max(dp[0], dp[1]);
            temp2 = dp[0] + nums[i];
            dp[0] = temp1;
            dp[1] = temp2;
        }
        return max(dp[0], dp[1]);
    }
    
#pragma mark - --23/09/18
    
    /// #2560. 打家劫舍 III
    int robIII(TreeNode* root) {
        vector<int> res = _robIII(root);
        return max(res[0],res[1]);
    }
    
    vector<int> _robIII(TreeNode* root) {
        if (!root)
            return {0, 0};
        
        vector<int> res1 = _robIII(root->left);
        vector<int> res2 = _robIII(root->right);
        int choised =  res1[0] + res2[0] + root->val;
        res1[0] = max(res1[0], res1[1]) + max(res2[0], res2[1]);
        res1[1] = choised;
        return res1;
    }
    
#pragma mark - --23/09/19
    
    /// #2560. 打家劫舍 IV --23/09/19
    /// 沿街有一排连续的房屋。每间房屋内都藏有一定的现金。现在有一位小偷计划从这些房屋中窃取现金。
    ///
    /// 由于相邻的房屋装有相互连通的防盗系统，所以小偷 不会窃取相邻的房屋 。
    ///
    /// 小偷的 窃取能力 定义为他在窃取过程中能从单间房屋中窃取的 最大金额 。
    ///
    /// 给你一个整数数组 nums 表示每间房屋存放的现金金额。形式上，从左起第 i 间房屋中放有 nums[i] 美元。
    ///
    /// 另给你一个整数 k ，表示窃贼将会窃取的 最少 房屋数。小偷总能窃取至少 k 间房屋。
    ///
    /// 返回小偷的 最小 窃取能力。
    /// ```
    /// 示例 1：
    ///
    /// 输入：nums = [2,3,5,9], k = 2
    /// 输出：5
    /// 解释：
    /// 小偷窃取至少 2 间房屋，共有 3 种方式：
    /// - 窃取下标 0 和 2 处的房屋，窃取能力为 max(nums[0], nums[2]) = 5 。
    /// - 窃取下标 0 和 3 处的房屋，窃取能力为 max(nums[0], nums[3]) = 9 。
    /// - 窃取下标 1 和 3 处的房屋，窃取能力为 max(nums[1], nums[3]) = 9 。
    /// 因此，返回 min(5, 9, 9) = 5 。
    ///
    /// 示例 2：
    ///
    /// 输入：nums = [2,7,9,3,1], k = 2
    /// 输出：2
    /// 解释：共有 7 种窃取方式。窃取能力最小的情况所对应的方式是窃取下标 0 和 4 处的房屋。返回 max(nums[0], nums[4]) = 2 。
    ///
    /// ```
    ///
    /// 提示：
    ///
    /// - 1 <= nums.length <= 105
    /// - 1 <= nums[i] <= 109
    /// - 1 <= k <= (nums.length + 1)/2
    int minCapability(vector<int>& nums, int k) {
        int res = INT32_MAX;
        
        int n = (int)nums.size();
        vector<vector<vector<int>>> dp(k, vector<vector<int>>(0));
        
        int li = 0;
        while (1) {
            int isOn = 1;
            vector<int> defalutIdxs = {};
            for (int i = li; i < n; i++) {
                if (isOn && nums[i] < res) {
                    defalutIdxs.push_back(i);
                    isOn = 0;
                } else {
                    isOn = 1;
                }
            }
            
            sort(defalutIdxs.begin(), defalutIdxs.end(), [&](int& a, int& b){
                return nums[a] < nums[b];
            });
            if (defalutIdxs.size() < k || nums[defalutIdxs[k-1]] >= res)
                break;
            int maxvalIdx = defalutIdxs[k-1];
            res = nums[maxvalIdx];
            
            if (nums[li] >= res)
                li += 1;
        }
        return res;
    }
    
    ///
    ///给你一个整数数组 nums 和两个整数 indexDiff 和 valueDiff 。
    ///
    /// 找出满足下述条件的下标对 (i, j)：
    ///
    /// - i != j,
    /// - abs(i - j) <= indexDiff
    /// - abs(nums[i] - nums[j]) <= valueDiff
    /// - 如果存在，返回 true ；否则，返回 false 。
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int indexDiff, int valueDiff) {
        set<int> s;
        for (int i = 0; i < nums.size(); i++) {
            // Todo
            if (s.count(nums[i]))
                break;
            s.insert(nums[i]);
            
            int end = min((int)nums.size(), i+indexDiff+1);
            for (int j = i+1; j < end; j++) {
                if (abs(nums[i] - nums[j]) <= valueDiff)
                    return true;
            }
        }
        return false;
    }
    
#pragma mark - --23/09/19
    
    ///
    string minWindow(string& s, string& t) {
        if (s.size() < t.size())
            return "";
        
        string res = "";
        map<char, int> mp;
        for (auto& ch: t) {
            mp[ch] += 1;
        }
        
        vector<int> flags(128, 0);
        int countOfFlags = 0;
        vector<int> idxarr;
        int l = -1, r = -1, j = 0;
        for (int i = 0; i < s.size(); i++) {
            if (!mp.contains(s[i])) continue;
            idxarr.push_back(i);
            mp[s[i]] --;
            
            if (l == -1) {
                l = i;
            }
            if (mp[s[i]] > 0) continue;
            
            /* 超时。 */
//            if (r == -1) {
//                auto p = *max_element(mp.begin(), mp.end(), [](pair<char, int> p1, pair<char, int> p2) {
//                    return p1.second < p2.second;
//                });
//                if (p.second <= 0) {
//                    r = i;
//                }
//            }
//
            if (flags[s[i]] == 0 && mp[s[i]] <= 0) {
                flags[s[i]] = 1;
                countOfFlags += 1;
            }
            if (r == -1 && countOfFlags == mp.size()) {
                    r = i;
            }
            
            while (r) {
                int idx = idxarr[j];
                if (mp[s[idx]] >= 0) {
                    break;
                }
                mp[s[idx]] += 1;
//                idxarr.erase(idxarr.begin());
                j ++;
            }
            if (r - l > i - idxarr[j]) {
                l = idxarr[j];
                r = i;
            }
        }
        
        if (r == -1) return res;
        
        res = s.substr(l, r - l + 1);
        return res;
    }
    
    /// 给你一个 n 个节点的无向无根树，节点编号从 0 到 n - 1 。给你整数 n 和一个长度为 n - 1 的二维整数数组 edges ，其中 edges[i] = [ai, bi] 表示树中节点 ai 和 bi 之间有一条边。再给你一个长度为 n 的数组 coins ，其中 coins[i] 可能为 0 也可能为 1 ，1 表示节点 i 处有一个金币。
    ///
    /// 一开始，你需要选择树中任意一个节点出发。你可以执行下述操作任意次：
    ///
    /// 收集距离当前节点距离为 2 以内的所有金币，或者
    /// - 移动到树中一个相邻节点。
    /// - 你需要收集树中所有的金币，并且回到出发节点，请你返回最少经过的边数。
    ///
    /// 如果你多次经过一条边，每一次经过都会给答案加一。
    ///
    int collectTheCoins(vector<int>& coins, vector<vector<int>>& edges) {
        int n = (int)coins.size();
        if (n <= 5) return 0;
        int res = n - 4 - 1;
        vector<vector<int>> links(n);
        vector<int> cnts(n, 0);
        
        for (auto& edge: edges) {
            links[edge[0]].push_back(edge[1]);
            links[edge[1]].push_back(edge[0]);
            cnts[edge[0]] ++;
            cnts[edge[1]] ++;
        }
        
        queue<int> q;
        for (int i = 0; i < n; i++) {
            if (cnts[i] == 1 && coins[i] == 0) {
                // 无金币的叶子节点
                q.push(i);
            }
        }
        
        int edgen = n; // 有效节点个数
        while (!q.empty()) {
            edgen --;
            int idx1 = q.front();
            q.pop();
            for (auto& idx2: links[idx1]) {
                cnts[idx2] --;
                if (cnts[idx2] == 1 && coins[idx2] == 0) {
                    // 无金币的叶子节点
                    q.push(idx2);
                }
            }
        }
        
        for (int i = 0; i < n; i++) {
            if (cnts[i] == 1 && coins[i])
                // 有金币的叶子节点
                q.push(i);
        }
        
        while (!q.empty()) {
            edgen --;
            int idx1 = q.front();
            q.pop();
            for (auto& idx2: links[idx1]) {
                cnts[idx2] --;
                if (cnts[idx2] == 1) {
                    edgen --;
                }
            }
        }
        edgen --;
        res = max(edgen * 2, 0);
        return res;
    }
    
    /// #84.
    ///
    /// 给定 n 个非负整数，用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为 1 。
    ///
    /// 求在该柱状图中，能够勾勒出来的矩形的最大面积。
    ///
    /// 提示：
    /// - 1 <= heights.length <=105
    /// - 0 <= heights[i] <= 104
    int largestRectangleArea(vector<int>& heights) {
        int res = 0;
        int w = 0; int li = 0;
        for (int i = 0; i < heights.size(); i++) {
            int h = heights[i];
            if (h == 0) {
                w = 0;
                continue;
            };
            w += 1;
            
            int area = max(h, w);
            res = max(res, area);
            
            /* j >= 0 / j >= i-w+1*/
            int left = i - w + 1; // 左边界下标
//            for (int j = i-1; j >= 0; j--) {
//                if (heights[j] <= 1)
//                    break;
//                h = min(h, heights[j]);
//                area = max(area, h * (i - j + 1));
//            }
            
            bool foremodify = false; // 向前修正
            for (int j = i-1; j >= 0; j--) {
                if (heights[j] <= h)
                    break;
                heights[j] = h;
                foremodify = true;
            }
            
            int lli = li;
            for (int j = i; j >= li; j--) {
                if (heights[j] <= 1)
                    break;
                
                int minw = ceil(1.0 * res / heights[j]);
                if (minw > w) {
                    break;
                }
                
                int l = i - w + 1, r = j;
                int target = r;
                while (l <= r) {
                    int m = (l + r) / 2;
                    if (heights[m] == heights[target]) {
                        r = m - 1;
                        target = m;
                    } else {
                        l = m + 1;
                    }
                }
                j = target;
                
                int jj = target;
                
                if (heights[jj] < heights[j]) {
                    j = jj+1;
                    continue;
                }
                
                h = min(h, heights[j]);
                int a = h * (i - j + 1);
                area = max(area, a);
                if (res < area) {
                    lli = j;
                }
                res = max(res, area);
            }
            li = lli;
        }

        return res;
    }
    
#pragma mark - 22/09/22
    /// #2591. 将钱分给最多的儿童 (E) (Dayly)
    ///
    /// 给你一个整数 money ，表示你总共有的钱数（单位为美元）和另一个整数 children ，表示你要将钱分配给多少个儿童。
    ///
    /// 你需要按照如下规则分配：
    /// - 所有的钱都必须被分配。
    /// - 每个儿童至少获得 1 美元。
    /// - 没有人获得 4 美元。
    ///
    /// 请你按照上述规则分配金钱，并返回 最多 有多少个儿童获得 恰好 8 美元。如果没有任何分配方案，返回 -1 。
    ///
    /// 提示：
    /// - 1 <= money <= 200
    /// - 2 <= children <= 30
    ///
    int distMoney(int money, int children) {
        if (money < children)
            return -1;
        
        money -= children;
        int n = money/7;
        if (n > children)
            n = children;
        
        money -= 7 * n;
        if (n == children &&
            money != 0)
            n --;
        
        else if (money == 3 &&
                 n == children-1)
            n --;
        return n;
    }
    
    /// #2270. 分割数组的方案数 (M)
    ///
    /// 给你一个下标从 0 开始长度为 n 的整数数组 nums 。
    ///
    /// 如果以下描述为真，那么 nums 在下标 i 处有一个 合法的分割 ：
    /// - 前 i + 1 个元素的和 大于等于 剩下的 n - i - 1 个元素的和。
    /// - 下标 i 的右边 至少有一个 元素，也就是说下标 i 满足 0 <= i < n - 1 。
    ///
    /// 请你返回 nums 中的 合法分割 方案数。
    ///
    ///  提示：
    ///  2 <= nums.length <= 10**5
    ///  -10**5 <= nums[i] <= 10**5
    int waysToSplitArray(vector<int>& nums) {
        int res =0;
        int left = 0, right = 0;
        
        for (auto& num: nums)
            right += num;
        
        for (int i = 0; i < nums.size()-1; i++) {
            left += nums[i];
            right -= nums[i];
            if (left >=right)
                res ++;
        }
        return res;
    }
    
    /// #724. 寻找数组的中心下标 (E)
    ///
    ///给你一个整数数组 nums ，请计算数组的 中心下标 。
    ///
    ///数组 中心下标 是数组的一个下标，其左侧所有元素相加的和等于右侧所有元素相加的和。
    ///
    ///如果中心下标位于数组最左端，那么左侧数之和视为 0 ，因为在下标的左侧不存在元素。这一点对于中心下标位于数组最右端同样适用。
    ///
    ///如果数组有多个中心下标，应该返回 最靠近左边 的那一个。如果数组不存在中心下标，返回 -1 。
    ///
    int pivotIndex(vector<int>& nums) {
        int sum1 = 0, sum2 = 0;
        for (auto& num: nums)
            sum2 += num;
        
        for (int i = 0; i < nums.size(); i++) {
            auto& num = nums[i];
            sum2 -= num;
            if (sum1 == sum2) {
                return i;
            }
            sum1 += num;
        }
        return -1;
    }
    
    /// #LCP 150. 彩灯装饰记录II (E)
    ///
    /// 一棵圣诞树记作根节点为 root 的二叉树，节点值为该位置装饰彩灯的颜色编号。请按照从左到右的顺序返回每一层彩灯编号，每一层的结果记录于一行。
    ///
    vector<vector<int>> decorateRecord(TreeNode* root) {
        if (!root) return {};
        
        vector<vector<int>> res;
        vector<vector<TreeNode*>> nodes(2);
        nodes[0].push_back(root);
        int flag = 0;
        
        while (!nodes[flag].empty()) {
            vector<TreeNode*>& temp = nodes[1-flag];
            temp.clear();
            vector<int> nums;
            for (auto node: nodes[flag]) {
                nums.push_back(node->val);
                if (node->left)
                    temp.push_back(node->left);
                if (node->right)
                    temp.push_back(node->right);
            }
            res.push_back(nums);
            flag = 1 - flag;
        }
        
        return res;
    }
    
    /// #150. 逆波兰表示法求值 (M)
    ///
    /// 给你一个字符串数组 tokens ，表示一个根据 逆波兰表示法 表示的算术表达式。
    ///
    /// 请你计算该表达式。返回一个表示表达式值的整数。
    ///
    /// 注意：
    ///
    /// - 有效的算符为 '+'、'-'、'*' 和 '/' 。
    /// - 每个操作数（运算对象）都可以是一个整数或者另一个表达式。
    /// - 两个整数之间的除法总是 向零截断 。
    /// - 表达式中不含除零运算。
    /// - 输入是一个根据逆波兰表示法表示的算术表达式。
    /// - 答案及所有中间计算结果可以用 32 位 整数表示。
    /// ```
    /// 示例 1：
    ///
    /// 输入：tokens = ["2","1","+","3","*"]
    /// 输出：9
    /// 解释：该算式转化为常见的中缀算术表达式为：((2 + 1) * 3) = 9
    /// 示例 2：
    ///
    /// 输入：tokens = ["4","13","5","/","+"]
    /// 输出：6
    /// 解释：该算式转化为常见的中缀算术表达式为：(4 + (13 / 5)) = 6
    ///```
    /// 提示：
    /// - 1 <= tokens.length <= 10**4
    /// - tokens[i] 是一个算符（"+"、"-"、"*" 或 "/"），或是在范围 [-200, 200] 内的一个整数
    ///
    /// 逆波兰表达式：
    ///
    /// 逆波兰表达式是一种后缀表达式，所谓后缀就是指算符写在后面。
    ///
    /// - 平常使用的算式则是一种中缀表达式，如 ( 1 + 2 ) * ( 3 + 4 ) 。
    /// - 该算式的逆波兰表达式写法为 ( ( 1 2 + ) ( 3 4 + ) * ) 。
    ///
    /// 逆波兰表达式主要有以下两个优点：
    ///
    /// - 去掉括号后表达式无歧义，上式即便写成 1 2 + 3 4 + * 也可以依据次序计算出正确结果。
    /// - 适合用栈操作运算：遇到数字则入栈；遇到算符则取出栈顶两个数字进行计算，并将结果压入栈中
    ///
    int evalRPN(vector<string>& tokens) {
        vector<int> nums;
        auto rpn = [&](function<int(int& a, int& b)> f) {
            int num2 = nums.back();
            nums.pop_back();
            int num1 = nums.back();
            nums.pop_back();
            nums.push_back(f(num1, num2));
        };
        
        for (auto& token: tokens) {
            if (token == "+") {
                rpn([](int a, int b){ return a + b; });
            }
            else if (token == "-") {
                rpn([](int a, int b){ return a - b; });
            }
            else if (token == "*")  {
                rpn([](int a, int b){ return a * b; });
            }
            else if (token == "/") {
                rpn([](int a, int b){ return a / b; });
            }
            else {
                nums.push_back(stoi(token));
            }
        }
        return nums[0];
    }
    
    vector<int> maxSlidingWindow(vector<int>& nums, int k) {
        vector<int> res;
        priority_queue<pair<int, int>> pq;
        for (int i = 0; i < nums.size(); i++) {
            pq.push({nums[i], i});
            while (pq.top().second < i - k) {
                pq.pop();
            }
            if (i >= k) {
                res.push_back(pq.top().second);
            }
        }
        return res;
    }
    
    ListNode* getIntersectionNode(ListNode* headA, ListNode* headB) {
//        set<ListNode*> s;
//        ListNode* tempNode = headA;
//        while (tempNode) {
//            s.insert(tempNode);
//            tempNode = tempNode->next;
//        }
//        tempNode = headB;
//        while (tempNode) {
//            if (s.count(tempNode))
//                break;;
//            tempNode = tempNode->next;
//        }
//        return tempNode;
        
        /*! 进阶：你能否设计一个时间复杂度 O(m + n) 、仅用 O(1) 内存的解决方案？ */
        if (headA == headB)
            return headA;
        
        int aLen = 0, bLen = 0;
        ListNode* tempNode;
        tempNode = headA;
        while (tempNode) {
            aLen ++;
            tempNode = tempNode->next;
        }
        tempNode = headB;
        while (tempNode) {
            bLen ++;
            tempNode = tempNode->next;
        }
        
        tempNode = aLen > bLen ? headA: headB;
        for(int i = 0; i < abs(aLen - bLen); i++)
            tempNode = tempNode->next;
        
        headA = aLen > bLen? tempNode: headA;
        headB = bLen > aLen? tempNode: headB;
        
        while (headA != headB) {
            headA = headA->next;
            headB = headB->next;
        }
        return headA;
    }
    
    
    vector<int> maximumBeauty(vector<vector<int>>& items, vector<int>& queries) {
//        sort(items.begin(), items.end());
//
//        vector<int> indexs(queries.size(), 0);
//        iota(indexs.begin(), indexs.end(), 0);
//        sort(indexs.begin(), indexs.end(), [&](int a, int b) {
//            return queries[a] < queries[b];
//        });
//
//        vector<int> res(queries.size(), 0);
//        int l = 0; int b = 0;
//        for (auto& idx: indexs) {
//            while (l < items.size() && items[l][0] <= queries[idx]) {
//                b = max(b, items[l][1]);
//                l++;
//            }
//            res[idx] = b;
//        }
        
        // Way2
        sort(items.begin(), items.end());
        int r = 0; int b = 0;
        for (int i = 1; i < items.size(); i++) {
            if (items[i-1][0] != items[i][0]) {
                r++;
            }
            items[r] = items[i];
        }
        
        vector<int> indexs(queries.size(), 0);
        iota(indexs.begin(), indexs.end(), 0);
        sort(indexs.begin(), indexs.end(), [&](int a, int b) {
            return queries[a] < queries[b];
        });
        
        vector<int> res(queries.size(), 0);
        int l = 0;
        for (int idx = 0; idx <= queries.size(); idx++) {
            while (l < items.size() && items[r][0] <= queries[indexs[idx]]) {
                b = max(b, items[r][1]);
                l++;
            }
            res[idx] = b;
        }
        
        return res;
    }
    
    vector<int> targetIndices(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        int l = search_first(nums, target, 0, (int)nums.size()-1);
        if (l < 0)
            return {};
        
//        int r = search_last(nums, target, l, (int)nums.size()-1);
        vector<int> res;
        for (int i = l; i < nums.size(); i ++) {
            if (nums[i] != target)
                break;
            res.push_back(i);
        }
        max(1, 0);
        return res;
    }
    
    int search_first(vector<int>& nums, int target, int l, int r) {
        while (l <= r) {
            int m = (l+r)/2;
            if (nums[l] < nums[r]) {
                l = m + 1;
            }
            else {
                r = m;
            }
        }
        if (nums[r] == target)
            return r;
        return -1;
    }
    
    int search_last(vector<int>& nums, int target, int l, int r) {
        while (l <= r) {
            int m = (l+r)/2;
            if (nums[m] <= target) {
                l = m;
            }
            else {
                r = m - 1;
            }
        }
        if (nums[l] == target)
            return l;
        return -1;
    }
    
   
};

#endif /* Solution2309_hpp */
