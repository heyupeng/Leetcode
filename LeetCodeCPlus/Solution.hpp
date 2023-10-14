//
//  Solution.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/7/3.
//

#ifndef Solution_hpp
#define Solution_hpp

#include <stdio.h>
#include <math.h>

#include <vector>
#include <map>
#include <stack>
#include <string>
#include <set>
#include <queue>

using namespace std;

#include "ListNode.hpp"

template<class _Tp, class _PrintFunc>
inline void print_element(vector<_Tp>& arr, _PrintFunc __f, string sepatator = " ", string terminator = "\n") {
    for (int i = 0; i < arr.size(); i++) {
        __f(arr[i]);
        if (i != arr.size()-1) {
            printf(sepatator.c_str());
        } else {
            printf(terminator.c_str());
        }
    }
};

class Solution {
public:
    /// #1.
    vector<int> twoSum(vector<int>& nums, int target) {
        map<int, int> hashmap;
        size_t size = nums.size();
        for (int i = 0; i < size; i ++) {
            auto it = hashmap.find(target - nums[i]);
            if (it != hashmap.end()) {
                return {it->second, i};
            }
            hashmap[nums[i]] = i;
        }
        return {};
    }
    
    /// #2.
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        if (l1 == nullptr) { return l2; }
        if (l2 == nullptr) { return l1; }
        
