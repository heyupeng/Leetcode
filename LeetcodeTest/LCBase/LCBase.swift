//
//  LCBase.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/12/3.
//

import CoreFoundation

/// Use at #385
class NestedInteger {
    private var _isInteger: Bool = true
    private var _value: Int = 0
    private var _list: [NestedInteger] = []
    
    // Return true if this NestedInteger holds a single integer, rather than a nested list.
    public func isInteger() -> Bool {
        return _isInteger;
    }

    // Return the single integer that this NestedInteger holds, if it holds a single integer
    // The result is undefined if this NestedInteger holds a nested list
    public func getInteger() -> Int {
        return _value
    }

    // Set this NestedInteger to hold a single integer.
    public func setInteger(value: Int) {
        _value = value
    }

    // Set this NestedInteger to hold a nested list and adds a nested integer to it.
    public func add(elem: NestedInteger) {
        _list.append(elem)
    }

    // Return the nested list that this NestedInteger holds, if it holds a nested list
    // The result is undefined if this NestedInteger holds a single integer
    public func getList() -> [NestedInteger] {
        return _list
    }
}
