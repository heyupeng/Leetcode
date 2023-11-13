//
//  Extension.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/11/24.
//

protocol StringToArray {
    func characters() -> [Character]
}

extension String: StringToArray {
    func characters() -> [Character] {
        var chs: [Character] = []
        for ch in self {
            chs.append(ch)
        }
        return chs
    }
    
    /// 正向寻找字符，区间 [start, end) 。
    func firstIndex(_ ch: Character, _ startIndex: String.Index, _ endIndex: String.Index) -> String.Index? {
        var lIdx = startIndex, rIdx = endIndex
        while lIdx < rIdx {
            if self[lIdx] == ch {
                return lIdx
            }
            lIdx = self.index(after: lIdx)
        }
        return nil
    }
    
    /// 反向寻找字符，区间 [start, end) 。
    func lastIndex(_ ch: Character, _ startIndex: String.Index, _ endIndex: String.Index) -> String.Index? {
        var lIdx = startIndex, rIdx = endIndex
        rIdx = self.index(before: rIdx)
        while lIdx < rIdx {
            if self[rIdx] == ch {
                return rIdx
            }
            rIdx = self.index(before: rIdx)
        }
        return nil
    }
}

extension Int {
    static func greatestCommonDivisor(_ num1: Int, _ num2: Int) -> Int {
        if num1 == 0 { return num2 }
        if num2 == 0 { return num1 }
        #if true
        return greatestCommonDivisor(num2, num1 % num2)
        #else
        var div1 = num1 // max(abs(num1), abs(num2))
        var div2 = num2 // min(abs(num1), abs(num2))
        var r = div1 % div2
        while r != 0 {
            div1 = div2
            div2 = r
            r = div1 % div2
        }
        return div2
        #endif
    }
}

extension Int {
    /// 向上取整
    ///
    ///     if a % b == 0 { return a / b } else { return a / b + 1 }
    ///
    /// - Parameters:
    ///   - a: 被除数、分子。
    ///   - b: 除数、分母。
    /// - Returns: eg: 10 / 3 = 3.333... = 4。
    static func ceil(_ a: Int, _ b: Int) -> Int {
        if b == 0 { fatalError("divisor == 0") }
        if b == 1 { return a }
        
        var value = a / b
        if a % b != 0 {
            value += 1
        }
        return value
    }
    
    /// 向上取整
    /// - Parameter divisor: 除数、分母。
    /// - Returns: 商数向上取整。
    func ceil(_ divisor: Int) -> Int {
        return Int.ceil(self, divisor)
    }
}
