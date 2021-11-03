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
