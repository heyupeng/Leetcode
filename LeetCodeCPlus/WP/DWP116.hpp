//
//  DWP116.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/10/15.
//

#ifndef DWP116_hpp
#define DWP116_hpp

#include <stdio.h>

#include <vector>
#include <string>
#include <numeric>
#include <stack>

using namespace std;

#pragma - mark # 第 116 场双周赛
class Solution_DWC_116 {
    /// #100095. 上一个遍历的整数
    /// (Easy)
    ///
    /// 给你一个下标从 0 开始的字符串数组 words ，其中 words[i] 要么是一个字符串形式的正整数，要么是字符串 "prev" 。
    ///
    /// 我们从数组的开头开始遍历，对于 words 中的每个 "prev" 字符串，找到 words 中的 上一个遍历的整数 ，定义如下：
    ///
    /// k 表示到当前位置为止的连续 "prev" 字符串数目（包含当前字符串），令下标从 0 开始的 整数 数组 nums 表示目前为止遍历过的所有整数，同时用 nums_reverse 表示 /// nums 反转得到的数组，那么当前 "prev" 对应的 上一个遍历的整数 是 nums_reverse 数组中下标为 (k - 1) 的整数。
    /// 如果 k 比目前为止遍历过的整数数目 更多 ，那么上一个遍历的整数为 -1 。
    /// 请你返回一个整数数组，包含所有上一个遍历的整数。
    ///
    /// ```
    /// 示例 1：
    /// 输入：words = ["1","2","prev","prev","prev"]
    /// 输出：[2,1,-1]
    /// 解释：
    /// 对于下标为 2 处的 "prev" ，上一个遍历的整数是 2 ，因为连续 "prev" 数目为 1 ，同时在数组 reverse_nums 中，第一个元素是 2 。
    /// 对于下标为 3 处的 "prev" ，上一个遍历的整数是 1 ，因为连续 "prev" 数目为 2 ，同时在数组 reverse_nums 中，第二个元素是 1 。
    /// 对于下标为 4 处的 "prev" ，上一个遍历的整数是 -1 ，因为连续 "prev" 数目为 3 ，但总共只遍历过 2 个整数。
    /// 示例 2：
    /// 输入：words = ["1","prev","2","prev","prev"]
    /// 输出：[1,2,1]
    /// 解释：
    /// 对于下标为 1 处的 "prev" ，上一个遍历的整数是 1 。
    /// 对于下标为 3 处的 "prev" ，上一个遍历的整数是 2 。
    /// 对于下标为 4 处的 "prev" ，上一个遍历的整数是 1 ，因为连续 "prev" 数目为 2 ，同时在数组 reverse_nums 中，第二个元素是 1 。
    /// ```
    /// 提示：
    /// - 1 <= words.length <= 100
    /// - words[i] == "prev" 或 1 <= int(words[i]) <= 100
    vector<int> lastVisitedIntegers(vector<string>& words) {
        vector<int> res;
        vector<int> nums;
        int count = 0;
        int size = 0;
        for (auto& word: words) {
            if ("prev" != word) {
                nums.push_back(stoi(word));
                count = 0;
                size += 1;
            }
            else {
                count += 1;
                if (size - count < 0) {
                    res.push_back(-1);
                }
                else {
                    int num = nums[nums.size() - count];
                    res.push_back(num);
                }
            }
        }
        return res;
    }
    
    /// #100078. 最长相邻不相等子序列 I
    /// (Medium)
    ///
    /// 给你一个整数 n 和一个下标从 0 开始的字符串数组 words ，和一个下标从 0 开始的 二进制 数组 groups ，两个数组长度都是 n 。
    ///
    /// 你需要从下标 [0, 1, ..., n - 1] 中选出一个 最长子序列 ，将这个子序列记作长度为 k 的 [i0, i1, ..., ik - 1] ，对于所有满足 0 < j + 1 < k 的 j 都有 /// groups[ij] != groups[ij + 1] 。
    ///
    /// 请你返回一个字符串数组，它是下标子序列 依次 对应 words 数组中的字符串连接形成的字符串数组。如果有多个答案，返回任意一个。
    ///
    /// 子序列 指的是从原数组中删掉一些（也可能一个也不删掉）元素，剩余元素不改变相对位置得到的新的数组。
    ///
    /// 注意：words 中的字符串长度可能 不相等 。
    ///
    /// ```
    /// 示例 1：
    ///
    /// 输入：n = 3, words = ["e","a","b"], groups = [0,0,1]
    /// 输出：["e","b"]
    /// 解释：一个可行的子序列是 [0,2] ，因为 groups[0] != groups[2] 。
    /// 所以一个可行的答案是 [words[0],words[2]] = ["e","b"] 。
    /// 另一个可行的子序列是 [1,2] ，因为 groups[1] != groups[2] 。
    /// 得到答案为 [words[1],words[2]] = ["a","b"] 。
    /// 这也是一个可行的答案。
    /// 符合题意的最长子序列的长度为 2 。
    /// 示例 2：
    ///
    /// 输入：n = 4, words = ["a","b","c","d"], groups = [1,0,1,1]
    /// 输出：["a","b","c"]
    /// 解释：一个可行的子序列为 [0,1,2] 因为 groups[0] != groups[1] 且 groups[1] != groups[2] 。
    /// 所以一个可行的答案是 [words[0],words[1],words[2]] = ["a","b","c"] 。
    /// 另一个可行的子序列为 [0,1,3] 因为 groups[0] != groups[1] 且 groups[1] != groups[3] 。
    /// 得到答案为 [words[0],words[1],words[3]] = ["a","b","d"] 。
    /// 这也是一个可行的答案。
    /// 符合题意的最长子序列的长度为 3 。
    /// ```
    ///
    /// 提示：
    /// - 1 <= n == words.length == groups.length <= 100
    /// - 1 <= words[i].length <= 10
    /// - 0 <= groups[i] < 2
    /// - words 中的字符串 互不相同 。
    /// - words[i] 只包含小写英文字母。
    vector<string> getWordsInLongestSubsequence(int n, vector<string>& words, vector<int>& groups) {
        vector<int> indexs;
        for (int i = 1; i < n; i++) {
            if (i == 0 || words[i] != words[i-1]) {
                indexs.push_back(i);
            }
        }
        
        vector<string> res;
        for (auto& idx: indexs) {
            res.push_back(words[idx]);
        }
        return res;
    }
};

#endif /* DWP116_hpp */
