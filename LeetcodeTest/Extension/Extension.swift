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
