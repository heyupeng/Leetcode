//
//  ContainsDuplicate.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/27.
//

import UIKit

/// #217. 存在重复元素
class ContainsDuplicate: NSObject {
    /**
     给定一个整数数组，判断是否存在重复元素。

     如果存在一值在数组中出现至少两次，函数返回 true 。如果数组中每个元素都不相同，则返回 false 。
     */
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var dict: [Int:Int] = [:]
        
        for (index, value) in nums.enumerated() {
            if (dict.keys.contains(value)) {
                return true
            }
            dict[value] = index
        }
        return false
        /// leetcode 上最短代码
        /*
         let result = Set(nums)
         return nums.count != result.count
         */
    }
    
    func test1() -> Bool {
        return containsDuplicate([1,2,3,1])
    }
}

/// #53. 最大子序和
class MaxSubArray: NSObject {
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.first!
        }
        
        var max = nums.last!
        var newNums = Array<Int>()
        for value in nums {
            if value > max { max = value }
            
            if newNums.isEmpty, value <= 0 {
                continue
            }
            if !newNums.isEmpty, let last = newNums.last, last * value >= 0 {
                newNums[newNums.count-1] = last + value
                continue
            }
            newNums.append(value)
        }
        
        for value in newNums {
            if value > max { max = value }
        }
        
        if let last = newNums.last, last < 0 {
            newNums.removeLast()
        }
        
        
        var i = newNums.count - 3
        
        while i >= 0 {
            let n1 = newNums[i]
            if (n1 < 0) { i -= 1; continue }
            let n2 = newNums[i+1], n3 = newNums[i+2]
            
            if n2 + n3 <= 0, newNums.count - 1 == i + 2 {
                if (max < n1) { max = n1 }
            }
            else if n2 + n3 > 0, newNums.count - 1 == i + 2 {
                newNums[i] = n1 + n2 + n3
                if (max < newNums[i]) { max = newNums[i] }
            }
            i -= 1
        }
        return max
    }
    
    func test1() -> Int {
//        let test1 = [-2,1,-3,4,-1,2,1,-5,4]
//        let test2 = [-2,-1]
//        let test136 = [1,2]
        let test164 = [1,2,-1,-2,2,1,-2,1]
        return maxSubArray(test164)
    }
}
