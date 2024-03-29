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
    
    static func find(sorted nums:[Int], equalTo target: Int, lft: Int, rgt: Int) -> Int {
        if nums.count == 0 { return -1 }
        if lft >= nums.count { return -1 }
        
        var l = lft, r = rgt
        if r > nums.count - 1 { r = nums.count - 1 }
        
        var idx = -1
        while l <= r {
            let mid = (l + r) / 2
            if target == nums[mid] {
                idx = mid
                break
            }
            else if target < nums[mid] {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
        return idx
    }
    
    static func find(unsorted nums:[Int], equalTo target: Int, lft: Int, rgt: Int) -> Int {
        if nums.count == 0 { return -1 }
        if lft >= nums.count { return -1 }
        
        var l = lft, r = rgt
        if l < 0 { l = 0 }
        if r > nums.count - 1 { r = nums.count - 1 }
        
        var idxMap: [Int: Int] = [:]
        var nums1: [Int] = []
        for i in l...r {
            let v = nums[i]
            if (idxMap .contains(where: { (key: Int, value: Int) in
                key == v
            })) {
                continue
            }
            idxMap[v] = i
            nums1.append(v)
        }
        nums1 = nums1.sorted { a, b in
            a <= b
        }
        let index = find(sorted: nums1, equalTo: target, lft: 0, rgt: nums1.count - 1)
        if (index == -1) { return index }
        
        let idx = idxMap[nums1[index]]
        return idx!
    }
    
    static func findFirst(sorted nums:[Int], equalToOrMoreThan target: Int, lft: Int, rgt: Int) -> Int {
        if nums.count == 0 { return -1 }
        if rgt < nums.count, nums[rgt] < target { return -1 }
        
        if lft >= 0, target <= nums[lft] { return lft }
        
        var l = lft, r = rgt
        var idx = -1
        while l <= r {
            let mid = (l + r) / 2
            if target <= nums[mid] {
                r = mid - 1
                idx = mid
            } else {
                l = mid + 1
            }
        }
        return idx
    }
    
    static func findFirst(sorted nums:[Int], equalToOrMoreThan target: Int, lft: Int) -> Int {
        if nums.count == 0 { return -1 }
        return findFirst(sorted: nums, equalToOrMoreThan: target, lft: lft, rgt: nums.count - 1)
    }
}
