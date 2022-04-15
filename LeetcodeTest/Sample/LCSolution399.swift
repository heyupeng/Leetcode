//
//  LCSolution.swift
//  LeetcodeTest
//
//  Created by Peng on 2022/4/13.
//

import Foundation

// MARK: #300 - #399
protocol LCSolution_399 {
    
}

extension LCSolution: LCSolution_399 {
    
}

extension LCSolution_399 {
    
    // MARK: #385. 迷你语法分析器
    /// #385. 迷你语法分析器 (-- 2022-04-15)
    ///
    /// 给定一个字符串 s 表示一个整数嵌套列表，实现一个解析它的语法分析器并返回解析的结果 NestedInteger 。
    ///
    /// 列表中的每个元素只可能是整数或整数嵌套列表
    ///
    /// 示例 1：
    ///
    ///     输入：s = "324",
    ///     输出：324
    ///     解释：你应该返回一个 NestedInteger 对象，其中只包含整数值 324。
    /// 示例 2：
    ///
    ///     输入：s = "[123,[456,[789]]]",
    ///     输出：[123,[456,[789]]]
    ///     解释：返回一个 NestedInteger 对象包含一个有两个元素的嵌套列表：
    ///     1. 一个 integer 包含值 123
    ///     2. 一个包含两个元素的嵌套列表：
    ///         i.  一个 integer 包含值 456
    ///         ii. 一个包含一个元素的嵌套列表
    ///              a. 一个 integer 包含值 789
    /// 提示：
    ///
    ///     1 <= s.length <= 5 * 104
    ///     s 由数字、方括号 "[]"、负号 '-' 、逗号 ','组成
    ///     用例保证 s 是可解析的 NestedInteger
    ///     输入中的所有值的范围是 [-106, 106]
    ///
    /// 链接：https://leetcode-cn.com/problems/mini-parser
    func deserialize(_ s: String) -> NestedInteger {
        let symbols = ["[", "-", ",", "]"]
        
        func recursion(start: String.Index) -> (NestedInteger, String.Index) {
            if start == s.endIndex { return (NestedInteger() , start) }
            let endIndex = s.endIndex
            
            let n = NestedInteger()
            let firstChar = s[Range(uncheckedBounds: (start, s.index(after: start)))]
            let isCollection = String(firstChar).elementsEqual(symbols[0])
            var startIdx = start
            
            if (!isCollection) {
                // 数组
                startIdx = s.index(after: startIdx)
                while(startIdx != endIndex) {
                    let prefix = s[Range(uncheckedBounds: (startIdx, s.index(after: startIdx)))]
                    if prefix == symbols[3] {
                        startIdx = s.index(after: startIdx)
                        break
                    }
                    if prefix == symbols[2] {
                        startIdx = s.index(after: startIdx)
                        continue
                    }
                    else if prefix == symbols[0] {
                        let (nn, idx) = recursion(start: startIdx)
                        n.add(elem:nn)
                        startIdx = idx
                        continue
                    }
                    
                    var idx = s.firstIndex(Character(symbols[2]), startIdx, endIndex)
                    if idx == nil {
                        idx = s.firstIndex(Character(symbols[3]), startIdx, endIndex)
                    }
                    if idx == nil { idx = endIndex }
                    
                    let curRange = Range(uncheckedBounds: (startIdx, idx!))
                    let subStr = s[curRange]
                    let v = Int(subStr)
                    let nn = NestedInteger()
                    nn.setInteger(value: v!)
                    n.add(elem: nn)
                    
                    startIdx = idx!
                }
            } else {
                // 数字
                while(startIdx != endIndex) {
                    var idx = s.firstIndex(Character(symbols[2]), startIdx, endIndex)
                    if idx == nil {
                        idx = s.firstIndex(Character(symbols[3]), startIdx, endIndex)
                    }
                    if idx == nil { idx = endIndex }
                    
                    let curRange = Range(uncheckedBounds: (startIdx, idx!))
                    let subStr = s[curRange]
                    if let v = Int(subStr) {
                        n.setInteger(value: v)
                    }
                    
                    startIdx = idx!
                    break
                }
            }
            return (n, startIdx)
        }
        
        let nested = recursion(start: s.startIndex)
        return nested.0
    }
    
