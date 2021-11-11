//
//  AlgorithmII.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/11/10.
//

import UIKit

class AlgorithmII {

}

// MARK: 第 1 天 - 二分查找 (-- 2021-11-10)
extension AlgorithmII {
    
    // MARK: #34. 在排序数组中查找元素的第一个和最后一个位置
    
    /// #34. 在排序数组中查找元素的第一个和最后一个位置
    ///
    /// 给定一个按照升序排列的整数数组 nums，和一个目标值 target。找出给定目标值在数组中的开始位置和结束位置。
    ///
    /// 如果数组中不存在目标值 target，返回 [-1, -1]。
    ///
    /// 进阶：
    ///
    ///     你可以设计并实现时间复杂度为 O(log n) 的算法解决此问题吗？
    ///
    /// 示例 1：
    ///
    ///     输入：nums = [5,7,7,8,8,10], target = 8
    ///     输出：[3,4]
    /// 示例 2：
    ///
    ///     输入：nums = [5,7,7,8,8,10], target = 6
    ///     输出：[-1,-1]
    /// 示例 3：
    ///
    ///     输入：nums = [], target = 0
    ///     输出：[-1,-1]
    ///
    /// 提示：
    ///
    ///     0 <= nums.length <= 10^5
    ///     -10^9 <= nums[i] <= 10^9
    ///     nums 是一个非递减数组
    ///     -10^9 <= target <= 10^9
    ///
    /// 链接：https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array
    ///
    /// - Parameters:
    ///   - nums: 按照升序排列的整数数组 nums
    ///   - target: 目标值 target
    /// - Returns: 找出给定目标值在数组中的开始位置和结束位置
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count < 1 || nums[0] > target || nums[nums.count - 1] < target {
            return [-1, -1]
        }
        
        var indexRange = [-1, -1]
        
//        let index = binarySearch(nums, target)
//        if index != -1 {
//            for i in 0...index {
//                if nums[index - i] != target {
//                    break
//                }
//                indexRange[0] = index - i
//            }
//
//            for i in 0...(nums.count - 1 - index) {
//                if nums[index + i] != target {
//                    break
//                }
//                indexRange[1] = index + i
//            }
//        }
        let l = binarySearchForFirstEqualOrMore(nums, target)
        let r = binarySearchForFirstEqualOrMore(nums, target+1) - 1
        if l >= 0, l < nums.count, nums[l] == target {
            indexRange[0] = l
            indexRange[1] = r
        }
        
