//
//  NextGreaterElement.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/27.
//

import UIKit

/* 496. 下一个更大元素 I
 给你两个 没有重复元素 的数组 nums1 和 nums2 ，其中nums1 是 nums2 的子集。
 请你找出 nums1 中每个元素在 nums2 中的下一个比其大的值。
 nums1 中数字 x 的下一个更大元素是指 x 在 nums2 中对应位置的右边的第一个比 x 大的元素。如果不存在，对应位置输出 -1 。
*/ /*
 示例 1:
 输入: nums1 = [4,1,2], nums2 = [1,3,4,2].
 输出: [-1,3,-1]
 解释:
     对于 num1 中的数字 4 ，你无法在第二个数组中找到下一个更大的数字，因此输出 -1 。
     对于 num1 中的数字 1 ，第二个数组中数字1右边的下一个较大数字是 3 。
     对于 num1 中的数字 2 ，第二个数组中没有下一个更大的数字，因此输出 -1 。
 
 示例 2:
 输入: nums1 = [2,4], nums2 = [1,2,3,4].
 输出: [3,-1]
 解释:
     对于 num1 中的数字 2 ，第二个数组中的下一个较大数字是 3 。
     对于 num1 中的数字 4 ，第二个数组中没有下一个更大的数字，因此输出 -1 。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/next-greater-element-i
 */
class NextGreaterElement: NSObject {
    struct Param {
        var num1: [Int]
        var num2: [Int]
    }
    
    static var test1 = Param(num1: [4,1,2], num2: [1,3,4,2])
    
    func test1() -> [Int] {
        return nextGreaterElement(Self.test1.num1, Self.test1.num2)
    }
    
    /*
     执行用时： 20 ms , 在所有 Swift 提交中击败了 86.00% 的用户
     内存消耗： 13.7 MB , 在所有 Swift 提交中击败了 62.00% 的用户
     通过测试用例：15 / 15
     */
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let n2 = nums2.count
        var greaterNums = Array(repeating: -1, count: nums1.count)
        for num in nums1 {
            if let index = nums2.firstIndex(of: num) {
                for i in (index+1)..<n2 {
                    let target = nums2[i]
                    if (target <= num) {
                        continue
                    }
                    let index1 = nums1.firstIndex(of: num)
                    greaterNums[index1!] = target
                    break
                }
            }
        }
        return greaterNums
    }
}
