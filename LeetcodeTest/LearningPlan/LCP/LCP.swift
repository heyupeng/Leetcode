//
//  LCP.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/12/3.
//

import UIKit

/// #力扣杯竞赛真题集
class LCP {
    
    // MARK: LCP 28. 采购方案 (-- 2021-12-03)
    
    /// #LCP 28. 采购方案
    ///
    /// 小力将 N 个零件的报价存于数组 nums。小力预算为 target，假定小力仅购买两个零件，要求购买零件的花费不超过预算，请问他有多少种采购方案。
    /// 注意：答案需要以 1e9 + 7 (1000000007) 为底取模，如：计算初始结果为：1000000008，请返回 1
    /// 示例 1：
    ///
    ///     输入：nums = [2,5,3,5], target = 6
    ///     输出：1
    ///     解释：预算内仅能购买 nums[0] 与 nums[2]。
    /// 示例 2：
    ///
    ///     输入：nums = [2,2,1,9], target = 10
    ///     输出：4
    ///     解释：符合预算的采购方案如下：
    ///     nums[0] + nums[1] = 4
    ///     nums[0] + nums[2] = 3
    ///     nums[1] + nums[2] = 3
    ///     nums[2] + nums[3] = 10
    ///
    /// 提示：
    ///
    ///     2 <= nums.length <= 10^5
    ///     1 <= nums[i], target <= 10^5
    ///
    /// 链接：https://leetcode-cn.com/problems/4xy4Wx
    
    func purchasePlans(_ nums: [Int], _ target: Int) -> Int {
        var news: [Int] = []
        for num in nums {
            if num >= target {
                continue
            }
            news.append(num)
        }
        
        if (news.count < 2) { return 0 }
        news = news.sorted()

        let count = news.count
        var res = 0
        for i in 0..<count-1 {
            let dis = target - news[i]
            if dis <= 0 || dis < news[i] {
                continue
            }
            
            // 二分查找减少循环操作
            let idx = BinarySearch.findLast(news, lessThanOrEqualTo:dis, i+1, count - 1)
            if idx > i { res += idx - i }
            
            // for j in i+1..<count {
            //     if news[j] <= dis {
            //         res += 1
            //     } else {
            //         break
            //     }
            // }
            
            if res >= 1000000007 {
                res -= 1000000007
            }
        }
        return res
    }
    
    // MARK: LCP 29. 乐团站位 (-- 2021-12-03)
    
    func orchestraLayout(_ num: Int, _ xPos: Int, _ yPos: Int) -> Int {
//        let offsetBys = [[0, 1], [1, 0], [0, -1], [-1, 0]]
//        var cirlce = 0
        
        var pos = [0, -1]
        var number = 0
        
        let xCir = min(xPos, num - 1 - xPos), yCir = min(yPos, num - 1 - yPos)
        let cir = min(xCir, yCir)
        for c in 0..<cir {
            let step = (num - 1) - 2 * c
            number += step * 4
        }
        // number = (number - 1) % 9 + 1
        
        pos[0] += cir
        pos[1] += cir
        
        let S = (num - 1) - 2 * cir

        if xPos == cir {
            number += yPos - cir + 1
        }
        else if yPos == num - 1 - cir {
            number += S + 1
            number += xPos - cir
        }
        else if xPos == num - 1 - cir {
            number += S + 1
            number += S
            number += (num - 1) - cir - yPos
        }
        else if yPos == cir {
            number += S + 1
            number += S
            number += S
            number += S - (xPos - cir)
        }
        
        number = (number - 1) % 9 + 1

        return number
    }
    
    // MARK: #LCP 30. 魔塔游戏 (-- 2021-12-06)
    
