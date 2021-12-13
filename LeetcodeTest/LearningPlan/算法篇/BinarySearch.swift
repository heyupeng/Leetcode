//
//  asdsa.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/12/3.
//

struct BinarySearch {
    
    /// 在按升序排列的数组 nums 中，查找最后一个不大于 target 的元素的下标。
    ///
    /// 示例 1:
    ///
    ///     输入: [1,3,4,5,5,7] 5
    ///     输出: 4
    /// 示例 2:
    ///
    ///     输入: [1,3,4,5,5,7] 6
    ///     输出: 4
    ///
    /// - Parameters:
    ///   - nums: 升序排列的数组
    ///   - target: 目标值
    /// - Returns: 返回最后一个不大于 target 的元素的下标。-1 表示不存在。
    static func findLast(_ nums: [Int], lessThanOrEqualTo target: Int) -> Int {
        if nums.count == 0 { return -1 }
        if target < nums[0] { return -1 }
        
        var l = 0, r = nums.count
        var res = -1
        while l <= r {
            let m = (l + r) / 2
            if nums[m] <= target {
                l = m + 1
                res = m
            } else {
                r = m - 1
            }
        }
        return res
    }
    
    static func findLast(_ nums: [Int], lessThanOrEqualTo target: Int, _ lftIdx: Int, _ rgtIdx: Int) -> Int {
        if nums.count == 0 { return -1 }
        if target < nums[lftIdx] { return -1 }
        if nums[rgtIdx] <= target { return rgtIdx }
        
        var l = lftIdx, r = rgtIdx
        var res = -1
        while l <= r {
            let m = (l + r) / 2
            if nums[m] <= target {
                l = m + 1
                res = m
            } else {
                r = m - 1
            }
        }
        return res
    }
}
