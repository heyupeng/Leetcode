//
//  codec.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/8/11.
//

#ifndef codec_hpp
#define codec_hpp

#include <stdio.h>
#include <vetor>

#include "ListNode.h"
//namespace LC {

using namespace std;

/// --22/08/11
class codec {
public:
    string serialize(TreeNode * root) {
        string res = "";
        
        vector<TreeNode *> tp[2];
        tp[0].push_back(root);
        int flag = 0;
        while (tp[flag].size() > 0) {
            for (int i = 0; i < tp[flag].size(); i++) {
                if (tp[flag][i] == nullptr) {
                    res += "N,";
                    continue;
                }
                res += to_string(tp[flag][i]->val);
                res += ",";
                tp[1-flag].push_back(tp[flag][i]->left);
                tp[1-flag].push_back(tp[flag][i]->right);
            }
            tp[flag].clear();
            flag = 1 - flag;
        }
//        res.pop_back();
        return res;
    }
    
    TreeNode * deserialize(string data) {
        int n = (int)data.size();
        if (n == 0) return nullptr;
        int pos = 0;
        string str = "";
        vector<string> slist;
        while (pos < n) {
            char ch = data[pos];
            if (ch != ',') {
                str += ch;
            } else {
                slist.push_back(str);
                str.clear();
            }
            pos ++;
        }
        if (!str.empty()) {
            slist.push_back(str);
            str.clear();
        }
        
        pos = 0;
        vector<TreeNode *> list;
        int count = 0;
        int idx = -1; int flag = 0;
        while (pos < slist.size()) {
            TreeNode * n = nullptr;
            string& str = slist[pos];
            if (str != "N") {
                int val = (int)strtol(str.c_str(), nullptr, 10);
                n = new TreeNode(val);
                list.push_back(n);
                count += 1;
            }
            if (count == 1) {
                idx = 0;
            }
            else if (flag == 0) {
                list[idx]->left = n;
                flag = 1;
            }
            else if (flag == 1) {
                list[idx]->right = n;
                flag = 0; idx += 1;
            }
            pos ++;
        }
        return list.empty() ? nullptr: list[0];
    }
};

//};

#endif /* Trie_hpp */
