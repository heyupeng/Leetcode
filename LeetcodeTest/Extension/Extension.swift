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
