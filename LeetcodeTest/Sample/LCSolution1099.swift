//
//  LCSolution.swift
//  LeetcodeTest
//
//  Created by Peng on 2022/4/13.
//

import Foundation

// MARK: #1000 - #1099
protocol LC_1099 {
    
}

extension LCSolution: LC_1099 {

}

extension LC_1099 {
    
    // MARK: #1027. 最长等差数列
    
    /// #1027. 最长等差数列 (-- 2022-04-14)
    /// 给你一个整数数组 nums，返回 nums 中最长等差子序列的长度。
    ///
    /// 回想一下，nums 的子序列是一个列表 nums[i1], nums[i2], ..., nums[ik] ，且 0 <= i1 < i2 < ... < ik <= nums.length - 1。并且如果 seq[i+1] - seq[i]( 0 <= i < seq.length - 1) 的值都相同，那么序列 seq 是等差的。
    ///
    /// 链接：https://leetcode-cn.com/problems/longest-arithmetic-subsequence
    func longestArithSeqLength(_ nums: [Int]) -> Int {
        // 10:27 - 11:30, 12:50 - -
        NSLog("1")
        if nums.count < 3 { return nums.count }
        /*
         1 4 5 7 7 7 8 9
       1   3 4 6 6 6 7 8
       4     1 3 3 3 4 5
             0 2 2 2 3 4
         */
        let numsSorted = nums
        
        let count = numsSorted.count
        var subs = Array(repeating: Array(repeating: -1, count: numsSorted.count), count: numsSorted.count)
        for i in 0..<count-1 {
            for j in i+1..<count {
                subs[i][j] = numsSorted[j] - numsSorted[i]
            }
        }
        
        var maxLength = 0;
        for i in 0..<count-1 {
            if (count - i < maxLength) {
                break
            }
            var recordeds: [Int:Int] = [:]
            for j in i+1..<count {
                let sub = subs[i][j]
                if (recordeds[sub] != nil) {
                    continue
                }
                
                var length = 2;
                var ii = j, jj = -1
                while (ii < count) {
                    jj = BinarySearch.find(unsorted: subs[ii], equalTo: sub, lft: ii+1, rgt: count-1)
                    if jj == -1 {
                        break
                    }
                    ii = jj
                    length += 1
                }
                maxLength = max(maxLength, length)
                recordeds[sub] = length
            }
        }
        NSLog("2")
        return maxLength
    }
    
    func longestArithSeqLengthAdvance(_ nums: [Int]) -> Int {
        // 13:35 - -
        NSLog("1")
        if nums.count < 3 { return nums.count }
        
        /*
         i\j 1 4 5 7 7 7 8 9
         1     3 4 6 6 6 7 8
         4       1 3 3 3 4 5
         5         2 2 2 3 4
         7           0 0 1 2
         7             0 1 2
         7               0 2
         8                 1
         9
         */
        
        var maxLength = 0;
        
        // 去重
        var numsWithoutDuplicate: [Int] = []
        var numMap: [Int: Int] = [:]
        var maxDuplicateCount = 0
        nums.forEach { num in
            let count = numMap[num]
            if count == nil {
                numsWithoutDuplicate.append(num)
            }
            numMap[num] = (count ?? 0) + 1
            maxDuplicateCount = max(maxDuplicateCount, numMap[num]!)
        }
        maxLength = maxDuplicateCount
        // numMap.values.reduce(0){ $0 + $1 }
        
        let count = nums.count
        var subMaps = Array(repeating: [:], count: count)
        
        var subs = Array(repeating: Array(repeating: -1, count: count), count: count)
        for i in 0..<count-1 {
            for j in i+1..<count {
                let sub = nums[j] - nums[i]
                subs[i][j] = sub
                if let _ = subMaps[i][sub] {
                    continue
                }
                subMaps[i][sub] = j
            }
        }
        // way 1
        for i in 0..<count-1 {
            if (count - i <= maxLength) {
                break
            }
            let duplicate = numMap[nums[i]]
            if duplicate == nil || duplicate! > 1 {
                continue
            }
            numMap[nums[i]] = 0

            let curSubs = subs[i]
            var recordeds: [Int:Int] = [:]
            for j in i+1..<count {
                if (count - j <= maxLength) {
                    break
                }
                let sub = curSubs[j]
                if (recordeds[sub] != nil) {
                    continue
                }
                else if (sub == 0) {
                    continue
                }

                var length = 2;
                var ii = j, jj = -1
                while (ii < count) {
                    jj = -1
                    if let idx = subMaps[ii][sub] as? Int {
                        jj = idx
                    }
                    if jj == -1 {
                        break
                    }
                    ii = jj
                    length += 1
                }
                maxLength = max(maxLength, length)
                recordeds[sub] = length
            }
        }
        // way 2
        for i in 0..<subMaps.count {
            if count - 1 - i < maxLength {
                break
            }
            let subMap = subMaps[i]
            for ele in subMap {
                let sub = ele.key as! Int
                var ii = ele.value as! Int
                var length = 2

                if count - 1 - ii + length < maxLength {
                    break
                }
                while let idx = subMaps[ii][sub] as? Int {
                    ii = idx
                    length += 1
                }
                maxLength = max(maxLength, length)
            }
        }
        NSLog("3")
        return maxLength
    }
}