        return indexRange
    }
    
    func binarySearchForFirstEqualOrMore(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1
        if nums.count == 0 { return -1 }
        if nums[l] >= target { return 0 }
        if nums[r] < target { return nums.count }
        
        var res = nums.count
        while l <= r {
            let i = (l + r) / 2
            if nums[i] < target {
                l = i + 1
            } else {
                r = i - 1
                res = i
            }
        }
        return res
    }
    
    func binarySearch(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1
        if r < 0 || nums[l] > target || nums[r] < target { return -1 }
        
        while l <= r {
            let i = (l + r) / 2
            if nums[i] == target {
                return i
            }
            if nums[i] < target {
                l = i + 1
            } else {
                r = i - 1
            }
        }
        return -1
    }
    
    // MARK: #33. 搜索旋转排序数组
    
    /// #33. 搜索旋转排序数组
    ///
    /// 整数数组 nums 按升序排列，数组中的值 互不相同 。
    ///
    /// 在传递给函数之前，nums 在预先未知的某个下标 k（0 <= k < nums.length）上进行了 旋转，使数组变为 [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]（下标 从 0 开始 计数）。例如， [0,1,2,4,5,6,7] 在下标 3 处经旋转后可能变为 [4,5,6,7,0,1,2] 。
    ///
    /// 给你 旋转后 的数组 nums 和一个整数 target ，如果 nums 中存在这个目标值 target ，则返回它的下标，否则返回 -1 。
    ///
    /// 示例 1：
    ///
    ///     输入：nums = [4,5,6,7,0,1,2], target = 0
    ///     输出：4
    /// 示例 2：
    ///
    ///     输入：nums = [4,5,6,7,0,1,2], target = 3
    ///     输出：-1
    /// 示例 3：
    ///
    ///     输入：nums = [1], target = 0
    ///     输出：-1
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 5000
    ///     -10^4 <= nums[i] <= 10^4
    ///     nums 中的每个值都 独一无二
    ///     题目数据保证 nums 在预先未知的某个下标上进行了旋转
    ///     -10^4 <= target <= 10^4
    ///
    /// 进阶：你可以设计一个时间复杂度为 O(log n) 的解决方案吗？
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：12 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：13.6 MB, 在所有 Swift 提交中击败了82.14%的用户
    ///     通过测试用例：195 / 195
    ///
    /// 链接：https://leetcode-cn.com/problems/search-in-rotated-sorted-array
    /// - Parameters:
    ///   - nums: 旋转的排序数组。如：[4,5,6,7,0,1,2]。
    ///   - target: 目标值 target
    /// - Returns: 存在 target ，返回下标，否则，返回 -1
    func searchInRotatedSortedArray(_ nums: [Int], _ target: Int) -> Int {
        if nums.count == 0 { return -1 }
        
        var l = 0, r = nums.count - 1
        
        while l <= r {
            let m = (l + r) / 2
            if nums[m] == target {
                return m
            }
            if nums[l] <= nums[m] {
                if target >= nums[l], target < nums[m] {
                    r = m - 1
                }
                else if target < nums[m], target > nums[r] {
                    // 优化：增加 break 判断，减少执行时间（leetcode 16ms -> 12ms）。
                    break
                }
                else {
                    l = m + 1
                }
            } else {
                if target > nums[m], target <= nums[r] {
                    l = m + 1
                }
                else if target < nums[l], target > nums[m] {
                    break
                }
                else {
                    r = m - 1
                }
            }
        }
        return -1
    }
    
    // MARK: #74. 搜索二维矩阵 (-- 2021-11-11)
    
    /// #74. 搜索二维矩阵
    ///
    /// 编写一个高效的算法来判断 m x n 矩阵中，是否存在一个目标值。该矩阵具有如下特性：
    ///
    /// - 每行中的整数从左到右按升序排列。
    /// - 每行的第一个整数大于前一行的最后一个整数。
    ///
    /// 示例 1：
    ///
    ///     输入：matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
    ///     输出：true
    /// 示例 2：
    ///
    ///     输入：matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
    ///     输出：false
    ///
    /// 提示：
    ///
    ///     m == matrix.length
    ///     n == matrix[i].length
    ///     1 <= m, n <= 100
    ///     -10^4 <= matrix[i][j], target <= 10^4
    ///
    /// - 链接：https://leetcode-cn.com/problems/search-a-2d-matrix
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：击败了67.14%的用户
    ///     内存消耗：在所有 Swift 提交中击败了84.29%的用户
    ///     通过测试用例：133 / 133
    ///
    /// - Parameters:
    ///   - matrix: 按升序排列的矩阵 matrix
    ///   - target: target
    /// - Returns: 存在 target ，返回 true， 否则，返回 false 。
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        
//        for nums in matrix {
//            if let num = nums.last, target <= num {
//                return binarySearch(nums, target) == -1 ? false : true;
//            }
//        }
        
        // 优化： 两次二分查找
        var l = 0, r = matrix.count - 1
        if r < 0 { return false }
        var row = -1
        while l <= r {
            let i = (l + r) / 2
            if matrix[i][0] <= target {
                l = i + 1
                row = i
            } else {
                r = i - 1
            }
        }
        
        if row > -1 {
            return binarySearch(matrix[row], target) == -1 ? false : true
        }
        return false
    }
    
}

//MARK: 第 2 天 - 二分查找 (-- 2021-11-11)
extension AlgorithmII {
    
    // MARK: #153. 寻找旋转排序数组中的最小值
    