        int val = l1->val + l2->val;
        if (val > 9) {
            val -= 10;
            ListNode * temp = new ListNode(1);
            l1->next = addTwoNumbers(l1->next, temp);
        }
        l1->val = val;
        l1->next = addTwoNumbers(l1->next, l2->next);
        return l1;
    }
    
    /// #445.
    ListNode* addTwoNumbersII(ListNode* l1, ListNode* l2) {
        stack<int> s1, s2;
        while (l1) {
            s1.push(l1->val);
            l1 = l1->next;
        }
        while (l2) {
            s2.push(l2->val);
            l2 = l2->next;
        }
        ListNode * l3 = nullptr;
        int temp = 0;
        while (!s1.empty() or !s2.empty() or temp != 0) {
            int n1 = s1.empty() ? 0: s1.top();
            int n2 = s2.empty() ? 0: s2.top();
            if (!s1.empty()) { s1.pop(); }
            if (!s2.empty()) { s2.pop(); }
            
            int n = n1 + n2 + temp;
            temp = n / 10;
            l3 = new ListNode(n % 10, l3);
        }
        return l3;
    }
    
    /// #48. 矩阵90度旋转
    void rotate(vector<vector<int>>& matrix) {
        int n = (int)matrix.size();
        int col = n / 2;
        int row = (n + 1) / 2;
        for (int i = 0; i < col; i ++) {
            for (int j = 0; j < row; j ++) {
                int temp = matrix[i][j];
                matrix[i][j] = matrix[n - 1 - j][i];
                matrix[n - 1 - j][i] = matrix[n - 1 - i][n - 1 - j];
                matrix[n - 1 - i][n - 1 - j] = matrix[j][n - 1 - i];
                matrix[j][n - 1 - i] = temp;
            }
        }
    }
    
    /// #49. 同构异分体
    vector<vector<string>> groupAnagrams(vector<string> strs) {
        vector<vector<string>> res;
        map<vector<int>, int> map;
        for (int i = 0; i < strs.size(); i ++) {
            string str = strs[i];
            vector<int> v = vector<int>(26, 0);
            for (int j = 0; j < str.length(); j ++) {
                v[str[j] - 'a'] += 1;
            }
            auto it = map.find(v);
            if (it != map.end()) {
                res[it->second].push_back(str);
            } else {
                map[v] = (int)res.size();
                res.push_back({str});
            }
        }
        return res;
    }
    
    /// #56. 区间合并
    vector<vector<int>> merge(vector<vector<int>>& intervals) {
        vector<vector<int>> res;
        sort(intervals.begin(), intervals.end(), [](vector<int> v1, vector<int> v2) {
            return v1[0] < v2[0] || (v1[0] = v2[0] && v1[1] < v2[0]);
        });
        // 1.
        //        vector<int> lastInterval;
        //        for (auto & interval: intervals) {
        //            if (lastInterval.size() == 0) {
        //                lastInterval = interval;
        //                continue;
        //            }
        //            if (lastInterval[1] < interval[0]) {
        //                res.push_back(lastInterval);
        //                lastInterval = interval;
        //                continue;
        //            }
        //            if (lastInterval[1] < interval[1]) {
        //                lastInterval[1] = interval[1];
        //            }
        //        }
        //        if (lastInterval.size() != 0) {
        //            res.push_back(lastInterval);
        //        }
        
        // 2.
        function<bool(vector<int> & v1, vector<int> v2)> mergev = [](vector<int> & v1, vector<int> v2) {
            if (v1[1] < v2[0] || v2[1] < v1[0]) { return false; }
            if (v1[0] <= v2[0] && v1[1] >= v2[1]) { return true; }
            v1[0] = min(v1[0], v2[0]);
            v1[1] = max(v1[1], v2[1]);
            return  true;
        };
        
        for (auto & interval: intervals) {
            bool isMerge = false;
            if (res.size() > 0) {
                auto & in = res[res.size() - 1];
                isMerge = mergev(in, interval);
            }
            if (isMerge == false) {
                res.push_back(interval);
            }
        }
        return res;
    }
    
    vector<vector<int>> merge3(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end(), [](vector<int> v1, vector<int> v2) {
            return v1[0] < v2[0] || (v1[0] = v2[0] && v1[1] < v2[0]);
        });
        function<bool(vector<int>&, vector<int>&)> isintersect = [](vector<int>& in1, vector<int>& in2) {
            if (in1[1] < in2[0] || in2[1] < in1[0])
                return false;
            return true;
        };
        function<bool(vector<int>&, vector<int>&)> mergein = [](vector<int>& in1, vector<int>& in2) {
            in1[0] = min(in1[0], in2[0]);
            in1[1] = min(in1[1], in2[1]);
            return true;
        };
        
        vector<vector<int>> res;
        for (auto& in: intervals) {
            if (res.size() == 0 || !isintersect(res[res.size()-1], in)) {
                res.push_back(in);
            }
            else {
                mergein(res[res.size()-1], in);
            }
        }
        return res;
    }
    
    /// #2679.
    int matrixSum(vector<vector<int>>& nums) {
        //        auto maxs = vector<int>(nums[0].size(), 0);
        //        for (auto col: nums) {
        //            sort(col.begin(), col.end(), [](int n1, int n2){
        //                return n1 > n2;
        //            });
        //            for (int i = 0; i < col.size(); i++) {
        //                if (maxs[i] < col[i]) {
        //                    maxs[i] = col[i];
        //                }
        //            }
        //        }
        //        int res = 0;
        //        for (auto num: maxs) {
        //            res += num;
        //        }
        
        // way2.
        int res = 0;
        for (auto &col: nums) {
            sort(col.begin(), col.end(), [](int n1, int n2){
                return n1 > n2;
            });
        }
        long m = nums.size();
        long n = nums[0].size();
        for (int j = 0; j < n; j++) {
            int maxValue = 0;
            for (int i = 0; i < m; i++) {
                maxValue = max(maxValue, nums[i][j]);
            }
            res += maxValue;
        }
        return res;
    }
    
    /// #64.
    int minPathSum(vector<vector<int>>& grid) {
        long m = grid.size();
        long n = grid[0].size();
        auto dp = vector<int>(n + 1, 0);
        for(int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0) {
                    dp[j+1] = dp[j] + grid[i][j];
                }
                else if (j == 0) {
                    dp[j+1] = dp[j+1] + grid[i][j];
                }
                else {
                    dp[j+1] = min(dp[j], dp[j+1]) + grid[i][j];
                }
            }
        }
        return dp[n];
    }
    
    /// #75. 颜色分类
    void sortColors(vector<int>& nums) {
        auto sums = vector<int>(3, 0);
        for(auto &num: nums) {
            sums[num] += 1;
        }
        int s = 0;
        for (auto &sum: sums) {
            sum += s;
            s = sum;
        }
        for (int i = 0; i < nums.size(); i++) {
            if (i < sums[0]) {
                nums[i] = 0;
            }
            else if (i < sums[1]) {
                nums[i] = 1;
            }
            else {
                nums[i] = 2;
            }
        }
    }
    
    /// #96. 不同的二叉搜索树
    int numTrees(int n) {
        /**
         * s0 = 1
         * s1 = 1
         * s2 = s0 * s1 + s1 * s0 = 1 + 1
         * s3 = s0 * s2 + s1 * s1 +  s2 * s0
         * s4 = s0 * s3 + s1 * s2 + s2 * s1 + s3 * s0
         * s5 = s0 * s4 + s1 * s3 + s2 * s2 + s3 * s1 + s4 * s0
         * sn =  ∑ si * s(n-1-i)    (0 ≤ i < n)
         */
        vector<int> dp = vector<int>(n+1, 0);
        dp[0] = 1;
        dp[1] = 1;
        
        for (int i = 2; i <= n; i ++) {
            int res = 0;
            for (int j = 0; j < i; j ++) {
                res += dp[j] * dp[i-j-1];
            }
            dp[i] = res;
        }
        return dp[n];
    }
    
    /// #96. 验证二叉搜索树
    bool isValidBST(TreeNode * root) {
        return _isValidBST(root, nullptr, nullptr);
    }
    
    bool _isValidBST(TreeNode * root, TreeNode * base1, TreeNode * base2) {
        if (root == nullptr) { return  true;}
        
        if (base1 != nullptr && root->val <= base1->val) {
            return false;
        }
        if (base2 != nullptr && root->val >= base2->val) {
            return false;
        }
        
        if (!_isValidBST(root->left, base1, root) || !_isValidBST(root->right, root, base2)) {
            return false;
        }
        return true;
    }
    
    /// #105. 从前序与中序遍历序列构造二叉树
    TreeNode * buildTree(vector<int>& preorder, vector<int>& inorder) {
        TreeNode * node = _buildTree(preorder, inorder, 0, 0, (int)inorder.size());
        return node;
    }
    
    TreeNode * _buildTree(vector<int>& preorder, vector<int>& inorder, int prestart, int instart, int inend) {
        if (preorder.size() <= prestart) {
            return nullptr;
        }
        if (inorder.size() <= instart || inend <= instart) {
            return nullptr;
        }
        TreeNode * node = nullptr;
        
        for (int i = instart; i < inend; i ++) {
            if (inorder[i] == preorder[prestart]) {
                prestart += 1;
                TreeNode * left = _buildTree(preorder, inorder, prestart, instart, i);
                if (left == nullptr && instart < i-1) {
                    prestart -= 1;
                    continue;
                }
                TreeNode * right = _buildTree(preorder, inorder, prestart + i-instart, i+1, inend);
                if (right == nullptr && i+1 < inend) {
                    prestart -= 1;
                    continue;
                }
                node = new TreeNode(inorder[i]);
                node->left = left;
                node->right = right;
                break;
            }
        }
        return node;
    }
    
    /// #2600. K 件物品的最大和
    int kItemsWithMaximumSum(int numOnes, int numZeros, int numNegOnes, int k) {
        return k;
    }
    
    /// #114. 二叉树展开为链表
    void flatten(TreeNode * root) {
        if (root == nullptr) { return;}
        stack<TreeNode *> stk;
        stk.push(root);
        
        TreeNode * pre = new TreeNode();
        while (stk.size() != 0) {
            auto temp = stk.top();
            stk.pop();
            if (temp->right != nullptr) {
                stk.push(temp->right);
            }
            if (temp->left != nullptr) {
                stk.push(temp->left);
                temp->left = nullptr;
            }
            pre->right = temp;
            pre = temp;
        }
    }
    
    //
    bool hasCycle(ListNode *head) {
        // 1.
        //        map<ListNode *, int> mp;
        //        while(head != nullptr) {
        //            auto it = mp.find(head);
        //            if (it != mp.end()) {
        //                // printf("(%d, %d), ", it->first, it->second);
        //                return true;
        //            }
        //            mp[head] = head->val;
        //            head = head->next;
        //        }
        // 2.
        if (head == nullptr) { return false;}
        ListNode * n1 = head;
        ListNode * n2 = head->next;
        while(n1 != nullptr && n2 != nullptr) {
            if (n1 == n2) {
                return true;
            }
            n1 = n1->next;
            n2 = n2->next;
            if (n2) { n2 = n2->next; };
        }
        return false;
    }
    
    ListNode * detectCycle(ListNode *head) {
        // 1.
        //        map<ListNode *, int> mp;
        //        while(head != nullptr) {
        //            auto it = mp.find(head);
        //            if (it != mp.end()) {
        //                // printf("(%d, %d), ", it->first, it->second);
        //                return true;
        //            }
        //            mp[head] = head->val;
        //            head = head->next;
        //        }
        // 2.
        if (head == nullptr) { return nullptr;}
        
        ListNode * n1 = head;
        ListNode * n2 = head->next;
        while(n1 != nullptr && n2 != nullptr) {
            if (n1 == n2) { // 存在环形结构。
                break;
            }
            n1 = n1->next;
            n2 = n2->next;
            if (n2) { n2 = n2->next; };
        }
        if (n1 == n2) {
            ListNode * n = head;
            while (n != n1) {
                n2 = n1->next;
                while (n2 != n1 && n != n2) {
                    n2 = n2->next;
                }
                if (n == n2) {
                    break;
                }
                n = n->next;
            }
            return n;
            
        }
        return nullptr;
    }
    
    // #2178. 拆分成最多数目的正偶数之和
    vector<int> t2178(int finalSum) {
        /**
         * 2:  0
         * 4:  0
         * 6:  2, 4
         * 8:  2, 6
         * 10:  4, 6
         * 14:  6, 8 => 2, 4, 8
         * 16: 8, 8 =>  2, 6, 8
         * 24: 12, 12 =>  6, 6, 12 => 2, 4, 6, 12 => 4, 8, 2, 10
         * 28: 14, 14 => 2, 4, 8, 14
         * 32: 16, 16 => 6, 4, 12, 2, 8
         * 48: 24, 24 => 2, 4, 6, 8, 10, 18
         */
        if (finalSum %2 == 1 || finalSum <= 4) { return {};}
        
        int n = finalSum;
        int step = 2;
        vector<int> v = {};
        while (n >= step) {
            int temp = n - step;
            if (step < temp) {
                v.push_back(step);
            } else {
                v.push_back(step + temp);
            }
            n = temp;
            step += 2;
        }
        return v;
    }
    
    int longestConsecutive(vector<int> nums) {
        auto s = set<int>();
        for(auto num: nums) {
            s.emplace(num);
        }
        
        int longest = 0;
        int count = 0;
        int pre = 0;
        for(auto n: s) {
            if (count != 0 || pre == n - 1) {
                count += 1;
            } else {
                count = 1;
            }
            longest = max(longest, count);
            pre = n;
        }
        return longest;
    }
    
    /// #152. 乘积最大子数组
    int maxProduct(vector<int>& nums) {
        int maxVal = INT32_MIN;
        // 寻零
        vector<int> zeroVector = {};
        for (int i = 0; i < nums.size(); i++) {
            if (nums[i] != 0) { continue; }
            zeroVector.push_back(i);
            maxVal = 0;
        }
        zeroVector.push_back((int)nums.size());
        // 分段
        int begin = 0;
        for (auto &zeroIdx: zeroVector) {
            maxVal = max(maxVal, _maxProduct(nums, begin, zeroIdx));
            begin = zeroIdx + 1;
        }
        return maxVal;
    }
    
    int _maxProduct(vector<int>& nums, int begin, int end) {
        if (end - begin <= 1) { return nums[begin]; }
        
        vector<int> pro;
        pro.push_back(nums[begin]);
        for (int i = 1; i < end - begin; i++) {
            int p = nums[begin + i] * pro[i-1];
            pro.push_back(p);
        }
        
        int maxVal = nums[begin];
        int maxUpperIdx = -1;
        for (int i = 0; i < pro.size(); i++) {
            maxVal = max(maxVal, pro[i]);
            if (pro[i] == 1) {
                continue; // 枝剪。
            }
            for(int j = i; j < pro.size(); j++) {
                if (maxVal < pro[j]) {
                    maxVal = pro[j];
                    maxUpperIdx = j;
                }
                pro[j] /= nums[begin+i];
            }
            if (maxUpperIdx == pro.size() - 1) {
                // 枝剪：此时子集抵达最右端。
                break;
            }
        }
        return maxVal;
    }
    
    /// #931. 下降路径最小和 --23/07/13
    int minFallingPathSum(vector<vector<int>> matrix) {
        int m = (int)matrix.size();
        int n = (int)matrix[0].size();
        vector<int> dp[2] = {vector<int>(n, 0), vector<int>(n, 0)};
        
        int flag = 0;
        for (int i = 0; i < m; i++) {
            flag = 1 - flag;
            for (int j = 0; j < n; j++) {
                // min(dp[j], dp[j+1], dp[j+2]) + matrix[i][j]
                int minVal = dp[1-flag][j];
                if (j > 0)      { minVal = min(minVal, dp[1-flag][j-1]); }
                if (j < n - 1)  { minVal = min(minVal, dp[1-flag][j+1]); }
                dp[flag][j] = minVal + matrix[i][j];
            }
        }
        int minSum = INT32_MAX;
        for (int i = 0; i < n; i++) {
            minSum = min(minSum, dp[flag][i]);
        }
        return minSum;
    }
    
    bool isPalindrome(string s) {
        string ss = "";
        for (auto ch: s) {
            if (ch >= 'a' && ch <= 'z') {
                ss.push_back(ch);
            }
            else if (ch >= 'A' && ch <= 'Z') {
                ss.push_back(ch - ('A' - 'a'));
            }
            else if (ch >= '0' && ch <= '9') {
                ss.push_back(ch);
            }
        }
        printf("%s\n", ss.data());
        long len = ss.size();
        for(int i = 0; i < len/2; i++) {
            if (ss[i] != ss[len-1-i]) {
                return false;
            }
        }
        string ss_rev(ss.rbegin(), ss.rend());
        return ss == ss_rev;
        
        int n = ss.size();
        int left = 0, right = n - 1;
        while (left < right) {
            if (ss[left] != ss[right]) {
                return false;
            }
            ++left;
            --right;
        }
        
        return true;
    }
    
    bool isPalindrome(ListNode *head) {
        ListNode * rev = reverse_ListNode(head);
        while (head != nullptr) {
            if (head->val != rev->val) {
                return false;
            }
            head = head->next;
            rev = rev->next;
        }
        return true;
    }
    
    ListNode * reverse_ListNode(ListNode * head) {
        ListNode * n = nullptr;
        while (head != nullptr) {
            ListNode * next = head->next;
            head->next = n;
            n = head;
            head = next;
        }
        return n;
    }
    
    /// #979. 在二叉树中分配硬币 -- 23/07/14
    int distributeCoins(TreeNode * root) {
        auto res = _distributeCoins_map(root);
        return res[1];
    }
    
    vector<int> _distributeCoins_map(TreeNode * root) {
        if (!root) { return {0, 0}; }
        
        vector<int> res1 = _distributeCoins_map(root->left);
        vector<int> res2 = _distributeCoins_map(root->right);
        res1 = {res1[0] + res2[0], res1[1] +res2[1]};
        res1[0] += (root->val - 1);
        res1[1] += abs(res1[0]);
        // printf("(%d,%d)", res[0], res[1]);
        return res1;
    }
    
    /// #18. 四数和-- 23/07/15
    vector<vector<int>> fourSum(vector<int> & nums, int target) {
        vector<vector<int>> res;
        sort(nums.begin(), nums.end());
        auto n = (int)nums.size();
        
        if (target < 0 && nums[0] >= 0) { return res; }
        if (target > 0 && nums[n-1] <= 0) { return res; }
        
        for (int a = 0; a < n - 3; a++) {
            if (nums[a] == nums[a-1] && a != 0) { continue; }
            if (target >= 0 && nums[a] > target) { break; }
            
            for (int d = n - 1; d >= a + 3; d--) {
                if (nums[d] == nums[d+1] && d != n -1) { continue; }
                
                int val = nums[a] + nums[d];
                // 左右边界
                int ll = a + 1, rr = d - 1;
                
                // 枝剪：`target - val > maxium`
                if ((long)target - val > nums[rr] + nums[rr-1]) { break; }
                
                for (int b = ll; b < rr; b++) {
                    if (nums[b] == nums[b-1] && b != ll) { continue; }
                    
                    int rest = target - val - nums[b];
                    
                    // [a,b,c,d] 定位 c。
                    int cl = b + 1, cr = rr;
                    while (cl <= cr) {
                        int mid = (cl + cr) / 2;
                        if (rest == nums[mid]) {
                            res.push_back({nums[a], nums[b], nums[mid], nums[d]});
                            break;
                        }
                        if (rest < nums[mid]) {
                            cr = mid - 1;
                        }
                        else {
                            cl = mid + 1;
                        }
                    }
                }
            }
        }
        return res;
    }
    
    /// #16. 三数和 --
    int threeSum(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        auto len = (int)nums.size();
        int nearest = target;
        int minDistance = INT32_MAX;
        
        for (int i = 0; i < len - 2; i++) {
            int sum = nums[i] + nums[i+1] + nums[i+2];
            if (sum >= target) {
                if (sum - target < minDistance) {
                    nearest = sum;
                    minDistance = abs(sum - target);
                }
                break;
            }
            int l = i + 1, r = len - 1;
            while (l < r) {
                sum = nums[i] + nums[l] + nums[r];
                if (abs(target - sum) < minDistance) {
                    nearest = sum;
                    minDistance = abs(target - sum);
                }
                if (sum == target) {
                    return nearest;
                }
                if (sum < target) {
                    l++;
                }
                else {
                    r--;
                }
            }
        }
        return nearest;
    }
    
    /// #30. 串联所有单词的子串
    vector<int> findSubstring(string s, vector<string>& words) {
        vector<int> res = {};
        int len = (int)s.size();
        int wordCount = (int)words.size();
        int wordLen = (int)words[0].size(); // words[i].size() 一致
        
        map<string, vector<size_t>> wordIdx_mp = {};
        map<string, int> wordcount_mp;
        for (auto word: words) {
            wordcount_mp[word] += 1;
            
            if (wordcount_mp[word] > 1) { continue; }
            
            vector<size_t> wordIdx_vec;
            size_t pos = 0;
            while (pos >= 0 && pos < len) {
                pos = s.find(word, pos);
                if (pos == -1) { break;}
                wordIdx_vec.push_back(pos);
                printf("%zi,", pos);
                pos += 1;
            }
            wordIdx_mp[word] = wordIdx_vec;
            printf("\n");
        }
        
        for (int i = 0; i < len - wordCount * wordLen; i++) {
            
        }
        
        return res;
    }
    
    /// #148. 排序链表
    /// 给你链表的头结点 head ，请将其按 升序 排列并返回 排序后的链表 。
    ListNode * sortList(ListNode * head) {
        // way 1. 数组排序，再重组。
        vector<ListNode *> list;
        while (head != nullptr) {
            list.push_back(head);
            head = head->next;
        }
        
        sort(list.begin(), list.end(), [](ListNode *n1, ListNode *n2){
            return n1->val <= n2->val;
        });
        
        head = nullptr;
        for (int i = (int)list.size()-1; i >= 0; i--) {
            list[i]->next = head;
            head = list[i];
        }
        return head;
    }
    
    vector<int> sumOfDistancesInTree(int n, vector<vector<int>> & edges) {
        return sumOfDistancesInTree_1(n, edges);
    }
    vector<int> sumOfDistancesInTree_1(int n, vector<vector<int>> & edges) {
        vector<int> res = vector(n, 0);
        if (edges.size() == 0) { return res;}
        
        vector<vector<int>> mat = vector(n, vector(n,0));
        int totaldistance = n * n - n;
        int count = 0;
        
        function<void(int i, int j, int dist)> updateDist = [&](int i, int j, int dist) {
            res[i] += dist;
            res[j] += dist;
            count += 2;
        };
        
        int dist = 1;
        map<vector<int>, int> mp;
        for (auto edge: edges) {
            mat[edge[0]][edge[1]] = 1;
            mat[edge[1]][edge[0]] = 1;
            mp[edge] = 1;
            
            updateDist(edge[0], edge[1], 1);
        }
        
        vector<vector<int>> matn = mat;
        while (count < totaldistance) {
            dist ++;
            //            _matrix_mul(matn, mat, dist, updateDist);
            _matrix_mul2(matn, dist, updateDist);
        }
        return res;
    }
    
    void _matrix_mul(vector<vector<int>> &m1, vector<vector<int>> &m2, int dist, function<void(int i, int j, int dist)> & updateDist) {
        //
        auto m1_m = m1.size();
        auto m1_n = m1[0].size();
        auto m2_m = m2.size();
        auto m2_n = m2[0].size();
        if (m1_n != m2_m) { return ; }
        
        for (int i = 0; i < m1_m; i++) {
            vector<int> temp = m1[i];
            for (int j = i + 1; j < m2_n; j++) {
                if (temp[j] != 0) {
                    continue;;
                }
                int val = 0;
                for (int k = 0; k < m1_n; k++) {
                    val += temp[k] * m2[k][j];
                }
                
                if (val == 0) { continue; }
                m1[i][j] = dist;
                
                updateDist(i, j, dist);
            }
        }
        
        // 填充对角线
        for (int i = 0; i < m1_m; i++) {
            for (int j = i + 1; j < m2_n; j++) {
                m1[j][i] = m1[i][j];
            }
        }
    }
    
    void _matrix_mul2(vector<vector<int>> &m1, int dist, function<void(int i, int j, int dist)> & updateDist) {
        //
        auto m1_m = m1.size();
        auto m1_n = m1[0].size();
        
        for (int i = 0; i < m1_m; i++) {
            vector<int> temp = m1[i];
            for (int j = i + 1; j < m1_n; j++) {
                if (temp[j] != 0) {
                    continue;;
                }
                int val = 0;
                for (int k = 0; k < m1_n; k++) {
                    int d = m1[k][j];
                    //                    val += temp[k] * m2[k][j];
                    val += temp[k] * (d == 1 ? : 0);
                }
                
                if (val == 0) { continue; }
                m1[i][j] = dist;
                
                updateDist(i, j, dist);
            }
        }
        
        // 填充对角线
        for (int i = 0; i < m1_m; i++) {
            for (int j = i + 1; j < m1_n; j++) {
                m1[j][i] = m1[i][j];
            }
        }
    }
    
    vector<int> sumOfDistancesInTree_dfs(int n, vector<vector<int>> & edges) {
        vector<int> res = vector(n, 0);
        if (edges.size() == 0) { return res;}
        
        vector<vector<int>> mat = vector(n, vector(n,0));
        int maxdistance = n * 2 - 1;
        
        for (auto edge: edges) {
            mat[edge[0]][edge[1]] = 1;
            mat[edge[1]][edge[0]] = 1;
        }
        
        vector<vector<int>> flag = vector(n,vector(n, 0));
        int totaldistance = n * n - n;
        
        function<void(int a, int b, int dist)> dfs = [&](int a, int b, int dist) {
            for(int i = a; i < n; i++) {
                
            }
        };
        
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                res[i] += flag[i][j];
                res[j] += flag[i][j];
            }
        }
        
        return res;
    }
    
    vector<int> sumOfDistancesInTree_bfs(int n, vector<vector<int>> & edges) {
        vector<int> res = vector(n, 0);
        if (edges.size() == 0) { return res;}
        
        vector<vector<int>> mat = vector(n, vector(n,0));
        vector<vector<int>> flag = vector(n,vector(n, 0));
        int maxdistance = n * 2 - 1;
        
        vector<vector<int>> dirs = {{-1, 0}, {0, -1}, {1, 0}, {0, 1}};
        
        function<bool(int & __i, int & __j)> availEdge = [&](int & __i, int & __j) {
            if (__i < 0 || __i > n - 1 || __j < 0 || __j > n - 1) { return false; }
            return true;
        };
        
        function<void(vector<int> & edge, vector<vector<int>> & nextEdges, int dist)> addNextEdges = [&](vector<int> & edge, vector<vector<int>> & nextEdges, int dist) {
            if (flag[edge[0]][edge[1]] != 0 && flag[edge[0]][edge[1]] <= dist) {
                return;
            }
            flag[edge[0]][edge[1]] = dist;
            flag[edge[1]][edge[0]] = dist;
            
            for (auto dir: dirs) {
                int i1 = dir[0] + edge[0], j1 = dir[1] + edge[1];
                if (!availEdge(i1, j1)) {
                    continue;
                }
                if (i1 == j1) {
                    continue;
                }
                if (flag[i1][j1] != 0 && flag[i1][j1] < dist) { continue; }
                
                nextEdges.push_back({i1, j1});
            }
            
        };
        int dist = 0;
        while (edges.size() > 0) {
            dist += 1;
            vector<vector<int>> nextedges = {};
            
            for (auto edge: edges) {
                addNextEdges(edge, nextedges, dist);
            }
            edges = nextedges;
        }
        
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                res[i] += flag[i][j];
                res[j] += flag[i][j];
            }
        }
        
        return res;
    }
    
    /// #67.
    string addBinary(string a, string b) {
        int idx1 = (int)a.size() - 1;
        int idx2 = (int)b.size() - 1;
        char remander = 0;
        string res = "";
        return res;
        while (idx1 >= 0 && idx2 >= 0) {
            int sum = 0;
            sum += a[idx1] - '0';
            sum += b[idx2] - '0';
            sum += remander;
            
            res.push_back('0' + sum % 2);
            remander = sum / 2;
            
            idx1 --; idx2 --;
        }
        
        while (idx1 >= 0) {
            int sum = a[idx1] - '0';
            sum += remander;
            
            res.push_back('0' + sum % 2);
            remander = sum / 2;
            idx1 --;
        }
        
        while (idx2 >= 0) {
            int sum = b[idx2] - '0';
            sum += remander;
            
            res.push_back('0' + sum % 2);
            remander = sum / 2;
            idx2 --;
        }
        
        if (remander != 0) {
            res.push_back('1');
        }
        reverse(res.begin(), res.end());
        return res;
    }
    
    /// #69. x 的平方根
    int mySqrt(unsigned int x) {
        int l = 1, r = (1 << 16) - 1;
        int res = 0;
        
        while (l <= r) {
            int mid = (l + r) / 2;
            long mul = (long)mid * mid;
            if (mul == x) {
                res = mid;
                break;
            }
            if (mul > x) {
                r = mid - 1;
            }
            else {
                res = mid;
                l = mid + 1;
            }
        }
        return res;
    }
    
    /// #415. 字符串相加 -- 23/07/17
    string addString(string num1, string num2) {
        int idx1 = (int)num1.size() - 1;
        int idx2 = (int)num2.size() - 1;
        int q = 0;
        string res;
        
        while (idx1 >= 0 || idx2 >= 0) {
            int sum = q;
            if (idx1 >= 0) sum += num1[idx1] - '0';
            if (idx2 >= 0) sum += num2[idx2] - '0';
            q = sum / 10;
            res.push_back('0' + sum%10);
            
            idx1 --; idx2 --;
        }
        
        if (q != 0) res.push_back('0' + q);
        reverse(res.begin(), res.end());
        return res;
    }
    
    /// #221. 最大正方形
    ///
    /// 在一个由 '0' 和 '1' 组成的二维矩阵内，找到只包含 '1' 的最大正方形，并返回其面积。
    int maxSquare(vector<vector<char>> & matrix) {
        int maxium = '0';
        int m = (int)matrix.size(), n = (int)matrix[0].size();
        vector<vector<int>> mat = vector(m,vector(n,0));
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] == '0') {
                    continue;
                }
                int sq = '1';
                if (i > 0 && j > 0 && matrix[i-1][j-1] != '0') {
                    int sq1 = min(mat[i-1][j] , mat[i][j-1]);
                    sq1 = min(mat[i-1][j-1], sq1);
                    if (sq1 != 0) {
                        sq1 += 1;
                        sq = sq1;
                    }
                }
                mat[i][j] = sq;
                maxium = max(maxium, (int)sq);
            }
        }
        maxium = maxium - '0';
        return maxium * maxium;
    }
    
    /// #1851
    vector<int> minInterval(vector<vector<int>> & intervals, vector<int> & queries) {
        return minInterval_3(intervals, queries);
    }
    vector<int> minInterval_1(vector<vector<int>> & intervals, vector<int> queries) {
        sort(intervals.begin(), intervals.end(), [](vector<int> &in1, vector<int> &in2){
            return in1[0] < in2[0] || (in1[0] == in2[0] && in1[1] < in2[1]);
        });
        vector<int> qq = queries;
        sort(qq.begin(), qq.end());
        map<int, int> mp;
        
        int left = 0;
        for (int i = 0; i < qq.size(); i++) {
            if (i > 0 && qq[i] == qq[i-1]) {
                continue;
            }
            int mindist = -1;
            for (int j = left; j < intervals.size(); j++) {
                if (qq[i] < intervals[j][0]) {
                    break;
                }
                if (qq[i] <= intervals[j][1]) {
                    int dist = intervals[j][1] - intervals[j][0] + 1;
                    if (mindist == -1) { mindist = dist; }
                    else { mindist = min(mindist, dist); }
                    
                    if (dist == 1) { break; }
                }
            }
            mp[qq[i]] = mindist;
        }
        
        for (int i = 0; i < qq.size(); i++) {
            qq[i] = mp[queries[i]];
        }
        
        return qq;
    }
    
    // 去重
    int removeRepeat(vector<vector<int>> & intervals, function<bool(vector<int>& int1, vector<int>& int2)> isSame) {
        int repeat = 0;
        int intervalsCount = (int)intervals.size();
        for (int i = 1, idx = 1; i < intervalsCount; i++) {
            if (intervals[i] == intervals[i-1]) {
                repeat += 1;
                continue;
            }
            if (idx != i) intervals[idx] = intervals[i];
            idx ++;
        }
        return repeat;
    }
    
    void treeSearch1(const function<void (TreeNode *, TreeNode *)> &addNode, vector<vector<int>> &intervals, int intervalsCount, vector<int>& queries, map<int, int>& mp) {
        TreeNode * head = new TreeNode(0);
        for (int i = 1; i < intervalsCount; i++) {
            TreeNode * node = new TreeNode(i);
            addNode(head, node);
        }
        
        function<int(TreeNode * root, int &val)> findMinInterval = [&](TreeNode * root, int &val) {
            if (!root) { return -1; }
            if (val < intervals[root->val][0]) { return -1; }
            
            int dist = findMinInterval(root->right, val);;
            
            if (intervals[root->val][0] <= val && val <= intervals[root->val][1]) {
                int temp = findMinInterval(root->left, val);
                if (temp == -1) {
                    temp = intervals[root->val][1] - intervals[root->val][0] + 1;
                }
                if (dist == -1) {
                    dist = temp;
                } else {
                    dist = min(dist, temp);
                }
            }
            return dist;
        };
        
        vector<int> qq = queries;
        sort(qq.begin(), qq.end());
        
        for (int i = 0; i < qq.size(); i++) {
            if (i > 0 && qq[i] == qq[i-1]) {
                continue;
            }
            mp[qq[i]] = (findMinInterval(head, qq[i]));
        }
    }
    
    vector<int> minInterval_2(vector<vector<int>> & intervals, vector<int> & queries) {
        sort(intervals.begin(), intervals.end(), [](vector<int> &in1, vector<int> &in2){
            return in1[0] < in2[0] || (in1[0] == in2[0] && in1[1] < in2[1]);
        });
        
        int intervalsCount = (int)intervals.size();
        intervalsCount -= removeRepeat(intervals, [](vector<int>& interval1, vector<int>& interval2) {
            return interval1 == interval2;
        });
        intervals.resize(intervalsCount);
        
        //
        function<bool(int a, int b)> intervalAContainB = [&intervals](int a, int b) {
            if (intervals[a][0] <= intervals[b][0] && intervals[b][1] <= intervals[a][1])
                return true;
            return false;
        };
        function<int(vector<int>& interval, int& val)> intervalContainValue = [](vector<int>& interval, int &val) {
            if (interval[0] <= val && val <= interval[1])
                return true;
            return false;
        };
        function<int(vector<int>& interval)> intervalDistance = [](vector<int>& interval) {
            return interval[1] - interval[0] + 1;
        };
        
        function<void(TreeNode * root, TreeNode * node)> addTreeNode = [&](TreeNode * root, TreeNode * node) {
            if (intervalAContainB(root->val, node->val)) {
                if (root->left) { addTreeNode(root->left, node); }
                else { root->left = node; }
            } else {
                if (root->right) { addTreeNode(root->right, node); }
                else { root->right = node; }
            }
        };
        
        // 搜索二叉树
        TreeNode * head = new TreeNode(0);
        vector<TreeNode *> node_vec;
        node_vec.push_back(head);
        for (int i = 1; i < intervalsCount; i++) {
            TreeNode * node = new TreeNode(i);
            if (intervalAContainB(head->val, i)) {
                addTreeNode(head, node);
            }
            else {
                node_vec.push_back(node);
                head = node;
            }
        }
        
        function<int(TreeNode *& root, int &val)> findMinInterval = [&](TreeNode *& root, int &val) {
            if (!root) { return -1; }
            if (val < intervals[root->val][0]) { return -1; }
            
            int dist = findMinInterval(root->right, val);;
            
            if (intervals[root->val][0] <= val && val <= intervals[root->val][1]) {
                int temp = findMinInterval(root->left, val);
                if (temp == -1) {
                    temp = intervals[root->val][1] - intervals[root->val][0] + 1;
                }
                if (dist == -1) {
                    dist = temp;
                } else {
                    dist = min(dist, temp);
                }
            }
            else if (val > intervals[root->val][1]) {
                root = root->right;
            }
            return dist;
        };
        
        vector<int> qq = queries;
        sort(qq.begin(), qq.end());
        map<int, int> mp;
        
        int left = 0, right = (int)node_vec.size() - 1;
        for (int i = 0; i < qq.size(); i++) {
            if (i > 0 && qq[i] == qq[i - 1])
                continue;
            int& val = qq[i];
            int ll = left, rr = right;
            // 最远边界
            int r3 = rr;
            while (ll <= rr) {
                int mid = ll * 0.75 + rr * 0.25;
                auto& in = intervals[node_vec[mid]->val];
                if (intervalContainValue(in, qq[i])) {
                    ll = mid + 1;
                    r3 = mid;
                } else if (in[1] < qq[i]) {
                    ll = mid + 1;
                } else {
                    rr = mid - 1;
                }
            }
            
            // #33. 16 ms.
            int dist = -1;
            for (int i = left; i < node_vec.size(); i++) {
                auto& in = node_vec[i];
                if (val < intervals[in->val][0])
                    break;
                else if (val > intervals[in->val][1])
                    left ++;
                
                //                else if (intervals[in->val][0] <= val && val <= intervals[in->val][1]) {
                int temp = findMinInterval(in, val);
                if (temp != -1) {
                    if (dist == -1) dist = temp;
                    dist = min(dist, temp);
                }
                //                }
            }
            mp[val] = dist;
            
            // #33. 28 ms.
            //            stack<pair<int, int>> stk;
            //            stk.push({left, r3});
            //            while (stk.size()) {
            //                auto range = stk.top();
            //                stk.pop();
            //                int cur = (range.first + range.second) * 0.5;
            //                auto& in = intervals[node_vec[cur]->val];
            //                if ( intervalContainValue(in, qq[i]) ) {
            //                    int dist = findMinInterval(node_vec[cur], qq[i]);
            //                    if (mp.count(qq[i]) > 0)
            //                        dist = min( mp[qq[i]], dist );
            //                    mp[qq[i]] = dist;
            //                }
            //                if (range.first <= cur - 1 && intervals[node_vec[cur]->val][1] >= qq[i])
            //                    stk.push({range.first, cur - 1});
            //
            //                if (range.second >= cur + 1 && intervals[node_vec[cur]->val][0] <= qq[i])
            //                    stk.push({cur + 1, range.second});
            //            }
        }
        
        vector<int> res;
        for (int i = 0; i < queries.size(); i++) {
            res.push_back(mp[queries[i]] ? : -1);
        }
        return res;
    }
    
    struct IntervalNode {
        int val;
        vector<IntervalNode *> subnodes;
        IntervalNode *left;
        IntervalNode *right;
        IntervalNode() : val(0), left(nullptr), right(nullptr) {}
        IntervalNode(int x) : val(x), left(nullptr), right(nullptr) {}
        IntervalNode(int x, IntervalNode *left, IntervalNode *right) : val(x), left(left), right(right) {}
        
        int begin = 0;
        void addSubnode(IntervalNode * node, function<bool(int a, int b)>& intervalAContainB, function<int(int)>& getIntervalDistance) {
            if (subnodes.size() == 0) {
                subnodes.push_back(node);
                return;
            }
            IntervalNode * last = nullptr;
            
            for (int i = (int)subnodes.size()-1; i >= 0; i--) {
                auto subnode = subnodes[i];
                if (!intervalAContainB(subnode->val, node->val))
                    break;
                if (last == nullptr || getIntervalDistance(subnode->val) <= getIntervalDistance(last->val)) {
                    last = subnode;
                }
            }
            if (last) {
                last->addSubnode(node, intervalAContainB, getIntervalDistance);
            } else {
                subnodes.push_back(node);
            }
        }
    };
    
    vector<int> minInterval_3(vector<vector<int>> & intervals, vector<int> & queries) {
        sort(intervals.begin(), intervals.end(), [](vector<int> &in1, vector<int> &in2){
            return in1[0] < in2[0] || (in1[0] == in2[0] && in1[1] > in2[1]);
        });
        
        int intervalsCount = (int)intervals.size();
        intervalsCount -= removeRepeat(intervals, [](vector<int>& interval1, vector<int>& interval2) {
            return interval1 == interval2;
        });
        intervals.resize(intervalsCount);
        
        //
        function<bool(int a, int b)> intervalAContainB = [&intervals](int a, int b) {
            if (intervals[a][0] <= intervals[b][0] && intervals[b][1] <= intervals[a][1])
                return true;
            return false;
        };
        function<int(int)> getIntervalDistance = [&intervals](int idx) {
            return intervals[idx][1] - intervals[idx][0] + 1;
        };
        function<int(vector<int>& interval, int& val)> intervalContainValue = [](vector<int>& interval, int &val) {
            if (interval[0] <= val && val <= interval[1])
                return true;
            return false;
        };
        
        IntervalNode * root = new IntervalNode(-1);
        for (int i = 0; i < intervalsCount; i++) {
            IntervalNode * node = new IntervalNode(i);
            root->addSubnode(node, intervalAContainB, getIntervalDistance);
        }
        
        function<int(IntervalNode * root, int &val, int& left)> IntervalNodeFindValue = [&](IntervalNode * root, int& val, int& left) {
            if (!root) { return -1; }
            if (root->val >= 0 && val < intervals[root->val][0]) { return -1; }
            
            int n = (int)root->subnodes.size();
            int dist = -1;
            if (root->val >= 0) {
                dist = intervals[root->val][1] - intervals[root->val][0] + 1;
            }
            
            IntervalNode * minDistNode = nullptr;
            for (int i = root->begin; i < n; i++) {
                auto in = root->subnodes[i];
                
                if (intervals[in->val][1] < val) {
                    root->begin += 1;
                    continue;
                }
                else if (val < intervals[in->val][0]) {
                    break;
                }
                if (minDistNode == nullptr || getIntervalDistance(in->val) < getIntervalDistance(minDistNode->val)) {
                    minDistNode = in;
                }
            }
            
            if (minDistNode) {
                int temp = IntervalNodeFindValue(minDistNode, val, left);
                if (temp != -1) {
                    if (dist == -1) dist = temp;
                    dist = min(dist, temp);
                }
            }
            return dist;
        };
        
        vector<int> qq = queries;
        sort(qq.begin(), qq.end());
        map<int, int> mp;
        
        int left = 0;
        for (int i = 0; i < qq.size(); i++) {
            if (i > 0 && qq[i] == qq[i - 1])
                continue;
            
            int& val = qq[i];
            // 1. #33. 340 ms.
            //            mp[qq[i]] = IntervalNodeFindValue(root, val, left);
            
            // 2. #33. 240 ms.
            int dist = -1;
            for (int i = left; i < root->subnodes.size(); i++) {
                auto in = root->subnodes[i];
                if (intervals[in->val][0] <= val && val <= intervals[in->val][1]) {
                    int temp = IntervalNodeFindValue(in, val, left);
                    if (temp != -1) {
                        if (dist == -1) dist = temp;
                        dist = min(dist, temp);
                    }
                }
                else if (intervals[in->val][1] < val) {
                    left ++;
                } else {
                    break;
                }
            }
            mp[qq[i]] = dist;
            //
        }
        
        vector<int> res;
        for (int i = 0; i < queries.size(); i++) {
            res.push_back(mp[queries[i]] ? : -1);
        }
        
        // Todo
        return res;
    }
    
    /// #874. 模拟行走机器人 -- 23/07/19
    ///
    /// 机器人在一个无限大小的 XY 网格平面上行走，从点 (0, 0) 处开始出发，面向北方。该机器人可以接收以下三种类型的命令 commands ：
    ///
    /// - `-2` ：向左转 90 度
    /// - `-1` ：向右转 90 度
    /// - `1 <= x <= 9` ：向前移动 x 个单位长度
    ///
    /// 在网格上有一些格子被视为障碍物 obstacles 。第 i 个障碍物位于网格点  obstacles[i] = (xi, yi) 。
    ///
    /// 机器人无法走到障碍物上，它将会停留在障碍物的前一个网格方块上，但仍然可以继续尝试进行该路线的其余部分。
    ///
    /// 返回从原点到机器人所有经过的路径点（坐标为整数）的最大欧式距离的平方。（即，如果距离为 5 ，则返回 25 ）
    ///
    /// 注意：
    ///
    /// - 北表示 +Y 方向。
    /// - 东表示 +X 方向。
    /// - 南表示 -Y 方向。
    /// - 西表示 -X 方向。
    int robotSim(vector<int>& commands, vector<vector<int>>& obstacles) {
        vector<vector<int>> directions = { {0,1}, {1,0}, {0,-1}, {-1,0} };
        int dirIdx = 0;
        vector<int> pos = {0,0};
        int longest = 0;
        
        function<bool(vector<int>&, vector<int>&)> obs_cmp = [](vector<int>& ob1, vector<int>& ob2) {
            return ob1[0] < ob2[0] || (ob1[0] == ob2[0] && ob1[1] < ob2[1]);
        };
        sort(obstacles.begin(), obstacles.end(), obs_cmp);
        
        for (int i = 0; i < commands.size(); i++) {
            if (commands[i] < 0) {
                int dx = dirIdx + (commands[i] == -1 ? 1: -1);
                dirIdx = (dx + 4) % 4;
            }
            else {
                for (int j = 0; j < commands[i]; j++) {
                    vector<int> newpos = {pos[0] + directions[dirIdx][0], pos[1] + directions[dirIdx][1]};
                    
                    if (binary_search(obstacles.begin(), obstacles.end(), newpos, [obs_cmp](vector<int> ob1, vector<int> ob2){
                        return obs_cmp(ob1, ob2);
                    }))
                        break;
                    
                    longest = max(longest, newpos[0] * newpos[0] + newpos[1] * newpos[1]);
                    pos = newpos;
                }
            }
        }
        return longest;
    }
    
    /// #918. 环形子数组的最大和 --23/07/20
    int maxsubarraySum(vector<int>& nums) {
        vector<int> leftNMaxsums(nums.size(), 0);
        int res = nums[0];
        int preSum = nums[0];
        int leftSum = 0;
        leftNMaxsums[0] = nums[0];
        for (int i = 1; i < leftNMaxsums.size(); i++) {
            preSum = max(preSum, 0) + nums[i];
            res = max(res, preSum);
            leftSum += nums[i-1];
            leftNMaxsums[i] = max(leftNMaxsums[i-1], leftSum);
        }
        
        int rightSum = 0, rightMaxsum = 0;
        for (int i = (int)nums.size() - 1; i > 0; i--) {
            rightSum += nums[i];
            rightMaxsum = max(rightMaxsum, rightSum);
            
            res = max(res, rightMaxsum + leftNMaxsums[i]);
        }
        return res;
    }
    
    /// #1499. 满足不等式的最大值
    ///
    /// 给你一个数组 points 和一个整数 k 。数组中每个元素都表示二维平面上的点的坐标，并按照横坐标 x 的值从小到大排序。也就是说 points[i] = [xi, yi] ，并且在 1 <= i < j <= points.length 的前提下， xi < xj 总成立。
    ///
    /// 请你找出 yi + yj + |xi - xj| 的 最大值，其中 |xi - xj| <= k 且 1 <= i < j <= points.length。
    ///
    /// 题目测试数据保证至少存在一对能够满足 |xi - xj| <= k 的点。
    ///
    /// 链接：https://leetcode.cn/problems/max-value-of-equation
    ///
    int findMaxValueOfEquation(vector<vector<int>>& points, int k) {
        int maxval = INT32_MIN;
        int left = 0;
        int bpi = 0; // bestPointIndex
        int mpi = 1;
        for (int i = 1; i < points.size(); i ++) {
            int startJ = left;
            if (points[i][0] - points[bpi][0] <= k) {
                startJ = i - 1;
            } else {
                left += 1;
                startJ = left;
                bpi = left;
            }
            for(int j = startJ; j < i; j++) {
                if (points[i][0] - points[j][0] > k) {
                    left ++;
                    continue;
                }
                if (j == left) {
                    bpi = j;
                    continue;
                }
                if (points[j][0] - points[bpi][0] <= points[j][1] - points[bpi][1]) {
                    bpi = j;
                    left = j;
                }
            }
            
            
            if (bpi < left)
                continue;
            int val = points[i][1] + points[bpi][1] + points[i][0] - points[bpi][0];
            if (maxval <= val) {
                maxval = val;
                mpi = i;
            }
        }
        return maxval;
    }
    
    /// #771. 宝石与石头 --23/07/24
    int numJewelsInStones(string jewels, string stones) {
        int res = 0;
        set<char> jew_set;
        for (auto ch: jewels) {
            jew_set.insert(ch);
        }
        for (auto stone: stones) {
            if (jew_set.count(stone)) {
                res += 1;
            }
        }
        return res;
    }
    
    int integerBreak(int n) {
        if (n == 2) return 1;
        if (n == 3) return 2;
        if (n == 4) return 4;
        if (n == 5) return 6;
        if (n == 6) return 9;
        if (n == 7) return 12;
        if (n == 8) return 18;
        if (n == 9) return 27;
        if (n == 10) return 36;
        return 3 * integerBreak(n - 3);
    }
    
    /// #2500. 删除每行中的最大值 --23/07/27
    int deleteGreatestValue(vector<vector<int>>& grid) {
        int res = 0;
        for (auto& g: grid) {
            sort(g.begin(), g.end());
        }
        
        int m = (int)grid[0].size();
        for (int j = 0; j < m; j++) {
            int maxval = grid[0][j];
            for (int i = 1; i < grid.size(); i++) {
                maxval = max(maxval, grid[i][j]);
            }
            res += maxval;
        }
        return res;
    }
    
    /// #2208. 将数组和减半的最少操作次数
    int halveArray(vector<int>& nums) {
        int res = 0;
        double totalsum = 0;
        for (auto& num: nums) totalsum += num;
        
        priority_queue<float> pq(nums.begin(), nums.end());
        double harfsum = 0.5 * totalsum;
        double sum2 = 0;
        while (sum2 < harfsum) {
            float v = pq.top();
            sum2 += v / 2;
            pq.pop();
            pq.push(v/2);
            res += 1;
        }
        
        return res;
    }
    
    /// #980. 不同路径 III --23/08/07
    int uniquePathIII(vector<vector<int>>& grid) {
        int m = (int)grid.size();
        int n = (int)grid[0].size();
        pair<int, int> start;
        int step = 0;
        for (int i = 0; i < grid.size(); i++) {
            for (int j = 0; j < grid[i].size(); j++) {
                if (grid[i][j] == 1) {
                    start = {i,j};
                    step += 1;
                }
                else if (grid[i][j] == 0) {
                    step += 1;
                }
            }
        }
        
        vector<vector<int>> flag(m, vector(n, 0));
        vector<vector<int>> dirs = {{0,1}, {1,0}, {0,-1}, {-1,0}};
        function<bool(int,int,int)> isclamp = [](int v, int lower, int upper) {
            if (v >= lower && v <= upper) return true;
            return false;
        };
        
        int res = 0;
        function<bool(int i, int j)> dfs = [&](int i, int j) {
            flag[i][j] = 1;
            step --;
            for (auto &dir: dirs) {
                if (!isclamp(i+dir[0], 0, m-1) || !isclamp(j+dir[1], 0, n-1) ||
                    grid[i+dir[0]][j+dir[1]] == -1) {
                    continue;
                }
                if (flag[i+dir[0]][j+dir[1]] == 1) {
                    continue;
                }
                if (grid[i+dir[0]][j+dir[1]] == 2) {
                    if (step == 0) res += 1;
                    continue;
                }
                if (grid[i+dir[0]][j+dir[1]] == 0) {
                    dfs(i+dir[0], j+dir[1]);
                }
            }
            step ++;
            flag[i][j] = 0;
            return true;
        };
        
        dfs(start.first, start.second);
        return res;
    }
    
    ListNode * mergeTwoLists(ListNode * list1, ListNode * list2) {
        ListNode * prehead = new ListNode(0);
        ListNode * pre = prehead;
        while (list1 && list2) {
            if (list1->val < list2->val) {
                pre->next = list1;
                list1 = list1->next;
            }
            else {
                pre->next = list2;
                list2 = list2->next;
            }
            pre = pre->next;
        }
        if (list1) pre->next = list1;
        else if (list2) pre->next = list2;
        return prehead->next;
    }
    
    /// #279. 完全平方数
    /// 给你一个整数 n ，返回 和为 n 的完全平方数的最少数量 。
    int numSquares(int n) {
        if (n < 4) return n;
        vector<int> dp(n+1, 0);
        dp[1] = 1; dp[2] = 2; dp[3] = 3;
        dp[4] = 1;
        
        for(int i = 5; i <= n; i++) {
            int minixum = INT32_MAX;
            for (int j = 1; j * j <= i; j++) {
                int q = i - j * j;
                minixum = min(minixum, dp[q]);
            }
            dp[i] = minixum + 1;
        }
        return dp[n];
    }
    
    /// #85. 最大矩形
    /// 给定一个仅包含 0 和 1 、大小为 rows x cols 的二维二进制矩阵，找出只包含 1 的最大矩形，并返回其面积。
    ///
    /// Modify
    /// - 23/09/21.
    int maximalRectangle(vector<vector<char>>& matrix) {
        int col = (int)matrix.size();
        int row = (int)matrix[0].size();
        //        vector<vector<int>> ws(col+1, vector(row+1, 0)); // w
        vector<vector<int>> hs(col+1, vector(row+1, 0)); // h
        int w = 0; // 单行矩形长度
        int maximum = 0;
        for(int i = 0; i < col; i ++) {
            w = 0;
            for (int j = 0; j < row; j++) {
                if (matrix[i][j] == '1') {
                    //                    ws[i+1][j+1] = ws[i+1][j] + 1;
                    //                    maximum = max(maximum, ws[i+1][j+1]);
                    hs[i+1][j+1] = hs[i][j+1] + 1;
                    maximum = max(maximum, hs[i+1][j+1]);
                    w += 1;
                    maximum = max(maximum, w);
                }
                else {
                    w = 0;
                }
            }
        }
        
        for(int i = 1; i < col; i ++) {
            for (int j = 1; j < row; j++) {
                if (matrix[i][j] == '1') {
                    //                    int w = ws[i+1][j+1];
                    int h = hs[i+1][j+1];
                    int jj = j - 1;
                    while (jj >= 0 && matrix[i][jj] == '1' && h > 1) {
                        h = min(h, hs[i+1][jj+1]);
                        maximum = max(maximum, (j - jj + 1) * h);
                        jj --;
                    }
                }
            }
        }
        return maximum;
    }
    
    /// #1749. 任意子数组和的绝对值的最大值 --23/08/08
    int maxAbsSoluteSum(vector<int>& nums) {
        int res = 0;
        int n = (int)nums.size();
        // 1. memory
        //        vector<vector<int>> dp(n + 1, vector(n + 1, 0));
        //        for( int i = 0; i < nums.size(); i++) {
        //            for (int j = i; j < nums.size(); j++) {
        //                dp[i+1][j+1] = dp[i][j] + nums[j];
        //                res = max(res, abs(dp[i+1][j+1]));
        //            }
        //        }
        // 2. time
        vector<vector<int>> dp(2, vector(n + 1, 0));
        int flag = 1;
        for( int i = 0; i < nums.size(); i++) {
            for (int j = i; j < nums.size(); j++) {
                dp[flag][j+1] = dp[1-flag][j] + nums[j];
                res = max(res, abs(dp[flag][j+1]));
            }
            flag = 1 - flag;
        }
        
        int sum = 0;
        // 非负数最大值
        for( int i = 0; i < nums.size(); i++) {
            sum = max(sum, 0) + nums[i];
            res = max(res, sum);
        }
        sum = 0;
        // 负数最小值
        for( int i = 0; i < nums.size(); i++) {
            sum = min(sum, 0) + nums[i];
            res = max(res, -sum);
        }
        return res;
    }
    
    /// #1289. 下降路径最小和 --23/08/10
    ///
    /// 给你一个整数 n ，返回 和为 n 的完全平方数的最少数量 。
    ///
    /// 完全平方数 是一个整数，其值等于另一个整数的平方；换句话说，其值等于一个整数自乘的积。例如，1、4、9 和 16 都是完全平方数，而 3 和 11 不是。
    ///
    /// 链接：https://leetcode.cn/problems/perfect-squares
    int minFallingPathSumII(vector<vector<int>>& grid) {
        int n = (int)grid.size();
        if (n == 1) return grid[0][0];
        vector<int> sum(n, 0);
        for(int i = 0; i < n; i++) {
            int minidx1 = 0, minidx2 = 1;
            for (int j = 1; j < n; j++) {
                if (sum[j] < sum[minidx1]) {
                    minidx2 = minidx1; minidx1 = j;
                }
                else if (sum[j] < sum[minidx2])
                    minidx2 = j;
            }
            int minsum1 = sum[minidx1], minsum2 = sum[minidx2];
            for (int j = 0; j < n; j++) {
                int s = minsum1;
                if (j == minidx1)
                    s = minsum2;
                sum[j] = s + grid[i][j];
            }
        }
        
        int res = INT32_MAX;
        for(int i = 0; i < n; i++) {
            res = min(res, sum[i]);
        }
        return res;
    }
    
    /// #207. 课程表 --23/08/10
    /// 你这个学期必须选修 `numCourses` 门课程，记为 0 到 numCourses - 1 。
    ///
    /// 在选修某些课程之前需要一些先修课程。 先修课程按数组 `prerequisites` 给出，其中 `prerequisites[i] = [ai, bi]` ，表示如果要学习课程 ai 则 必须 先学习课程  bi 。
    ///
    /// 例如，先修课程对 [0, 1] 表示：想要学习课程 0 ，你需要先完成课程 1 。
    ///
    /// 请你判断是否可能完成所有课程的学习？如果可以，返回 true ；否则，返回 false 。
    bool canFinish(int numCourses, vector<vector<int>>& prerequisites) {
        vector<vector<int>> pqs(numCourses, vector<int>(0));
        for (auto& pq: prerequisites) {
            pqs[pq[0]].push_back(pq[1]);
        }
        
        vector<int> flags(numCourses, 0);
        function<bool(int i)> dfs = [&](int i) {
            flags[i] = -1;
            for(auto& q: pqs[i]) {
                if (flags[q] == 1) continue;
                if (flags[q] == -1) return false;
                if (dfs(q) == false) return false;
            }
            flags[i] = 1;
            return true;
        };
        for (int i = 0; i < numCourses; i++) {
            if (pqs[i].size() == 0) {
                flags[i] = 1;
            }
            if (!dfs(i)) {return false;}
        }
        return true;
    }
    
    /// #215. 数组中第K个最大元素 --23/08/10
    /// 给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。
    ///
    /// 请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。
    ///
    /// 你必须设计并实现时间复杂度为 O(n) 的算法解决此问题。
    int findKthLargest(vector<int>& nums, int k) {
        // 1.
        sort(nums.begin(), nums.end());
        return nums[nums.size() - k];
        
        int res = 0;
        //
        priority_queue<int> q(nums.begin(), nums.end());
        while (k > 1) {
            q.pop();
            k --;
        }
        res = q.top();
        
        return res;
    }
    
    /// #236. 二叉树的最近公共祖先 --23/08/10
    /// 给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。
    ///
    /// 百度百科中最近公共祖先的定义为：“对于有根树 T 的两个节点 p、q，最近公共祖先表示为一个节点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”
    TreeNode * lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if (isContainNode(p, q)) return p;
        if (isContainNode(q, p)) return q;
        vector<TreeNode*> pl;
        vector<TreeNode*> ql;
        ancestorList(root, p, pl);
        ancestorList(root, q, ql);
        int pr = (int)pl.size() - 1, qr = (int)ql.size() - 1;
        int idx = pr;
        while (pr >= 0 && qr >= 0 && pl[pr]->val == ql[qr]->val) {
            idx = pr;
            pr --; qr --;
        }
        return pl[pr];
    }
    bool isContainNode(TreeNode* root, TreeNode* n) {
        if (!root) return false;
        return root->val == n->val || isContainNode(root->left, n) || isContainNode(root->right, n);
    }
    bool ancestorList(TreeNode* root, TreeNode* n, vector<TreeNode*>& list) {
        if (!root) return false;
        if (root->val == n->val) return true;
        if (ancestorList(root->left, n, list) || ancestorList(root->right, n, list)) {
            list.push_back(root);
            return true;
        }
        return false;
    }
    
    int findDuplicate(vector<int>& nums) {
        int res = 0;
        int n = (int)nums.size();
        int idx = -1;
        for (int i = 0; i < n; i++) {
            if (nums[abs(nums[i]) - 1] < 0) {
                res = abs(nums[i]);
                idx = i;
                break;
            }
            nums[nums[i] - 1] *= -1;
        }
        for (int i = 0; i < n; i++) {
            nums[nums[i] - 1] *= -1;
        }
        return res;
    }
    
    /// #23. 合并 K 个升序链表
    ListNode* mergeKList(vector<ListNode*>& lists) {
        ListNode * prehead = new ListNode();
        ListNode * pre = prehead;
        
        sort(lists.begin(), lists.end(), [](ListNode*& p1, ListNode*& p2) {
            return (p1 && p2 && p1->val < p2->val) || !p1;
        });
        
        int idx = 0;
        while (idx < lists.size()) {
            
            ListNode * p = lists[idx];
            if (!lists[idx]) {
                idx += 1;
                continue;
            }
            pre->next = lists[idx];
            pre = pre->next;
            
            if (!pre->next) {
                idx += 1;
            } else {
                lists[idx] = pre->next;
                sort(lists.begin() + idx, lists.end(), [](ListNode*& p1, ListNode*& p2) {
                    return (p1 && p2 && p1->val < p2->val) || !p1;
                });
            }
        }
        return prehead->next;
    }
    
    /// #80. 删除有序数组中的重复项 II
    ///
    /// 给你一个有序数组 nums ，请你 原地 删除重复出现的元素，使得出现次数超过两次的元素只出现两次 ，返回删除后数组的新长度。
    ///
    /// 不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。
    int removeDuplicatesII(vector<int>& nums) {
        // W1
        //        int count = 1;
        //        int n = 1;
        //        for (int i = 1; i < nums.size(); i++) {
        //            if (nums[i] == nums[i-1])
        //                count ++;
        //            else
        //                count = 1;
        //            if (count <= 2) {
        //                nums[n] = nums[i];
        //                n ++;
        //            }
        //        }
        
        // W2
        if (nums.size() < 2) return (int)nums.size();
        int n = 2;
        for (int i = 2; i < nums.size(); i++) {
            if (nums[i] == nums[n-2])
                continue;
            nums[n] = nums[i];
            n ++;
        }
        return n;
    }
    
    /// #81. 搜索旋转排序数组 II
    ///
    /// 已知存在一个按非降序排列的整数数组 nums ，数组中的值不必互不相同。
    ///
    /// 在传递给函数之前，nums 在预先未知的某个下标 k（`0 <= k < nums.length`）上进行了 旋转 ，使数组变为 `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]`（下标 从 0 开始 计数）。例如， `[0,1,2,4,4,4,5,6,6,7]` 在下标 5 处经旋转后可能变为 `[4,5,6,6,7,0,1,2,4,4]` 。
    ///
    /// 给你 旋转后 的数组 nums 和一个整数 target ，请你编写一个函数来判断给定的目标值是否存在于数组中。如果 nums 中存在这个目标值 target ，则返回 true ，否则返回 false 。
    ///
    /// 你必须尽可能减少整个操作步骤。
    bool searchII(vector<int>& nums, int target) {
        int l = 0;
        int r = (int)nums.size() - 1;
        return search_part(nums, l, r, target);
    }
    
    bool search_part(vector<int>& nums, int l, int r, int target) {
        if (l > r)
            return false;
        if (nums[l] == target || nums[r] == target)
            return true;
        
        if (nums[l] < nums[r]) { // 单调性
            return search_binary(nums, l, r, target);
        }
        if (search_part(nums, l+1, (l+r) >> 1, target))
            return true;
        if (search_part(nums, ((l+r) >> 1) + 1, r-1, target))
            return true;
        return false;
    }
    
    bool search_binary(vector<int>& nums, int l, int r, int target) {
        if (target < nums[l] || nums[r] < target)
            return false;
        while (l <= r) {
            int mid = (l + r) >> 1;
            if (nums[mid] == target)
                return true;
            if (target < nums[mid])
                r = mid - 1;
            else
                l = mid + 1;
        }
        return false;
    }
    
    /// #10. 正则表达式匹配
    /// 给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
    ///
    /// '.' 匹配任意单个字符
    /// '*' 匹配零个或多个前面的那一个元素
    /// 所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。
    ///
    bool isMatch(string s, string p) {
        /* a-z, ['.','*']
         0: ch1 != ch2;
         1: ch1 = ch2;
         2: ch2 = '.';
         4: ch2 = '*';
         8: ch2 = '*' && ch2_pre != ch1 / '.'; 即需要忽略。
         */
        int sn = (int)s.size();
        int pn = (int)p.size();
        vector<vector<int>> dp(sn+1, vector(pn+1, 0));
        dp[0][0] = 1;
        
        /// `s[si] == p[pi] || p[pi] == '.'`
        auto match_s_p = [&](int si, int pi) {
            return s[si] == p[pi] || p[pi] == '.';
        };
        
        int pstart = 1;
        for (int i = 1; i <= sn; i++) {
            // 记录 s, p 严格匹配的下标
            int matchIndex = -1;
            // 第一个可匹配 s[i]
            int hasFirstMatch = false;
            for (int j = pstart; j <= pn; j++) {
                int flag = 0;
                if (match_s_p(i-1, j-1)) {
                    flag = dp[i-1][j-1]&7;
                    if (matchIndex == -1) {
                        flag = 1;
                        flag = (dp[i-1][j-1]&7) || dp[i][j-1];
                        flag = flag << (p[j-1] == '.' ? 1:0);
                        if (flag)
                            matchIndex = j-1;
                    }
                    
                    if (flag && !hasFirstMatch) {
                        pstart = j+1;
                        hasFirstMatch = true;
                    }
                }
                else if (p[j-1] == '*' && j > 1) {
                    if (j-2 == matchIndex) {
                        matchIndex = -1;
                    }
                    // ab, ab* | ab, abc*
                    flag = dp[i][j-1] || dp[i][j-2];
                    
                    // #2;  aa a* | ab, ac*
                    int isMatchLastp = match_s_p(i-1, j-2);
                    flag = flag || ((dp[i-1][j]&7) && isMatchLastp);
                    flag = flag || (dp[i-1][j-2]&7);
                    
                    flag = flag << (2+!isMatchLastp) | (!isMatchLastp && dp[i][j-2]&0x7);;
                    if (isMatchLastp && flag&7)
                        hasFirstMatch = true;
                }
                else {
                    
                }
                dp[i][j] = flag;
                
                // 枝剪
                //                if (flag == 0 && j > 1 && dp[i][j-1] == 0)
                //                    break;
            }
            
            // 枝剪
            if (!hasFirstMatch)
                break;
        }
        //        printf("\n");
        print_element(dp, [](auto& c){
            print_element(c, [](auto& r){
                printf("%2d", r);
            }, " ", "\n");
        }, "");
        return dp[sn][pn] & 7;
    }
    
    /// #147. 对链表进行插入排序 --23/08/14
    ListNode* insertionSortList(ListNode* head) {
        ListNode* res = nullptr;
        while (head) {
            ListNode * n = head->next;
            head->next = nullptr;
            insertion_part(res, head);
            head = n;
        }
        res = reverseListNode(res);
        return res;
    }
    void insertion_part(ListNode*& head, ListNode* n) {
        if (head == nullptr)
            head = n;
        else if (n->val < head->val)
            insertion_part(head->next, n);
        else {
            n->next = head;
            head = n;
        }
    }
    ListNode* reverseListNode(ListNode* head) {
        ListNode* pre = nullptr;
        while(head) {
            ListNode* n = head->next;
            head->next = pre;
            pre = head;
            head = n;
        }
        return pre;
    }
    
    ///
    string findReplaceString(string s, vector<int>& indices, vector<string>& sources, vector<string>& targets) {
        string res = "";
        int k = (int)indices.size();
        int si = 0;
        //
        vector<int> ins(k, 0);
        for (int i = 0; i < k; i++) {
            ins[i] = i;
        }
        sort(ins.begin(), ins.end(), [&](int i, int j) { return indices[i] < indices[j]; } );
        
        for (int i = 0; i < k; i++) {
            int idx = ins[i];
            int in = indices[idx];
            bool isRep = true;
            for (int j = 0, ii = in; j < sources[idx].size(); j++,ii++) {
                if (s[ii] != sources[idx][j]) {
                    isRep = false;
                    break;
                }
            }
            for (int j = si; j < in; j++) {
                res += s[j];
            }
            si = in;
            if (isRep) {
                res += targets[idx];
                si += (int)sources[idx].size();
            }
            
        }
        if (si < s.size()) {
            for (int j = si; j < s.size(); j++) {
                res += s[j];
            }
        }
        return res;
    }
    
    /// #1444. --23/08/17
    int ways(vector<string>& pizza, int k) {
        int col = (int)pizza.size();
        int row = (int)pizza[0].size();
        // pa[i][j]: 当前 pizza 上的苹果数量
        vector<vector<int>> pa(col, vector<int>(row, 0));
        for (int i = row-1; i >= 0; i--) {
            int r = 0;
            for (int j = col-1; j >= 0; j --) {
                if (pizza[i][j] == 'A')
                    r += 1;
                pa[i][j] = r + (i == row-1 ? 0: pa[i+1][j]);
            }
        }
        
        int limit = (int)pow(10, 9) + 7;
        vector<vector<vector<int>>> dp(col, vector<vector<int>>(row, vector<int>(k, 0)));
        function<int(vector<string>& pizza, int i, int j, int k)> ways_dfs =
        [&](vector<string>& pizza, int i, int j, int k) {
            if (dp[i][j][k] != 0) return dp[i][j][k];
            if (col + row - 2 - (i + j) < k)
                return 0;
            if (k == 0 && pa[i][j] > 0) {
                dp[i][j][k] = 1;
                return 1;
            }
            
            if (i+1 < col && pa[i][j] - pa[i+1][j] > 0) {
                dp[i][j][k] += ways_dfs(pizza, i+1, j, k-1);
            }
            if (j+1 < row && pa[i][j] - pa[i][j+1] > 0) {
                dp[i][j][k] += ways_dfs(pizza, 1, j+1, k-1);
            }
            if (j+1 < row && i+1 < col)
                dp[i][j][k] += ways_dfs(pizza, i+1, j+1, k);
            return dp[i][j][k];
        };
        
        ways_dfs(pizza, 0, 0, k-1);
        int res = dp[0][0][k-1];
        return 0;
    }
    
    /// #71. 简化路径 --23/08/27
    /// 给你一个字符串 path ，表示指向某一文件或目录的 Unix 风格 绝对路径 （以 '/' 开头），请你将其转化为更加简洁的规范路径。
    string simplifyPath(string path) {
        string res = "";
        vector<string> parts = stringSplit(path, "/");
        return res;
    }
    
    vector<string> stringSplit(string path, string split) {
        vector<string> res;
        string::size_type pos = 0;
        while (pos < path.size()) {
            auto idx = path.find(split, pos);
            if (idx > path.size())
                idx = path.size();
            if (idx > pos) {
                res.push_back(path.substr(pos, idx-pos));
            }
            pos = idx + 1;
        }
        return res;
    }
    
    /// #57. 插入区间
    ///
    /// 给你一个 无重叠的 ，按照区间起始端点排序的区间列表。
    ///
    /// 在列表中插入一个新的区间，你需要确保列表中的区间仍然有序且不重叠（如果有必要的话，可以合并区间）
    ///
    vector<vector<int>> insert(vector<vector<int>>& intervals, vector<int>& newInterval) {
        /* 1. 寻找最左、最右匹配位置li、ri；
         * 2. 合并 [li,ri] 所有区间，更新新区间；
         * 3. li == ri == -1时，追加 newInterval，更新排序；
         */
        vector<vector<int>> res;
        int li = -1, ri = -1;
        for(int i = 0; i < intervals.size(); i++) {
            auto& interval = intervals[i];
            if (interval[1] < newInterval[0] || newInterval[1] < interval[0])
                continue;
            li = i;
            break;
        }
        for(int i = (int)intervals.size() - 1; i >= 0; i--) {
            auto& interval = intervals[i];
            if (interval[1] < newInterval[0] || newInterval[1] < interval[0])
                continue;
            ri = i;
            break;
        }
        
        for(int i = 0; i < intervals.size(); i++) {
            auto interval = intervals[i];
            if (i < li || i > ri) {
                res.push_back(interval);
            }
            else {
                newInterval[0] = min(intervals[li][0], newInterval[0]);
                newInterval[1] = max(intervals[ri][1], newInterval[1]);
                res.push_back(newInterval);
                i = ri;
            }
        }
        if (li == -1) {
            // debug #114
            res.push_back(newInterval);
            sort(res.begin(), res.end(),[](vector<int>& in1, vector<int>& in2){
                return in1[0] < in2[0];
            });
        }
        return res;
    }
    
    int numFactoredBinaryTree(vector<int>& arr) {
        sort(arr.begin(), arr.end());
        int mod = 1e9 + 7;
        int maxVal = arr.back();
        long res = 0;
        //        vector<int> dp(maxVal+1, 0);
        //        for (int i = 0; i < arr.size(); i ++) {
        //            auto& a = arr[i];
        //            dp[a] += 1;
        //            res += dp[a];
        //            res %= mod;
        //            for (int j = 0; j <= i; j++) {
        //                int& b = arr[j];
        //                if (a * b > maxVal)
        //                    continue;
        //                int v = dp[a] * dp[b];
        //                if (a != arr[j])
        //                    v *= 2;
        //                v %= mod;
        //                dp[a*b] += v;
        //            }
        //        }
        
        map<int, int> idx;
        for (int i = 0; i < arr.size(); i++) {
            idx[arr[i]] = i;
        }
        
        vector<int> dp(arr.size(), 0);
        for (int i = 0; i < arr.size(); i ++) {
            auto& a = arr[i];
            dp[idx[a]] += 1;
            for (int j = 0; j < i; j++) {
                int& b = arr[j];
                if (a % b != 0)
                    continue;
                long v = idx.count(a/b) == 0 ? 0: dp[idx[a/b]] * dp[idx[b]];
                v %= mod;
                dp[idx[a]] += (int)v;
            }
            res += dp[idx[a]];
            res %= mod;
        }
        
        return (int)res;
    }
};

#include <numeric>

#endif /* Solution_hpp */
