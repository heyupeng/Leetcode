//
//  Dynamic.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/28.
//

import UIKit

class Dynamic: NSObject {

    /**
     斐波那契数，通常用 F(n) 表示，形成的序列称为 斐波那契数列 。
     
     该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：
     
     F(0) = 0，F(1) = 1
     
     F(n) = F(n - 1) + F(n - 2)，其中 n > 1
     
     给你 n ，请计算 F(n) 。
     */
    func fib(_ n: Int) -> Int {
        if n < 2 { return n }
        var f0 = 0, f1 = 1
        var fn = 1
        var index = 2
        while index <= n {
            fn = f0 + f1
            f0 = f1
            f1 = fn
            index += 1
        }
        
        return fn
    }
    
    /// #1137. 第 N 个泰波那契数
    ///
    /// 泰波那契序列 Tn 定义如下：
    ///
    /// T0 = 0, T1 = 1, T2 = 1, 且在 n >= 0 的条件下 Tn+3 = Tn + Tn+1 + Tn+2
    ///
    /// 给你整数 n，请返回第 n 个泰波那契数 Tn 的值。
    /// - Parameter n: 第 N 个泰波那契数
    /// - Returns: Tn
    func tribonacci(_ n: Int) -> Int {
        if n <= 0 { return 0 }
        if n <= 2 { return 1 }
        var t0 = 0, t1 = 1, t2 = 1
        var tn = 0
        for _ in 3...n {
            tn = t0 + t1 + t2
            t0 = t1
            t1 = t2
            t2 = tn
        }
        return tn
    }
}

extension Dynamic {
    
    /// #70. 爬楼梯
    ///
    /// 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
    ///
    /// 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
    ///
    /// 注意：给定 n 是一个正整数。
    ///
    func climbStairs(_ n: Int) -> Int {
        /// 分析：n 阶楼梯可分解为 爬1阶还有n-1阶，爬2阶还有n-2阶。Fn = Fn-1 + Fn-2。即斐波那契数列。
        if (n <= 2) {return n}
        var f1 = 1, f2 = 2
        var fn = 0
        for _ in 3...n {
            fn = f1 + f2
            f1 = f2
            f2 = fn
        }
        return fn
    }
    
    /// #746. 使用最小花费爬楼梯
    ///
    /// 数组的每个下标作为一个阶梯，第 i 个阶梯对应着一个非负数的体力花费值 cost[i]（下标从 0 开始）。
    ///
    /// 每当你爬上一个阶梯你都要花费对应的体力值，一旦支付了相应的体力值，你就可以选择向上爬一个阶梯或者爬两个阶梯。
    ///
    /// 请你找出达到楼层顶部的最低花费。在开始时，你可以选择从下标为 0 或 1 的元素作为初始阶梯。
    /// - Parameter cost: <#cost description#>
    /// - Returns: <#description#>
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        if (cost.count <= 1) { return 0 }
        if (cost.count <= 2) { return min(cost[0], cost[1]) }
        
        let n = cost.count
        var cost1 = 0, cost2 = 0
        var mincost = 0
        for i in 2...n {
            mincost = min(cost1 + cost[i - 2], cost2 + cost[i - 1])
            cost1 = cost2
            cost2 = mincost
        }
        return mincost
    }
    
    struct TestParam746 {
        var cost: [Int]
        
        var ans: Int
        
        static var t252 = TestParam746(cost: [0,1,2,2], ans: 2)
        static var t255 = TestParam746(cost: [0,2,3,2], ans: 3)
        static var t263: TestParam746 {
            TestParam746(cost: [243,248,238,650,989,576,361], ans: 1474)
        }
    }
}

// MARK: 第 3 天 (-- 2021-11-11)
extension Dynamic {
    
    // MARK: #198. 打家劫舍 (数组 / 动态规划)
    
    // MARK: #213. 打家劫舍 II (数组 / 动态规划)
    
