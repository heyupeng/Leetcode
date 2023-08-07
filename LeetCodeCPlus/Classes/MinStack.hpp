//
//  MinStack.hpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/7/2.
//

#ifndef MinStack_hpp
#define MinStack_hpp

#include <stdio.h>
#include <stack>

namespace LC {

using namespace std;

/// #155. 最小栈
///
///设计一个支持 push ，pop ，top 操作，并能在常数时间内检索到最小元素的栈。
///
/// 实现 MinStack 类:
///
/// * `MinStack()` 初始化堆栈对象。
/// * `void push(int val)` 将元素val推入堆栈。
/// * `void pop()` 删除堆栈顶部的元素。
/// * `int top()` 获取堆栈顶部的元素。
/// * `int getMin()` 获取堆栈中的最小元素。
 ///
class MinStack {
    // [val, min]
    stack<pair<int, int>> stk;
public:
    MinStack() {
        
    }
    
    void push(int val) {
        int minVal = val;
        if (!stk.empty()) {
            minVal = stk.top().second;
        }
        stk.push({val, minVal});
    }
    
    void pop() {
        stk.pop();
    }
    
    int top() {
        return stk.top().first;
    }
    
    int getMin() {
        return stk.top().second;
    }
};

};

#endif /* MinStack_hpp */
