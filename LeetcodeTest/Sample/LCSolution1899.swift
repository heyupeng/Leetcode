//
//  LCSolution.swift
//  LeetcodeTest
//
//  Created by Peng on 2022/4/13.
//

import Foundation

// MARK: #1600 - #1899
protocol LC_1899 {
    
}

extension LCSolution: LC_1899 {
    
}

extension LC_1899 {
    /* -- 2022-04-13 */
    
    // MARK: #1889. 装包裹的最小浪费空间
    
    /// #1889. 装包裹的最小浪费空间   (-- 2022-04-13)
    ///
    ///给你 n 个包裹，你需要把它们装在箱子里，每个箱子装一个包裹。总共有 m 个供应商提供 不同尺寸 的箱子（每个规格都有无数个箱子）。如果一个包裹的尺寸 小于等于 一个箱子的尺寸，那么这个包裹就可以放入这个箱子之中。
    ///
    /// 包裹的尺寸用一个整数数组 packages 表示，其中 packages[i] 是第 i 个包裹的尺寸。供应商用二维数组 boxes 表示，其中 boxes[j] 是第 j 个供应商提供的所有箱子尺寸的数组。
    ///
    /// 你想要选择 一个供应商 并只使用该供应商提供的箱子，使得 总浪费空间最小 。对于每个装了包裹的箱子，我们定义 浪费的 空间等于 箱子的尺寸 - 包裹的尺寸 。总浪费空间 为 所有 箱子中浪费空间的总和。
    ///
    /// 比方说，如果你想要用尺寸数组为 [4,8] 的箱子装下尺寸为 [2,3,5] 的包裹，你可以将尺寸为 2 和 3 的两个包裹装入两个尺寸为 4 的箱子中，同时把尺寸为 5 的包裹装入尺寸为 8 的箱子中。总浪费空间为 (4-2) + (4-3) + (8-5) = 6 。
    ///
    /// 请你选择 最优 箱子供应商，使得 总浪费空间最小 。如果 无法 将所有包裹放入箱子中，请你返回 -1 。由于答案可能会 很大 ，请返回它对 109 + 7 取余 的结果。
    ///
    /// 链接：https://leetcode-cn.com/problems/minimum-space-wasted-from-packaging
    ///
    func minWastedSpace(_ packages: [Int], _ boxes: [[Int]]) -> Int {

//        return minWastedSpaceAdvance(packages, boxes)

        var minWaste:Int = -1
        
        let packages = packages.sorted { a, b in
            return a < b
        }

        boxes.forEach { box in
            let boxesSorted = box.sorted { a, b in
                return a < b
            }
            
            var waste = 0
            var isContain = false
            var j = 0
            for package in packages {
                isContain = false
            #if false
                for boxesSortIdx in j..<boxesSorted.count {
                    let box = boxesSorted[boxesSortIdx]
                    if box < package {
                        continue
                    }
                    isContain = true
                    waste += box - package
                    j = boxesSortIdx
                    break
                }
            #else
                let jj = BinarySearch.findFirst(sorted: boxesSorted, equalToOrMoreThan: package, lft: j, rgt: boxesSorted.count-1)
                if jj != -1 {
                    isContain = true
                    j = jj
                    waste += boxesSorted[jj] - package
                }
            #endif
                if isContain == false {
                    waste = -1
                    break
                }
            }
            
            if isContain == true, (minWaste == -1 || minWaste > waste) {
                minWaste = waste
            }
        }
        if minWaste > Int(pow(10.0, 9) + 7) {
            minWaste = minWaste % Int(pow(10.0, 9) + 7)
        }
        return minWaste
    }
    
    /// #1889. 装包裹的最小浪费空间.
    ///
    /// 优化篇
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：1600 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：19.8 MB, 在所有 Swift 提交中击败了100.00%的用户
    ///     通过测试用例：42 / 42
    func minWastedSpaceAdvance(_ packages: [Int], _ boxes: [[Int]]) -> Int {
        
        var minWaste:Int = -1
        
        let packages = packages.sorted { a, b in
            return a < b
        }
        let packageSum = packages.reduce(0) { partialResult, package in
            partialResult + package
        }
        
        boxes.forEach { box in
            let boxesSorted = box.sorted { a, b in
                return a < b
            }
            
            var waste = 0
            var i = 0;
            var j = 0
            var crtBox = 0 // current box
            var boxSum = 0
            while (i < packages.count) {
                let package = packages[i]
                let jj = BinarySearch.findFirst(sorted: boxesSorted, equalToOrMoreThan: package, lft: j, rgt: boxesSorted.count-1)
                if jj == -1 {
                    j = -1
                    break
                }
                crtBox = boxesSorted[jj]
                let ii = BinarySearch.findLast(packages, lessThanOrEqualTo: crtBox, i, packages.count - 1)
                let count = ii - i + 1
                boxSum += crtBox * count
                i = ii + 1
                j = jj + 1
            }
            
            if (j == -1) {
                return
            }
            waste = boxSum - packageSum
            minWaste = minWaste == -1 ? waste : min(waste, minWaste)
        }
        
        if minWaste > Int(pow(10.0, 9) + 7) {
            minWaste = minWaste % Int(pow(10.0, 9) + 7)
        }
        return minWaste
    }
    
    // MARK: #1672. 最富有客户的资产总量
    /// #1672. 最富有客户的资产总量 <EASY> (-- 2022-04-14)
    ///
    ///给你一个 m x n 的整数网格 accounts ，其中 accounts[i][j] 是第 i​​​​​​​​​​​​ 位客户在第 j 家银行托管的资产数量。返回最富有客户所拥有的 资产总量 。
    ///
    /// 客户的 资产总量 就是他们在各家银行托管的资产数量之和。最富有客户就是 资产总量 最大的客户。
    ///
    /// 链接：https://leetcode-cn.com/problems/richest-customer-wealth
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：24 ms, 在所有 Swift 提交中击败了93.33%的用户
    ///     内存消耗：13.5 MB, 在所有 Swift 提交中击败了100.00%的用户
    ///     通过测试用例：34 / 34
    func maximumWealth(_ accounts: [[Int]]) -> Int {
        var maxWealth = 0
        accounts.forEach { account in
            let wealthSum = account.reduce(0) { partialResult, wealth in
                partialResult + wealth
            }
            maxWealth = max(maxWealth, wealthSum);
        }
        return maxWealth
    }
}