    /// #213. 打家劫舍 II
    ///
    /// 你是一个专业的小偷，计划偷窃沿街的房屋，每间房内都藏有一定的现金。这个地方所有的房屋都 围成一圈 ，这意味着第一个房屋和最后一个房屋是紧挨着的。同时，相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警 。
    ///
    /// 给定一个代表每个房屋存放金额的非负整数数组，计算你 在不触动警报装置的情况下 ，今晚能够偷窃到的最高金额。
    ///
    /// 示例 1：
    ///
    ///     输入：nums = [2,3,2]
    ///     输出：3
    ///     解释：你不能先偷窃 1 号房屋（金额 = 2），然后偷窃 3 号房屋（金额 = 2）, 因为他们是相邻的。
    /// 示例 2：
    ///
    ///     输入：nums = [1,2,3,1]
    ///     输出：4
    ///     解释：你可以先偷窃 1 号房屋（金额 = 1），然后偷窃 3 号房屋（金额 = 3）。
    ///      偷窃到的最高金额 = 1 + 3 = 4 。
    /// 示例 3：
    ///
    ///     输入：nums = [0]
    ///     输出：0
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 100
    ///     0 <= nums[i] <= 1000
    ///
    /// 链接：https://leetcode-cn.com/problems/house-robber-ii
    func robII(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        if nums.count == 1 { return nums[0] }
        if nums.count == 2 { return max(nums[0], nums[1]) }
        
        /// 房屋：[2,     3,      2]
        /// 索引：  0，   1，   2
        /// 偷窃：  2      0
        /// 不偷：  0      3
        ///
        /// 思路：
        ///
        ///            11 -> 0 -> 1
        ///        10 ->           -> 2
        ///     9 <-                   -> 3
        ///        8 <-             <-4
        ///             7 <- 6 <-5
        ///     从索引6向两边扩散，最后舍弃 0 or 11 。
        ///
//        var robs = Array(repeating: 0, count: nums.count)
//        var norobs = Array(repeating: 0, count: nums.count)
//        for i in 1..<nums.count {
//            robs[i] = (i - 1 >= 0 ? norobs[i - 1] : 0) + nums[i]
//            norobs[i] = (i - 1 >= 0 ? max(robs[i - 1], norobs[i - 1]) : 0)
//        }
//        for i in 0..<nums.count-1 {
//            robs[i] = (i - 1 >= 0 ? norobs[i - 1] : 0) + nums[i]
//            norobs[i] = (i - 1 >= 0 ? max(robs[i - 1], norobs[i - 1]) : 0)
//        }
//        return max(max(robs[nums.count-1], norobs[nums.count-1]), max(robs[nums.count-2], norobs[nums.count-2]))
        
        /* = = */
        func _robII(_ startIndex: Int, _ endIndex: Int) -> (Int, [Int]) {
            var momeys = [0, 0]
            var paths: [[Int]] = [[], []] // 记录选择路径
            
            var lastFlag = 1
            for i in startIndex..<endIndex {
                let num = nums[i]
                let flag = 1 - lastFlag
                
                if momeys[flag] + num > momeys[lastFlag] {
                    momeys[flag] = momeys[flag] + num
                    paths[flag].append(i)
                } else {
                    momeys[flag] = momeys[lastFlag]
                    paths[flag] = paths[lastFlag]
                }
                
                lastFlag = lastFlag == 1 ? 0 : 1;
            }
            
            lastFlag = momeys[0] < momeys[1] ? 1 : 0
            return (momeys[lastFlag], paths[lastFlag])
        }
        
        let (m1, _) = _robII(0, nums.count - 1)
        let (m2, _) = _robII(1, nums.count)
        
        return max(m1, m2)
    }
    
    // MARK: #740. 删除并获得点数 (数组 / 哈希表 / 动态规划) - (-- 2021-11-12)
    
