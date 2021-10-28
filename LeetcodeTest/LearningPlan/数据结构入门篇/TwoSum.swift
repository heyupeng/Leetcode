//
//  TwoSum.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/28.
//

import UIKit

// MARK: Day 2

/// #1. 两数之和
class TwoSum: NSObject {
    /**
     给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

     你可以按任意顺序返回答案。
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        let count = nums.count
        for i in 0..<(count-1) {
            let a = nums[i]
            let b = target - a
            
            if nums.contains(b), let index = nums.lastIndex(of: b), index != i {
                return [i, index]
            }
        }
        return [];
    }
    
    func test1() -> [Int] {
        let test1 = [3,3]
//        let test2 = [-2,-1]
//        let test136 = [1,2]
        return twoSum(test1, 6)
    }
}

/// #88. 合并两个有序数组
class MergeSortedArray {
    /**
     给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。
     请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。

     注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。
     */
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if n == 0 { return }
                
        var index1 = m, index2 = n
        while index2 > 0 {
            let num1 = index1 > 0 ? nums1[index1 - 1]: -999
            let num2 = nums2[index2 - 1]
            
            if num1 > num2 {
                nums1[index1 + index2 - 1] = num1
                index1 -= 1
            } else {
                nums1[index1 + index2 - 1] = num2
                index2 -= 1
            }
        }
    }
    
    /**
     示例 1：
     输入：nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
     输出：[1,2,2,3,5,6]
     解释：需要合并 [1,2,3] 和 [2,5,6] 。
     合并结果是 [1,2,2,3,5,6] ，其中斜体加粗标注的为 nums1 中的元素。
     
     示例 2：
     输入：nums1 = [1], m = 1, nums2 = [], n = 0
     输出：[1]
     解释：需要合并 [1] 和 [] 。
     合并结果是 [1] 。
     
     示例 3：
     输入：nums1 = [0], m = 0, nums2 = [1], n = 1
     输出：[1]
     解释：需要合并的数组是 [] 和 [1] 。
     合并结果是 [1] 。
     注意，因为 m = 0 ，所以 nums1 中没有元素。nums1 中仅存的 0 仅仅是为了确保合并结果可以顺利存放到 nums1 中。

     来源：力扣（LeetCode）
     链接：https://leetcode-cn.com/problems/merge-sorted-array
    */
    /*
     执行结果：通过
     执行用时：4 ms, 在所有 Swift 提交中击败了100.00%的用户
     内存消耗：13.5 MB, 在所有 Swift 提交中击败了88.55%的用户
     通过测试用例：59 / 59
     */
    
    struct Param {
        var nums1: [Int]
        var m: Int
        var nums2: [Int]
        var n: Int
    }
    
    func test1() -> [Int] {
        var nums1 = [1,2,3,0,0,0]
        let m = 3
        let nums2 = [2,5,6]
        let n = 3
        
        merge(&nums1, m, nums2, n)
        return nums1
    }
}