    /// #LCP 30. 魔塔游戏
    ///
    /// 小扣当前位于魔塔游戏第一层，共有 N 个房间，编号为 0 ~ N-1。每个房间的补血道具/怪物对于血量影响记于数组 nums，其中正数表示道具补血数值，即血量增加对应数值；负数表示怪物造成伤害值，即血量减少对应数值；0 表示房间对血量无影响。
    ///
    /// 小扣初始血量为 1，且无上限。假定小扣原计划按房间编号升序访问所有房间补血/打怪，为保证血量始终为正值，小扣需对房间访问顺序进行调整，每次仅能将一个怪物房间（负数的房间）调整至访问顺序末尾。请返回小扣最少需要调整几次，才能顺利访问所有房间。若调整顺序也无法访问完全部房间，请返回 -1。
    /// 示例 1：
    ///
    ///     输入：nums = [100,100,100,-250,-60,-140,-50,-50,100,150]
    ///     输出：1
    ///     解释：初始血量为 1。至少需要将 nums[3] 调整至访问顺序末尾以满足要求。
    /// 示例 2：
    ///
    ///     输入：nums = [-200,-300,400,0]
    ///     输出：-1
    ///     解释：调整访问顺序也无法完成全部房间的访问。
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 10^5
    ///     -10^5 <= nums[i] <= 10^5
    ///
    /// - 链接：https://leetcode-cn.com/problems/p0NxJO
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：1128 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：17.7 MB, 在所有 Swift 提交中击败了100.00%的用户
    ///     通过测试用例：51 / 51
    ///
    func magicTower(_ nums: [Int]) -> Int {
        let count = nums.count
        var blood = 0
        var idx = 0
        var newNums: [Int] = []
        var temps: [Int] = []
        while idx < count {
            newNums.append(nums[idx])
            blood += nums[idx]
            if blood <= 0, idx < count - 1, let minimum = newNums.min() {
                blood -= minimum
                temps.append(minimum)
                newNums.remove(at: newNums.firstIndex(of: minimum)!)
            }
            idx += 1
        }
        
        if blood <= 0 {
            return -1
        }
        
        for v in temps {
            blood -= v
            if blood <= 0 {
                return -1
            }
        }
        return temps.count
    }
    
    /// #LCP 31. 变换的迷宫
    ///
    /// 某解密游戏中，有一个 N*M 的迷宫，迷宫地形会随时间变化而改变，迷宫出口一直位于 (n-1,m-1) 位置。迷宫变化规律记录于 maze 中，maze[i] 表示 i 时刻迷宫的地形状态，"." 表示可通行空地，"#" 表示陷阱。
    ///
    /// 地形图初始状态记作 maze[0]，此时小力位于起点 (0,0)。此后每一时刻可选择往上、下、左、右其一方向走一步，或者停留在原地。
    /// 小力背包有以下两个魔法卷轴（卷轴使用一次后消失）：
    ///
    ///     临时消除术：将指定位置在下一个时刻变为空地；
    ///     永久消除术：将指定位置永久变为空地。
    /// 请判断在迷宫变化结束前（含最后时刻），小力能否在不经过任意陷阱的情况下到达迷宫出口呢？
    ///
    /// 注意： 输入数据保证起点和终点在所有时刻均为空地。
    ///
    /// 示例 1：
    ///
    ///     输入：maze = [[".#.","#.."],["...",".#."],[".##",".#."],["..#",".#."]]
    ///     输出：true
    ///     解释：
    /// 示例 2：
    /// 
    ///     输入：maze = [[".#.","..."],["...","..."]]
    ///     输出：false
    ///     解释：由于时间不够，小力无法到达终点逃出迷宫。
    /// 示例 3：
    ///
    ///     输入：maze = [["...","...","..."],[".##","###","##."],[".##","###","##."],[".##","###","##."],[".##","###","##."],[".##","###","##."],[".##","###","##."]]
    ///     输出：false
    ///     解释：由于道路不通，小力无法到达终点逃出迷宫。
    ///
    /// 提示：
    ///
    ///     1 <= maze.length <= 100
    ///     1 <= maze[i].length, maze[i][j].length <= 50
    ///     maze[i][j] 仅包含 "."、"#"
    ///
    /// - 链接：https://leetcode-cn.com/problems/Db3wC1
    ///
    
    
    // MARK: #LCP 33. 蓄水 (-- 2021-12-07)
    
