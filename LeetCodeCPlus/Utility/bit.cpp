//
//  bit.cpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/11/13.
//

#include "bit.hpp"

#include <__bits>

int lowbit(int a) {
    /*
     a:     0001 1000
     a-1:   0001 0111
     b = a^(a-1) + 1 = 0000 1111
     (b+1) >> 1 = 0000 1000 or b ^ (b-1)
     */
    return (a & -a);
}

int highbit(int a) {
    int bit = 31 - __builtin_clz(a);
//    int bit = 0;
//    int k = 16;
//    while (a > 0 && k > 0) {
//        int v = a >> k;
//        if (v > 0) {
//            bit += k;
//            a = v;
//        }
//        k >>= 1;
//    }
    return 1 << bit;
}

int highBit_cb(int a) {
    int b = 0;
    while (a) {
        // b = a^(a-1) + 1; b ^= (b >> 1);
        b = a; /// 低位1会被清除，记录最终a即可。
        a &= a - 1;
    }
    return b;
}
