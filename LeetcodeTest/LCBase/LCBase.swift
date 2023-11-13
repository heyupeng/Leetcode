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

func powi(_ m:Int, _ n: Int) -> Int {
    if m <= 0 { return 0 }
    if n == 0 { return 1 }
    
    var num = 1
    for _ in 0..<n {
        num *= m
    }
    return num
}

extension Int {
    
    /// value = m ^ n
    public static func pow(_ m:Int, _ n: Int) -> Int {
        if m <= 0 { return 0 }
        if n == 0 { return 1 }
        if n == 1 { return m }
        
        var num = 1
        for _ in 0..<n {
            num *= m
        }
        return num
    }
    
    /// [a, b]。x = 10 ^ a * b 。eg：30 = 10 ^ 1 * 3
    public static func log10(_ x: Int) -> [Int] {
        var tempX = x
        var value = 0
        let base = 10
        while tempX > 0 && tempX % base == 0 {
            tempX /= base
            value += 1
        }
        return [value, tempX]
    }
    
    /// value。lft ≤ value ≤ rgt
    func clamp(_ lft: Self, _ rgt: Self) -> Int {
        var value = self
        if value > rgt {
            value = rgt
        } else if value < lft {
            value = lft
        }
        return value
    }
}