    /// #740. 删除并获得点数
    ///
    /// 给你一个整数数组 nums ，你可以对它进行一些操作。
    ///
    /// 每次操作中，选择任意一个 nums[i] ，删除它并获得 nums[i] 的点数。之后，你必须删除 所有 等于 nums[i] - 1 和 nums[i] + 1 的元素。
    ///
    /// 开始你拥有 0 个点数。返回你能通过这些操作获得的最大点数。
    ///
    /// 示例 1：
    ///
    ///     输入：nums = [3,4,2]
    ///     输出：6
    ///     解释：
    ///     删除 4 获得 4 个点数，因此 3 也被删除。
    ///     之后，删除 2 获得 2 个点数。总共获得 6 个点数。
    /// 示例 2：
    ///
    ///     输入：nums = [2,2,3,3,3,4]
    ///     输出：9
    ///     解释：
    ///     删除 3 获得 3 个点数，接着要删除两个 2 和 4 。
    ///     之后，再次删除 3 获得 3 个点数，再次删除 3 获得 3 个点数。
    ///     总共获得 9 个点数。
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 2 * 10^4
    ///     1 <= nums[i] <= 10^4
    ///
    /// 链接：https://leetcode-cn.com/problems/delete-and-earn
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：24 ms, 在所有 Swift 提交中击败了84.00%的用户
    ///     内存消耗：13.5 MB, 在所有 Swift 提交中击败了80.00%的用户
    ///     通过测试用例：48 / 48
    ///
    /// - Parameter nums: 整数数组 nums
    /// - Returns:返回能通过操作获得的最大点数
    func deleteAndEarn(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        if nums.count == 1 { return nums[0] }
        
        var map: [Int: Int] = [:]
        for num in nums {
            if let counter = map[num] {
                map[num] = counter + num
            } else {
                map[num] = num
            }
        }
        
        let keys = map.keys.sorted()
        var earn0 = 0, earn1 = 0
        
        for i in keys.first!...keys.last! {
            let v = keys.contains(i) ? map[i]! : 0
            let temp = max(earn0 + v, earn1)
            earn0 = earn1
            earn1 = temp
        }
        
        /// 0.323 sec -> 0.296 sec -> 0.295 sec
        
        /// 优化1：缩短遍历次数。缺点：多个判断分支。
//        var last = map[keys.first!]! - 2
//        for key in keys {
//            let v = map[key]!
//            let distance = key - last
//
//            if distance == 1 {
//                let temp = max(earn0 + v, earn1)
//                earn0 = earn1
//                earn1 = temp
//            }
//            else if distance == 2 {
//                earn0 = max(earn0, earn1)
//                earn1 = max(earn1 + v, earn0)
//            }
//            else {
//                earn0 = max(earn0, earn1)
//                earn1 = max(earn1, earn0) + v
//            }
//
//            last = key
//        }
        
        /// 优化2：缩短遍历次数。优化 3 ms。
//        var last = map[keys.first!]! - 2
//        for key in keys {
//            let v = map[key]!
//
//            let distance = key - last
//            var time = distance > 3 ? 3: distance
//            while time > 1 {
//                let temp = max(earn0, earn1)
//                earn0 = earn1
//                earn1 = temp
//
//                time -= 1
//            }
//            last = key
//
//            let temp = max(earn0 + v, earn1)
//            earn0 = earn1
//            earn1 = temp
//        }
        
        return max(earn0, earn1)
    }
}

// MARK: 第 4 天 (2021-11-12)
extension Dynamic {
    
    // MARK: #55. 跳跃游戏 (贪心 / 数组 / 动态规划)
    
    /// #55. 跳跃游戏
    ///
    /// 给定一个非负整数数组 nums ，你最初位于数组的 第一个下标 。
    ///
    /// 数组中的每个元素代表你在该位置可以跳跃的最大长度。
    ///
    /// 判断你是否能够到达最后一个下标。
    ///
    /// 示例 1：
    ///
    ///     输入：nums = [2,3,1,1,4]
    ///     输出：true
    ///     解释：可以先跳 1 步，从下标 0 到达下标 1, 然后再从下标 1 跳 3 步到达最后一个下标。
    /// 示例 2：
    ///
    ///     输入：nums = [3,2,1,0,4]
    ///     输出：false
    ///     解释：无论怎样，总会到达下标为 3 的位置。但该下标的最大跳跃长度是 0 ， 所以永远不可能到达最后一个下标。
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 3 * 10^4
    ///     0 <= nums[i] <= 10^5
    ///
    /// 链接：https://leetcode-cn.com/problems/jump-game
    ///
    /// 执行结果：通过
    /// - Parameter nums: nums
    /// - Returns:
    func canJump(_ nums: [Int]) -> Bool {
        if nums.count <= 1 { return true }
        /*
        执行用时：1360 ms, 在所有 Swift 提交中击败了6.02%的用户
        内存消耗：15 MB, 在所有 Swift 提交中击败了5.42%的用户
        通过测试用例：166 / 166
        */
        var flag = Array(repeating: 1, count: nums.count)
        func _canJump(_ startIndex: Int) -> Bool {
            if startIndex >= nums.count {
                return true
            }
            if startIndex == nums.count - 1 {
                // 末尾 0 不计入 false
                return true
            }
            
            if nums[startIndex] == 0 {
                return false
            }
            if flag[startIndex] == 0 {
                return false
            }
            
            var step = nums[startIndex]
            print("开始递归：\(startIndex)")
            while step > 0 {
                if _canJump(startIndex + step) {
                    return true
                }
                flag[startIndex + step] = 0
                step -= 1
                
            }
            print("结束递归：\(startIndex)")
            return false
        }
        return _canJump(0)
        
        /* 记录可跳跃最远距离
         [3,2,1,0,4]
         - 一开始处于位置0，最大跳跃长度为3，最远距离为3
         - 位置1， 1 < 3，可到达，最远距离 1 + 2 = 3，
         - 位置2， 2 < 3，可到达，最远距离 2 + 1 = 3，
         - 位置3， 3 = 3，可到达，最远距离 3 + 0 = 3，
         - 位置4， 4 > 3，不可到达。
        */
        var fast = 0
        for i in 0..<nums.count {
            if i > fast {
                break
            }
            if fast >= nums.count - 1 {
                return true
            }
            fast = max(fast, i + nums[i])
        }
        
        return false
    }
}