    /// #LCP 33. 蓄水
    ///
    /// 给定 N 个无限容量且初始均空的水缸，每个水缸配有一个水桶用来打水，第 i 个水缸配备的水桶容量记作 bucket[i]。小扣有以下两种操作：
    ///
    ///     升级水桶：选择任意一个水桶，使其容量增加为 bucket[i]+1
    ///     蓄水：将全部水桶接满水，倒入各自对应的水缸
    ///     每个水缸对应最低蓄水量记作 vat[i]，返回小扣至少需要多少次操作可以完成所有水缸蓄水要求。
    /// 注意：实际蓄水量 达到或超过 最低蓄水量，即完成蓄水要求。
    ///
    /// 示例 1：
    ///
    ///     输入：bucket = [1,3], vat = [6,8]
    ///     输出：4
    ///     解释：
    ///     第 1 次操作升级 bucket[0]；
    ///     第 2 ~ 4 次操作均选择蓄水，即可完成蓄水要求。
    /// 示例 2：
    ///
    ///     输入：bucket = [9,0,1], vat = [0,2,2]
    ///     输出：3
    ///     解释：
    ///     第 1 次操作均选择升级 bucket[1]
    ///     第 2~3 次操作选择蓄水，即可完成蓄水要求。
    ///
    /// 提示：
    ///
    ///     1 <= bucket.length == vat.length <= 100
    ///     0 <= bucket[i], vat[i] <= 10^4
    ///
    /// - 链接：https://leetcode-cn.com/problems/o8SXZn
    ///
    func storeWater(_ bucket: [Int], _ vat: [Int]) -> Int {
        
        var upgradeMin = 0
        var tMax = 0
        var tMin = -1
        for i in 0..<bucket.count {
            var b = bucket[i]
            if vat[i] == 0 { continue }
            if b == 0 {
                b = 1
                upgradeMin += 1
            }

            let addital = (vat[i] % b == 0 ? 0 : 1)
            let t = vat[i] / b + addital
            tMax = max(t, tMax)
            if tMin == -1 || tMin * tMin > vat[i] {
                tMin = Int(sqrt(Double(vat[i])))
            }
        }
        print("\(upgradeMin) - \(tMax) - \(tMin)")
        if tMax < 1 { return 0 }

        var tStore = tMax
        var tUpgrade = upgradeMin

        for ts in 1...tMax {
            var tuSum = 0
            for i in 0..<bucket.count {
                let addital = (vat[i] % ts == 0 ? 0 : 1)
                let tu = vat[i] / ts + addital - bucket[i]
                tuSum += tu > 0 ? tu : 0

                if (tuSum > tStore + tUpgrade) { break }
            }
            print("\(ts) + \(tuSum) = \(tuSum + ts) <= \(tStore+tUpgrade)  = \(tStore) + \(tUpgrade) ? ")
            if ts + tuSum <= tStore + tUpgrade {
                tStore = ts
                tUpgrade = tuSum
            } else {
                // break
            }
        }

        return tStore + tUpgrade
    }
    
    // MARK: #LCP 36. 最多牌组数
    
    /// #LCP 36. 最多牌组数
    ///
    /// 麻将的游戏规则中，共有两种方式凑成「一组牌」：
    ///
    ///     顺子：三张牌面数字连续的麻将，例如 [4,5,6]
    ///     刻子：三张牌面数字相同的麻将，例如 [10,10,10]
    /// 给定若干数字作为麻将牌的数值（记作一维数组 tiles），请返回所给 tiles 最多可组成的牌组数。
    ///
    /// 注意：凑成牌组时，每张牌仅能使用一次。
    ///
    /// 示例 1：
    ///
    ///     输入：tiles = [2,2,2,3,4]
    ///     输出：1
    ///     解释：最多可以组合出 [2,2,2] 或者 [2,3,4] 其中一组牌。
    /// 示例 2：
    ///
    ///     输入：tiles = [2,2,2,3,4,1,3]
    ///     输出：2
    ///     解释：最多可以组合出 [1,2,3] 与 [2,3,4] 两组牌。
    ///
    /// 提示：
    ///
    ///     1 <= tiles.length <= 10^5
    ///     1 <= tiles[i] <= 10^9
    ///
    /// - 链接：https://leetcode-cn.com/problems/Up5XYM
    ///
    func maxGroupNumber(_ tiles: [Int]) -> Int {
        return maxGroupNumber4(tiles)
    }
    
