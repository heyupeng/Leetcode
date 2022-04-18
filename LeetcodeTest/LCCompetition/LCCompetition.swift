//
//  LCCompetition.swift
//  LeetcodeTest
//
//  Created by Peng on 2022/4/17.
//

import Foundation

protocol LCCompetition_289 {
    
}

extension LCSolution: LCCompetition_289 {
    
}

extension LCCompetition_289 {
    /* -- 2022-04-17 */
    
    /// #6070
    func digitSum(_ s: String, _ k: Int) -> String {
        // 18:05
        var nextS = s
        var tempS = ""
        while(nextS.count > 3) {
            var tempCount = 0
            var tempValue = 0
            for ch in nextS {
                tempCount += 1
                tempValue += Int(String(ch))!
                if tempS.count == 3 {
                    tempS.append("\(tempValue)")
                    tempCount = 0
                    tempValue = 0
                }
            }
            if tempValue != 0 {
                tempS.append("\(tempValue)")
            }
            nextS = tempS
        }
        return nextS
    }
    
    /// #6071. 完成所有任务需要的最少轮数
    ///
    /// 难度：中等
    /// 给你一个下标从 0 开始的整数数组 tasks ，其中 tasks[i] 表示任务的难度级别。在每一轮中，你可以完成 2 个或者 3 个 相同难度级别 的任务。
    ///
    /// 返回完成所有任务需要的 最少 轮数，如果无法完成所有任务，返回 -1 。
    ///
    ///     示例 1：
    ///     输入：tasks = [2,2,3,3,2,4,4,4,4,4]
    ///     输出：4
    ///     解释：要想完成所有任务，一个可能的计划是：
    ///     - 第一轮，完成难度级别为 2 的 3 个任务。
    ///     - 第二轮，完成难度级别为 3 的 2 个任务。
    ///     - 第三轮，完成难度级别为 4 的 3 个任务。
    ///     - 第四轮，完成难度级别为 4 的 2 个任务。
    ///     可以证明，无法在少于 4 轮的情况下完成所有任务，所以答案为 4 。
    ///     示例 2：
    ///     输入：tasks = [2,3,3]
    ///     输出：-1
    ///     解释：难度级别为 2 的任务只有 1 个，但每一轮执行中，只能选择完成 2 个或者 3 个相同难度级别的任务。因此，无法完成所有任务，答案为 -1 。
    ///
    /// 提示：
    ///
    ///     1 <= tasks.length <= 105
    ///     1 <= tasks[i] <= 109
    ///
    ///执行结果：
    ///
    ///     执行用时：976 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：18.4 MB, 在所有 Swift 提交中击败了100.00%的用户
    ///     通过测试用例：78 / 78
    ///
    func minimumRounds(_ tasks: [Int]) -> Int {
        //18:36 - 44
        var taskMap: [Int: Int] = [:]
        for task in tasks {
            if let cnt = taskMap[task] {
                taskMap[task] = cnt + 1
            }
            else {
                taskMap[task] = 1
            }
        }

        var round = 0
        for (_, cnt) in taskMap {
            if cnt < 2 {
                round = -1
                break
            }
            round += (cnt+2) / 3
        }
        return round
    }
    
    /// #6072. 转角路径的乘积中最多能有几个尾随零
    /// 难度：中等
    ///
    /// 给你一个二维整数数组 grid ，大小为 m x n，其中每个单元格都含一个正整数。
    ///
    /// 转角路径 定义为：包含至多一个弯的一组相邻单元。具体而言，路径应该完全 向水平方向 或者 向竖直方向 移动过弯（如果存在弯），而不能访问之前访问过的单元格。在过弯之后，路径应当完全朝 另一个 方向行进：如果之前是向水平方向，那么就应该变为向竖直方向；反之亦然。当然，同样不能访问之前已经访问过的单元格。
    ///
    /// 一条路径的 乘积 定义为：路径上所有值的乘积。
    ///
    /// 请你从 grid 中找出一条乘积中尾随零数目最多的转角路径，并返回该路径中尾随零的数目。
    ///
    /// 注意：
    ///
    ///     水平 移动是指向左或右移动。
    ///     竖直 移动是指向上或下移动。
    ///
    /// 示例
    ///
    ///     示例 1：
    ///     输入：grid = [[23,17,15,3,20],[8,1,20,27,11],[9,4,6,2,21],[40,9,1,10,6],[22,7,4,5,3]]
    ///     输出：3
    ///     解释：左侧的图展示了一条有效的转角路径。
    ///     其乘积为 15 * 20 * 6 * 1 * 10 = 18000 ，共计 3 个尾随零。
    ///     可以证明在这条转角路径的乘积中尾随零数目最多。

