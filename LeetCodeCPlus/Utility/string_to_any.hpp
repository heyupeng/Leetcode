//
//  string_to_any.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/7/2.
//

#ifndef string_to_any_hpp
#define string_to_any_hpp
#include <vector>
#include <string>

template<class _Typ>
std::vector<_Typ> string_split_regex_totyp(std::string::iterator begin, std::string::iterator end, std::string& split, std::function<_Typ(std::string)> totype);

std::vector<std::string> string_split_regex(std::string::iterator begin, std::string::iterator end, std::string& split);
std::vector<std::string> string_split_regex(std::string& str, std::string& split);

int string_to_int(std::string s);
std::vector<int> string_to_vector_int(std::string str);
std::vector<std::vector<int>> string_to_vector_vector_int(std::string str);

#endif /* string_to_any_hpp */
