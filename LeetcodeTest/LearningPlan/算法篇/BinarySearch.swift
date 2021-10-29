//
//  BinarySearch.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/28.
//

import UIKit

/// #704. 二分查找
class BinarySearch: NSObject {

    /**
     给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        var lindex = 0, rindex = nums.count - 1
        
        while lindex <= rindex {
            let index = (lindex + rindex) / 2
            
            if nums[index] == target {
                return index
            }
            else if  nums[index] > target {
                rindex = index - 1
            } else {
                lindex = index + 1
            }
        }
        return -1
    }
    
    func test1() -> Int {
        return search([-1,0,3,5,9,12],2)
    }
}

/// #278. 第一个错误的版本
class FirstBadVersion {
    /**
     第一个错误的版本
     
     你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。

     假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。

     你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
     */
    func firstBadVersion(_ n: Int) -> Int {
        var lindex = 0, rindex = n
        
        while lindex < rindex {
            let index = (lindex + rindex) / 2
            
            if isBadVersion(index) {
                rindex = index
            } else {
                lindex = index + 1
            }
        }
        return lindex
    }
    
    func isBadVersion(_ version: Int) -> Bool {
        return version >= 4
    }
    
    func test1() -> Int {
        return firstBadVersion(5)
    }
}

/// #35. 搜索插入位置
class SearchInsert {
    /**
     给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
     
     请必须使用时间复杂度为 O(log n) 的算法。
     */
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var lindex = 0, rindex = nums.count - 1
        
        while lindex <= rindex {
            let index = (lindex + rindex) / 2
            
            if nums[index] == target {
                return index
            }
            else if  nums[index] > target {
                rindex = index - 1
            } else {
                lindex = index + 1
            }
        }
        
        return lindex
    }
    func test1() -> Int {
        let nums = [1,3,5,6], target = 2
        return searchInsert(nums, target)
    }
}

// MARK: Day 2
class Algorithm {
    
}

extension Algorithm {
    /// #977. 有序数组的平方
    ///
    /// 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var res = Array(repeating: 0, count: nums.count)
        
        var lindex = 0, rindex = nums.count - 1
        for i in 0...nums.count - 1 {
            if abs(nums[lindex]) > abs(nums[rindex]) {
                res[nums.count - 1 - i] = nums[lindex] * nums[lindex]
                lindex += 1
            } else {
                res[nums.count - 1 - i] = nums[rindex] * nums[rindex]
                rindex -= 1
            }
        }
        return res
    }
}

extension Algorithm {
    /// #189. 旋转数组
    ///
    /// 给定一个数组，将数组中的元素向右移动 k 个位置，其中 k 是非负数。
    ///
    /// 进阶：
    ///
    /// 尽可能想出更多的解决方案，至少有三种不同的方法可以解决这个问题。
    ///
    /// 你可以使用空间复杂度为 O(1) 的 原地 算法解决这个问题吗？
    func rotate(_ nums: inout [Int], _ k: Int) {
        if k == 0 { return }
        
        let kk = k % nums.count
        
        // 1.
        for _ in 0..<k {
            let num = nums.removeLast()
            nums.insert(num, at: 0)
        }
        
        // 2. O(1)
        let sub1 = nums[nums.count-kk..<nums.count]
        let sub2 = nums[0..<nums.count-kk]
        nums = Array(sub1 + sub2)
    }
}