    /// #153. 寻找旋转排序数组中的最小值
    ///
    /// 已知一个长度为 n 的数组，预先按照升序排列，经由 1 到 n 次 旋转 后，得到输入数组。例如，原数组 nums = [0,1,2,4,5,6,7] /// 在变化后可能得到：
    ///
    ///     若旋转 4 次，则可以得到 [4,5,6,7,0,1,2]
    ///     若旋转 7 次，则可以得到 [0,1,2,4,5,6,7]
    /// 注意，数组 [a[0], a[1], a[2], ..., a[n-1]] 旋转一次 的结果为数组 [a[n-1], a[0], a[1], a[2], ..., a[n-2]] 。
    ///
    /// 给你一个元素值 互不相同 的数组 nums ，它原来是一个升序排列的数组，并按上述情形进行了多次旋转。请你找出并返回数组中的 最小元素 。
    ///
    /// 示例 1：
    ///
    ///     输入：nums = [3,4,5,1,2]
    ///     输出：1
    ///     解释：原数组为 [1,2,3,4,5] ，旋转 3 次得到输入数组。
    /// 示例 2：
    ///
    ///     输入：nums = [4,5,6,7,0,1,2]
    ///     输出：0
    ///     解释：原数组为 [0,1,2,4,5,6,7] ，旋转 4 次得到输入数组。
    /// 示例 3：
    ///
    ///     输入：nums = [11,13,15,17]
    ///     输出：11
    ///     解释：原数组为 [11,13,15,17] ，旋转 4 次得到输入数组。
    ///
    /// 提示：
    ///
    ///     n == nums.length
    ///     1 <= n <= 5000
    ///     -5000 <= nums[i] <= 5000
    ///     nums 中的所有整数 互不相同
    ///     nums 原来是一个升序排序的数组，并进行了 1 至 n 次旋转
    ///
    /// 链接：https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array
    ///
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：12 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：13.5 MB, 在所有 Swift 提交中击败了93.62%的用户
    ///     通过测试用例：150 / 150
    ///
    /// - Parameter nums: 一个升序排序的数组，并进行了 1 至 n 次旋转。
    /// - Returns: 返回最小值
    func findMin(_ nums: [Int]) -> Int {
        if nums.count == 0 { return -1 }
        
        var lft = 0, rgt = nums.count - 1
        var minimum = nums[0]
        
        while lft <= rgt {
            if nums[lft] <= nums[rgt] {
                minimum = min(nums[lft], minimum)
                break
            }
            
            let mid = (lft + rgt) / 2
            if nums[lft] <= nums[mid] {
                minimum = min(nums[lft], minimum)
                lft = mid + 1
            } else {
                minimum = min(nums[mid], minimum)
                rgt = mid - 1
            }
        }
        return minimum
    }
    
    // MARK: #162. 寻找峰值
    
    /// #162. 寻找峰值
    ///
    /// 峰值元素是指其值严格大于左右相邻值的元素。
    ///
    /// 给你一个整数数组 nums，找到峰值元素并返回其索引。数组可能包含多个峰值，在这种情况下，返回 任何一个峰值 所在位置即可。
    ///
    /// 你可以假设 nums[-1] = nums[n] = -∞ 。
    ///
    /// 你必须实现时间复杂度为 O(log n) 的算法来解决此问题。
    ///
    /// 示例 1：
    ///
    ///     输入：nums = [1,2,3,1]
    ///     输出：2
    ///     解释：3 是峰值元素，你的函数应该返回其索引 2。
    /// 示例 2：
    ///
    /// 输入：nums = [1,2,1,3,5,6,4]
    /// 输出：1 或 5
    /// 解释：你的函数可以返回索引 1，其峰值元素为 2；
    ///      或者返回索引 5， 其峰值元素为 6。
    ///
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 1000
    ///     -2^31 <= nums[i] <= 2^31 - 1
    ///     对于所有有效的 i 都有 nums[i] != nums[i + 1]
    ///
    /// 链接：https://leetcode-cn.com/problems/find-peak-element
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：24 ms, 在所有 Swift 提交中击败了67.00%的用户
    ///     内存消耗：13.5 MB, 在所有 Swift 提交中击败了89.00%的用户
    ///     通过测试用例：63 / 63
    ///
    /// - Parameter nums: <#nums description#>
    /// - Returns: 找到并返回峰值元素索引
    func findPeakElement(_ nums: [Int]) -> Int {
        if nums.count == 0 { return -1 }
        if nums.count == 1 { return 0 }
        
        var geater = true
        for i in 1..<nums.count {
            if nums[i] > nums[i-1] {
                geater = true
                continue
            }
            if geater == true {
                return i - 1
            }
            geater = false
        }
        return nums.count - 1
        
        /*
         迭代爬坡

         思路与算法

         俗话说「人往高处走，水往低处流」。如果我们从一个位置开始，不断地向高处走，那么最终一定可以到达一个峰值位置。

         因此，我们首先在 [0,n) 的范围内随机一个初始位置 i，随后根据 nums[i−1],nums[i],nums[i+1] 三者的关系决定向哪个方向走：

         如果 nums[i−1]<nums[i]>nums[i+1]，那么位置 i 就是峰值位置，我们可以直接返回 i 作为答案；(/\)
         如果 nums[i−1]<nums[i]<nums[i+1]，那么位置 i 处于上坡，我们需要往右走，即 i←i+1；(//)
         如果 nums[i−1]>nums[i]>nums[i+1]，那么位置 i 处于下坡，我们需要往左走，即 i←i−1；(\\)
         如果 nums[i−1]>nums[i]<nums[i+1]，那么位置 i 位于山谷，两侧都是上坡，我们可以朝任意方向走。(\/)
         如果我们规定对于最后一种情况往右走，那么当位置 i 不是峰值位置时：
            如果 nums[i]<nums[i+1]，那么我们往右走；
            如果 nums[i]>nums[i+1]，那么我们往左走。
         
         */
    }
    
}