    // MARK: #357. 统计各位数字都不同的数字个数
    /// #357. 统计各位数字都不同的数字个数
    ///
    /// 难度:中等。 (-- 2022-04-15)
    ///
    /// 给你一个整数 n ，统计并返回各位数字都不同的数字 x 的个数，其中 0 <= x < 10n 。
    ///
    ///     示例 1：
    ///     输入：n = 2
    ///     输出：91
    ///     解释：答案应为除去 11、22、33、44、55、66、77、88、99 外，在 0 ≤ x < 100 范围内的所有数字。
    ///
    ///     示例 2：
    ///     输入：n = 0
    ///     输出：1
    ///
    /// 提示：
    ///
    ///     0 <= n <= 8
    func countNumbersWithUniqueDigits(_ n: Int) -> Int {
        /* 17:10 - 15:40 */
        /*
         s0 = 1
         sn = s(n-1) + 9*A(9,n-1)
         */
        
        func A(_ m: Int, _ n: Int) -> Int {
            if m < n { return -1 }
            var num = 1
            for i in 0..<n {
                num *= (m - i)
            }
            return num
        }
        
        var sum = 0
        for digit in 0..<n {
            if digit == 0 { sum += 1}
            else { sum += 9 * A(9, digit-1) }
        }
        return sum
    }
}

// MARK: #380. O(1) 时间插入、删除和获取随机元素

/// #380. O(1) 时间插入、删除和获取随机元素   (-- 2022-04-13)
///
/// 实现RandomizedSet 类：
///
/// RandomizedSet() 初始化 RandomizedSet 对象
///
/// bool insert(int val) 当元素 val 不存在时，向集合中插入该项，并返回 true ；否则，返回 false 。
///
/// bool remove(int val) 当元素 val 存在时，从集合中移除该项，并返回 true ；否则，返回 false 。
///
/// int getRandom() 随机返回现有集合中的一项（测试用例保证调用此方法时集合中至少存在一个元素）。每个元素应该有 相同的概率 被返回。
///
/// 你必须实现类的所有函数，并满足每个函数的 平均 时间复杂度为 O(1) 。
///
/// 链接：https://leetcode-cn.com/problems/insert-delete-getrandom-o1
///
/// 执行结果：通过
///
///     执行用时：628 ms, 在所有 Swift 提交中击败了40.00%的用户
///     内存消耗：29.9 MB, 在所有 Swift 提交中击败了83.33%的用户
///     通过测试用例：19 / 19
class RandomizedSet {
    var numMap: [Int: Int] = [:]
    init() {

    }
    
    func has( _ val: Int) -> Bool {
        return numMap.contains { (key: Int, value: Int) in
            if key == val { return true}
            return false
        }
    }
    
    func insert(_ val: Int) -> Bool {
        let isHas = has(val)
        if !isHas {
            numMap[val] = val
        }
        return !isHas
    }
    
    func remove(_ val: Int) -> Bool {
        let isHas = has(val)
        if isHas {
            numMap.removeValue(forKey: val)
        }
        return isHas
    }
    
    func getRandom() -> Int {
//        let count = numMap.count
//        let random = Int.random(in: 0..<count)
//        let keys = numMap.keys
//        let v = keys[keys.index(keys.startIndex, offsetBy: random)]
        
//        let keys = Array(numMap.keys) as [Int]
//        let v = keys[random]
                
//        print("\(keys)")
        
        let randomElement = numMap.randomElement()
        let v = randomElement?.key
        return v ?? 0
    }
}