    func maxGroupNumber3(_ tiles: [Int]) -> Int {
        if tiles.count < 2 { return 0 }
        let tiles = tiles.sorted()

        // 卡牌划分计数。[ [tile, idx, count] ]
        var tics: [[Int]] = []
        for idx in 0..<tiles.count {
            if tics.count == 0 || tics.last![0] != tiles[idx] {
                tics.append([tiles[idx], idx, 1])
            } else {
                tics[tics.count-1][2] += 1
            }
        }
        
        var dp = Array(repeating: 0, count: tiles.count + 1)

        // [tile: idx]
        var temps: [Int: Int] = [:]
        temps[tiles[0]] = 0
        temps[tiles[1]] = 1
        
        var curTicIdx = 0
        
        for idx in 1...tiles.count {
            
            if tiles[idx-1] != tics[curTicIdx][0] {
                curTicIdx += 1
            }
            
            var cnt = dp[idx - 1]
            let curIdx = idx - 1

            let tile = tiles[curIdx]
            
            if curTicIdx > 1 {
                let tic1 = tics[curTicIdx - 1]
                let tic2 = tics[curTicIdx - 2]
                
                // 第 n 张同号牌, [0, count)
                let idxn = curIdx - tics[curTicIdx][1]
                if tic1[0] == tile - 1, tic1[2] > idxn,
                   tic2[0] == tile - 2 {
                    // [t-2, t-1, t]。 如 [1,1,2,2,2,3,3]
                    let dpIdx0 = idxn > 0 ? dp[curIdx]: 0
                    let dpIdx1 = tic1[1] + tic1[2] - 1 - idxn
                    let dpIdx2 = tic2[1] + tic2[2] - 1 - idxn
                    let lastDp = max(dpIdx0, dp[dpIdx1], dp[ dpIdx2 ])
                    let c = lastDp + 1
                    cnt = max(cnt, c)
                }
            }
            
            if curIdx > 1 {
                if tile == tiles[curIdx - 1], tile == tiles[curIdx - 2] {
                    // [1,2,2,2]
                    let c = dp[idx - 3] + 1
                    cnt = max(cnt, c)
                }
                if tile == tiles[curIdx - 1] + 2, tile == tiles[curIdx - 2] {
                    // [1,2,3]
                    let c = dp[idx - 3] + 1
                    cnt = max(cnt, c)
                }
            }
            
            
            dp[idx] = cnt
        }
        print(dp)
        return dp.last!
    }
    
    func splitTilesGroups(_ tiles: [Int]) -> [ [[Int]] ] {
        // 卡牌划分计数。[ [tile, count] ]
        var group: [ [[Int]] ] = []
        var tics: [[Int]] = []
        var offsetBy = 0
        
        for idx in 0..<tiles.count {
            if let last = tics.last {
                if last[0] == tiles[idx] {
                    tics[tics.count-1][1] += 1
                    continue
                }
                offsetBy += tics.last![1]
                if last[0] + 1 < tiles[idx] {
                    group.append(tics)
                    tics = []
                }
            }
            tics.append([tiles[idx], 1])
        }
        
        if tics.count > 0 {
            group.append(tics)
        }
        
        return group
    }
    
    func maxGroupNumber4(_ tiles: [Int]) -> Int {
        /*
         执行结果：通过
         执行用时：3712 ms, 在所有 Swift 提交中击败了100.00%的用户
         内存消耗：57.3 MB, 在所有 Swift 提交中击败了100.00%的用户
         通过测试用例：72 / 72
         */
        if tiles.count < 2 { return 0 }
        let tiles = tiles.sorted()

        // 卡牌划分与计数。[ [tile, idx, count] ]
        let groups = splitTilesGroups(tiles)
        
        var maximum = 0
        for group in groups {
            maximum += maxGroupNumber4_4(group)
        }
        return maximum
    }
    
    func maxGroupNumber4_4(_ tilesGroup: [[Int]]) -> Int {
        
        var tilesGroup = tilesGroup
        let map: [Int: Int] = [:]
        var dp = Array(repeating: map, count: tilesGroup.count + 1)
        
        // (t-2, t-1, t) * i + (t, t, t) * j + t /* * k */
        func dfs(_ dpIdx: Int) -> Int {
            if dpIdx <= 0 {
                return 0
            } else if dpIdx < 3 {
                let j = tilesGroup[dpIdx - 1][1] / 3
                let cnt =  j + dfs(dpIdx - 1)
                dp[dpIdx][0 + 1000 * j] = cnt
                return cnt
            }
            
            let curTicIdx = dpIdx - 1
            let ticIdx = curTicIdx
            let maxabc = max(0, min(tilesGroup[curTicIdx][1], tilesGroup[curTicIdx - 1][1], tilesGroup[curTicIdx - 2][1]) )
            
            var maximum = 0
            var i = 0
            while ticIdx >= 0, i <= maxabc {
                let j = (tilesGroup[curTicIdx][1] - i) / 3
                
                let kv = i + 1000 * j + tilesGroup[curTicIdx - 1][1] * 1000000
                if dp[dpIdx].keys.contains(kv) {
                    let cnt = dp[dpIdx][kv]
                    maximum = max(maximum, cnt!)
                    
                    i += 1
                    continue
                }
                
                tilesGroup[curTicIdx][1] -= i
                tilesGroup[curTicIdx - 1][1] -= i
                tilesGroup[curTicIdx - 2][1] -= i
                
                let cnt = dfs(dpIdx - 1) + j + i
                dp[dpIdx][kv] = cnt
                maximum = max(maximum, cnt)
                
                tilesGroup[curTicIdx][1] += i
                tilesGroup[curTicIdx - 1][1] += i
                tilesGroup[curTicIdx - 2][1] += i
                
                i += 1
            }
            
            return maximum
        }
        
        var maximum = 0
        maximum = dfs(dp.count - 1)
        
        return maximum
    }
    
