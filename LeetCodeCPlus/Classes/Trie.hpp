//
//  Trie.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/7/2.
//

#ifndef Trie_hpp
#define Trie_hpp

#include <stdio.h>
#include <string>
#include <map>

//namespace LC {

using namespace std;

/// #208. 实现 Trie (前缀树)
///
/// Trie（发音类似 "try"）或者说 前缀树 /// 是一种树形数据结构，用于高效地存储和检索字符串数据集中的键。这一数据结构有相当多的应用情景，例如自动补完和拼写检查。
///
/// 请你实现 Trie 类：
///
/// Trie() 初始化前缀树对象。
/// - void insert(String word) 向前缀树中插入字符串 word 。
/// - boolean search(String word) 如果字符串 word 在前缀树中，返回 true（即，在检索之前已经插入）；否则，返回 false 。
/// - boolean startsWith(String prefix) 如果之前已经插入的字符串 word 的前缀之一为 prefix ，返回 true ；否则，返回 false 。
///
/// 示例：
///
///     输入
///     ["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
///     [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
///     输出
///     [null, null, true, false, true, null, true]
///
///     解释
///     Trie trie = new Trie();
///     trie.insert("apple");
///     trie.search("apple");   // 返回 True
///     trie.search("app");     // 返回 False
///     trie.startsWith("app"); // 返回 True
///     trie.insert("app");
///     trie.search("app");     // 返回 True
///
/// 提示：
///
/// * 1 <= word.length, prefix.length <= 2000
/// *  word 和 prefix 仅由小写英文字母组成
/// * insert、search 和 startsWith 调用次数 总计 不超过 3 * 104 次
///
class Trie {
    struct Node {
        int count = 0;
        bool end = 0;
        map<int, Node*> mp;
    };
    Node* root;
    
    public:
    Trie() {
        root = new Node();
    }
    
    void insert(string word) {
        Node* head = root;
        for (auto& ch: word) {
            Node * mp;
            if (head->mp.count(ch) == 0) {
                mp = new Node();
                head->mp[ch] = mp;
            }
            else {
                mp = head->mp[ch];
            }
            mp->count += 1;
            head = mp;
        }
        head->end = 1;
    }
    
    bool search(string word) {
        Node* head = root;
        for (auto& ch: word) {
            if (head->mp.count(ch) == 0) {
                return false;
            }
            Node * mp = head->mp[ch];
            if (mp->count == 0)
                return false;
            head = mp;
        }
        return head->end;
    }
    
    bool startsWith(string prefix) {
        Node* head = root;
        for (auto& ch: prefix) {
            if (head->mp.count(ch) == 0) {
                return false;
            }
            Node * mp = head->mp[ch];
            if (mp->count == 0)
                return false;
            head = mp;
        }
        return true;
    }
};

/**
 * Your Trie object will be instantiated and called as such:
 * Trie* obj = new Trie();
 * obj->insert(word);
 * bool param_2 = obj->search(word);
 * bool param_3 = obj->startsWith(prefix);
 */

//};

#endif /* Trie_hpp */