    ///     中间的图不是一条有效的转角路径，因为它有不止一个弯。
    ///     右侧的图也不是一条有效的转角路径，因为它需要重复访问已经访问过的单元格。
    ///
    ///     示例 2：
    ///     输入：grid = [[4,3,2],[7,6,1],[8,8,8]]
    ///     输出：0
    ///     解释：网格如上图所示。
    ///     不存在乘积含尾随零的转角路径。
    ///
    /// 提示：
    ///
    ///     m == grid.length
    ///     n == grid[i].length
    ///     1 <= m, n <= 105
    ///     1 <= m * n <= 105
    ///     1 <= grid[i][j] <= 1000
    ///
    /// 执行结果：通过
    ///     执行用时：3960 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：55.5 MB, 在所有 Swift 提交中击败了100.00%的用户
    ///     通过测试用例：54 / 54
    func maxTrailingZeros(_ grid: [[Int]]) -> Int {
        // 04/18 08:34 - 09:35
        let m = grid.count, n = grid.first?.count ?? 0
        // 10, 5, 2
        let factorys = [10, 5, 2]
        
        var params = Array(repeating: Array(repeating: Array(repeating: 0, count: 3), count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                var value = grid[i][j]
                var cnts:[Int] = []
                for factory in factorys {
                    var cnt = 0
                    while value >= factory && value % factory == 0 {
                        cnt += 1
                        value = value / factory
                    }
                    cnts.append(cnt)
                }
                params[i][j] = cnts
            }
        }
        
        func factoryCountAddFactoryCount(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            var nums: [Int] = []
            for i in 0..<nums1.count {
                nums.append(nums1[i] + nums2[i])
            }
            if nums[1] == 0, nums[2] == 0 {
                return nums
            }
            let mm = min(nums[1], nums[2])
            nums[0] += mm
            nums[1] -= mm
            nums[2] -= mm
            return nums
        }
                
        // top, left, bottom, right
        var tlbr = [[0,0,0], [0,0,0], [0,0,0], [0,0,0]]
        var dp = Array(repeating: Array(repeating: tlbr, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                tlbr = dp[i][j]
                let dictorys = [[-1, 0], [0, -1], [1, 0], [0, 1]]
                for z in 0..<2 {
                    let dict = dictorys[z]
                    var ii = i, jj = j
                    var cnts = tlbr[z]
                    ii += dict[0]
                    jj += dict[1]
                    while (ii >= 0 && ii < m && jj >= 0 && jj < n) {
                        cnts = factoryCountAddFactoryCount(dp[ii][jj][z], params[ii][jj])
                        break
                    }
                    tlbr[z] = cnts
                }
                dp[i][j] = tlbr
             }
        }
        
        for i in (0..<m).reversed() {
            for j in (0..<n).reversed() {
                tlbr = dp[i][j]
                let dictorys = [[-1, 0], [0, -1], [1, 0], [0, 1]]
                for z in 2..<4 {
                    let dict = dictorys[z]
                    var ii = i, jj = j
                    var cnts = tlbr[z]
                    ii += dict[0]
                    jj += dict[1]
                    while (ii >= 0 && ii < m && jj >= 0 && jj < n) {
                        cnts = factoryCountAddFactoryCount(dp[ii][jj][z], params[ii][jj])
                        break
                    }
                    tlbr[z] = cnts
                }
                dp[i][j] = tlbr
             }
        }
        
        var maximum = 0
        for i in (0..<m).reversed() {
            for j in (0..<n).reversed() {
                tlbr = dp[i][j]
                
                var maxValue = 0
                for x in 1..<tlbr.count {
                    for y in 0..<x {
                        let v = factoryCountAddFactoryCount(params[i][j], factoryCountAddFactoryCount(tlbr[x], tlbr[y]))
                        let c = v[0]
                        
                        maxValue = max(maxValue, c)
                    }
                }
                maximum = max(maximum, maxValue)
             }
        }
        return maximum
    }
}
