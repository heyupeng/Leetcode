//
//  LCSample.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/7/2.
//

#ifndef LCSample_hpp
#define LCSample_hpp

#include <stdio.h>

namespace LC {

template <class _Tp1, class _Tp2, class _Tp3, class _Tp4>
class Params4 {
    int count = 0;
public:
    
    typedef _Tp1 value_type1;
    typedef _Tp2 value_type2;
    typedef _Tp2 value_type3;
    typedef _Tp2 value_type4;
    
    value_type1 val1;
    value_type2 val2;
    value_type3 val3;
    value_type4 val4;
    
    Params4(value_type1 val1): val1(val1) {
        count = 1;
    }
    Params4(value_type1 val1, value_type2 val2): val1(val1), val2(val2) {
        count = 2;
    }
    Params4(value_type1 val1, value_type2 val2, value_type3 val3): val1(val1), val2(val2), val3(val3) {
        count = 3;
    }
};

template <class _Tp1, class _Tp2>
class Params2 {
    int count = 0;
public:
    
    typedef _Tp1 value_type1;
    typedef _Tp2 value_type2;
    
    value_type1 val1;
    value_type2 val2;
    
    Params2(value_type1 val1): val1(val1) {
        count = 1;
    }
    Params2(value_type1 val1, value_type2 val2): val1(val1), val2(val2) {
        count = 2;
    }
};

template <class _Tp1, class _Tp2>
class Sample {
    bool hasAns = false;
public:
    
    typedef _Tp1 value_type;
    typedef _Tp2 answer_type;
    
    int ID = -1;
    value_type par;
    answer_type ans;
    
    Sample(int ID, value_type value): ID(ID), par(value) {
        
    }
    
    Sample(int ID, value_type value, answer_type ans):ID(ID), par(value), ans(ans) {
        hasAns = true;
    }
};

};

#endif /* LCSample_hpp */