    // MARK: #LCP 37. 最小矩形面积
    
    /// 二维平面上有 N 条直线，形式为 y = kx + b，其中 k、b为整数 且 k > 0。所有直线以 [k,b] 的形式存于二维数组 lines 中，不存在重合的两条直线。两两直线之间可能存在一个交点，最多会有 C(N,2) 个交点。我们用一个平行于坐标轴的矩形覆盖所有的交点，请问这个矩形最小面积是多少。若直线之间无交点、仅有一个交点或所有交点均在同一条平行坐标轴的直线上，则返回0。
    ///
    /// 注意：返回结果是浮点数，与标准答案 绝对误差或相对误差 在 10^-4 以内的结果都被视为正确结果
    ///
    /// 示例 1：
    ///
    ///     输入：lines = [[2,3],[3,0],[4,1]]
    ///     输出：48.00000
    ///     解释：三条直线的三个交点为 (3, 9) (1, 5) 和 (-1, -3)。最小覆盖矩形左下角为 (-1, -3) 右上角为 (3,9)，面积为 48
    ///
    /// 示例 2：
    ///     输入：lines = [[1,1],[2,3]]
    ///     输出：0.00000
    ///     解释：仅有一个交点 (-2，-1）
    ///
    /// 限制：
    ///
    ///     1 <= lines.length <= 10^5 且 lines[i].length == 2
    ///     1 <= lines[0] <= 10000
    ///     -10000 <= lines[1] <= 10000
    ///     与标准答案绝对误差或相对误差在 10^-4 以内的结果都被视为正确结果
    ///
    /// - 链接：https://leetcode-cn.com/problems/zui-xiao-ju-xing-mian-ji
    func minRecSize(_ lines: [[Int]]) -> Double {
        var lines = lines.sorted { line1, line2 in
            return line1[0] < line2[0] || (line1[0] == line2[0] && line1[1] <= line2[1])
        }

        var newLines: [[Int]] = []
        var sameKCnt = 0
        for line in lines {
            if sameKCnt == 2, line[0] == newLines.last![0] {
                newLines.removeLast()
                sameKCnt -= 1
            }
            else if sameKCnt > 0, line[0] != newLines.last![0] {
                sameKCnt = 0
            }
            sameKCnt += 1
            newLines.append(line)
        }
        lines = newLines

        if lines.count < 3 { return 0.0 }
        // print(lines.count)
        // print(lines)

        var minX = Double.nan, maxX = Double.nan
        var minY = Double.nan, maxY = Double.nan

        for i in 1..<lines.count {
            let l1 = lines[i]
            for j in 0..<i {
                let l2 = lines[j]
                if l1[0] == l2[0] {
                    continue
                }

                /* 居然会增加时间 */
                // let p1 = pointsOfIntersection(l1, l2)

                var x = 0.0, y = 0.0
                x = -Double(l1[1] - l2[1]) / Double(l1[0] - l2[0])
                y =  Double(l1[0]) * x + Double(l1[1])

                if maxX.isNaN {
                    minX = x
                    maxX = x
                    minY = y
                    maxY = y
                } else {
                    minX = min(minX, x)
                    maxX = max(maxX, x)
                    minY = min(minY, y)
                    maxY = max(maxY, y)
                }
            }
        }

        if !maxX.isNaN {
            print("\(maxX) - \(minX), \(minY) - \(maxY)")
            return (maxX - minX) * (maxY - minY)
        }
        return 0.0
    }
    
}
