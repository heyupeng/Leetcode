//
//  string_to_any.cpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/7/2.
//

#include "string_to_any.hpp"
#include <iostream>

using namespace std;

#include <regex>
template<class _ResTyp>
vector<_ResTyp> string_split_regex_totyp(string::iterator begin, string::iterator end, string& split, function<_ResTyp(string)> totype) {
    regex re(split);
    auto token_it = sregex_token_iterator(begin, end, re, -1);
    
    vector<_ResTyp> vec;
    decltype(token_it) It;
    for (auto it = token_it; it != sregex_token_iterator(); it++) {
        vec.push_back(totype(it->str()));
    }
    return vec;
}

vector<string> string_split_regex(string::iterator begin, string::iterator end, string& split) {
    regex re(split);
    auto token_it = sregex_token_iterator(begin, end, re, -1);
    vector<string> vec(token_it, sregex_token_iterator());
    return vec;
}

vector<string> string_split_regex(string& str, string& split) {
    return string_split_regex(str.begin(), str.end(), split);
}

// convert

int string_to_int(string s) {
    return (int)strtol(s.c_str(), nullptr, 10);
}

vector<int> string_to_vector_int(string str) {
    string split = ",";
    
    int length = (int)str.size();
    int begin = 0;
    auto bi = str.find_first_of("[", begin);
    auto ei = str.find_first_of("]", begin);
    while (bi >= begin && bi < length && ei > begin && ei < length) {
        vector<int> temp = string_split_regex_totyp(str.begin()+bi+1, str.begin()+ei, split, (function<int(string)>)string_to_int);
        return temp;
    };
    return {};
}

vector<vector<int>> string_to_vector_vector_int(string str) {
    function<int(string)> string_to_int = [](string s) {
        return (int)strtol(s.c_str(), nullptr, 10);
    };
    string split = ",";
    vector<vector<int>> res;
    
    int begin = 1; int n = (int)str.size();
    auto bi = str.find_first_of("[", begin);
    auto ei = str.find_first_of("]", begin);
    while (bi >= begin && bi < n && ei > begin && bi+1 < ei && ei < n) {
        vector<int> temp = string_split_regex_totyp(str.begin()+bi+1, str.begin()+ei, split, string_to_int);
        res.push_back(temp);
        
        begin = (int)ei + 1;
        bi = str.find_first_of("[", begin);
        ei = str.find_first_of("]", begin);
    };
    return res;
}
