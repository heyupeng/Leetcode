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

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

protocol Question {
    
    /// #350. 两个数组的交集 II
    ///
    /// 给定两个数组，编写一个函数来计算它们的交集。
    ///
    ///     示例 1：
    ///     输入：nums1 = [1,2,2,1], nums2 = [2,2]
    ///     输出：[2,2]
    ///
    ///     示例 2:
    ///     输入：nums1 = [4,9,5], nums2 = [9,4,9,8,4]
    ///     输出：[4,9]
    ///
    /// 说明：
    ///
    /// 输出结果中每个元素出现的次数，应与元素在两个数组中出现次数的最小值一致。
    /// 我们可以不考虑输出结果的顺序。
    ///
    /// 进阶：
    ///
    /// 如果给定的数组已经排好序呢？你将如何优化你的算法？
    ///
    /// 如果 nums1 的大小比 nums2 小很多，哪种方法更优？
    ///
    /// 如果 nums2 的元素存储在磁盘上，内存是有限的，并且你不能一次加载所有的元素到内存中，你该怎么办
    ///
    /// - 链接：https://leetcode-cn.com/problems/intersection-of-two-arrays-ii
    /// - Parameters:
    ///   - nums1: 集合1
    ///   - nums2: 集合2
    /// - Returns: 两集合的交集
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int]
    
    
    /// #121. 买卖股票的最佳时机
    ///
    /// 给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。
    ///
    /// 你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。
    ///
    /// 返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。
    ///
    /// 示例 1：
    ///
    ///     输入：[7,1,5,3,6,4]
    ///     输出：5
    ///
    ///     解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
    ///
    ///     注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
    ///
    /// 示例 2：
    ///
    ///     输入：prices = [7,6,4,3,1]
    ///     输出：0
    ///
    ///     解释：在这种情况下, 没有交易完成, 所以最大利润为 0。
    ///
    /// 提示：
    ///
    /// 1 <= prices.length <= 10^5
    ///
    /// 0 <= prices[i] <= 10^4
    ///
    /// - 链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock
    /// - Returns: <#description#>
    func maxProfit(_ prices: [Int]) -> Int
    
    
    /// #566. 重塑矩阵
    /// 在 MATLAB 中，有一个非常有用的函数 reshape ，它可以将一个 m x n 矩阵重塑为另一个大小不同（r x c）的新矩阵，但保留其原始数据。
    ///
    /// 给你一个由二维数组 mat 表示的 m x n 矩阵，以及两个正整数 r 和 c ，分别表示想要的重构的矩阵的行数和列数。
    ///
    /// 重构后的矩阵需要将原始矩阵的所有元素以相同的 行遍历顺序 填充。
    ///
    /// 如果具有给定参数的 reshape 操作是可行且合理的，则输出新的重塑矩阵；否则，输出原始矩阵。
    /// - Parameters:
    ///   - mat: 需要重构的矩阵
    ///   - r: 重构矩阵的行数
    ///   - c: 重构矩阵的行数
    /// - Returns: 重构的矩阵
    func matrixReshape(_ mat: [[Int]], _ r: Int, _ c: Int) -> [[Int]]
    
    /// #118. 杨辉三角
    ///
    /// 给定一个非负整数 numRows，生成「杨辉三角」的前 numRows 行。
    ///
    /// 在「杨辉三角」中，每个数是它左上方和右上方的数的和。
    /// 示例 1:
    ///
    ///     输入: numRows = 5
    ///     输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
    /// - Parameter numRows: <#numRows description#>
    /// - Returns: <#description#>
    func generate(_ numRows: Int) -> [[Int]]
    
    
    /// #36. 有效的数独
    ///
    /// 请你判断一个 9x9 的数独是否有效。只需要 根据以下规则 ，验证已经填入的数字是否有效即可。
    ///
    /// - 数字 1-9 在每一行只能出现一次。
    /// - 数字 1-9 在每一列只能出现一次。
    /// - 数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。（请参考示例图）
    ///
    /// 数独部分空格内已填入了数字，空白格用 '.' 表示。
    ///
    /// 注意：
    ///
    /// 一个有效的数独（部分已被填充）不一定是可解的。
    ///
    /// 只需要根据以上规则，验证已经填入的数字是否有效即可。
    /// - Parameter board: <#board description#>
    /// - Returns: <#description#>
    func isValidSudoku(_ board: [[Character]]) -> Bool
    
    /// #73. 矩阵置零
    ///
    /// 给定一个 m x n 的矩阵，如果一个元素为 0 ，则将其所在行和列的所有元素都设为 0 。请使用 原地 算法。
    ///
    /// 进阶：
    ///
    /// 一个直观的解决方案是使用  O(mn) 的额外空间，但这并不是一个好的解决方案。
    ///
    /// 一个简单的改进方案是使用 O(m + n) 的额外空间，但这仍然不是最好的解决方案。
    ///
    /// 你能想出一个仅使用常量空间的解决方案吗？
    ///
    /// - 链接：https://leetcode-cn.com/problems/set-matrix-zeroes
    /// - Parameter matrix: <#matrix description#>
    func setZeroes(_ matrix: inout [[Int]])
    
    
    /// #387. 字符串中的第一个唯一字符
    ///
    /// 给定一个字符串，找到它的第一个不重复的字符，并返回它的索引。如果不存在，则返回 -1。
    ///
    /// 示例：
    ///
    /// s = "leetcode" 返回 0
    ///
    /// s = "loveleetcode" 返回 2
    ///
    /// 提示：你可以假定该字符串只包含小写字母。
    ///
    /// - 链接：https://leetcode-cn.com/problems/first-unique-character-in-a-string
    ///
    /// 写在后面：当前解题方法为哈希表存储计数。其他方法：哈希表存储索引。
    /// - Parameter s: s description
    /// - Returns: <#description#>
    func firstUniqChar(_ s: String) -> Int
    
    
    /// #383. 赎金信
    ///
    /// 给定一个赎金信 (ransom) 字符串和一个杂志(magazine)字符串，判断第一个字符串 ransom 能不能由第二个字符串 magazines 里面的字符构成。如果可以构成，返回 true ；否则返回 false。
    ///
    /// (题目说明：为了不暴露赎金信字迹，要从杂志上搜索各个需要的字母，组成单词来表达意思。杂志字符串中的每个字符只能在赎金信字符串中使用一次。)
    ///
    /// 示例 1：
    ///
    ///     输入：ransomNote = "a", magazine = "b"
    ///     输出：false
    ///
    /// 示例 2：
    ///
    ///     输入：ransomNote = "aa", magazine = "ab"
    ///     输出：false
    ///
    /// 示例 3：
    ///
    ///     输入：ransomNote = "aa", magazine = "aab"
    ///     输出：true
    ///
    /// - 链接：https://leetcode-cn.com/problems/ransom-note
    /// - Returns: boolValue
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool
    
    
    /// #242. 有效的字母异位词
    ///
    /// 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
    ///
    /// 注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。
    ///
    /// 示例 1:
    ///
    ///     输入: s = "anagram", t = "nagaram"
    ///     输出: true
    ///
    /// 示例 2:
    ///
    ///     输入: s = "rat", t = "car"
    ///     输出: false
    ///
    /// 提示:
    ///
    ///     1 <= s.length, t.length <= 5 * 10^4
    ///     s 和 t 仅包含小写字母
    ///
    /// - 进阶: 如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
    ///
    /// - 链接：https://leetcode-cn.com/problems/valid-anagram
    /// - Returns: boolValue
    func isAnagram(_ s: String, _ t: String) -> Bool
    
    /* -- 7 -- */
    
    /// #141. 环形链表
    ///
    /// 给定一个链表，判断链表中是否有环。
    ///
    /// 如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。注意：pos 不作为参数进行传递，仅仅是为了标识链表的实际情况。
    ///
    /// 如果链表中存在环，则返回 true 。 否则，返回 false 。
    ///
    /// 进阶：
    ///
    /// 你能用 O(1)（即，常量）内存解决此问题吗？
    ///
    /// - 链接：https://leetcode-cn.com/problems/linked-list-cycle
    /// - Returns: <#description#>
    func hasCycle(_ head: ListNode?) -> Bool
    
    
    /// #21. 合并两个有序链表
    ///
    /// 将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
    ///
    /// 示例 1：
    ///
    ///     输入：l1 = [1,2,4], l2 = [1,3,4]
    ///     输出：[1,1,2,3,4,4]
    ///
    /// - 链接：https://leetcode-cn.com/problems/merge-two-sorted-lists
    /// - Returns: <#description#>
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode?
    
    /// #203. 移除链表元素
    ///
    /// 给你一个链表的头节点 head 和一个整数 val ，请你删除链表中所有满足 Node.val == val 的节点，并返回 新的头节点 。
    ///
    /// 示例 1：
    ///
    ///     输入：head = [1,2,6,3,4,5,6], val = 6
    ///     输出：[1,2,3,4,5]
    ///
    /// 示例 2：
    ///
    ///     输入：head = [], val = 1
    ///     输出：[]
    ///
    ///  示例 3：
    ///
    ///     输入：head = [7,7,7,7], val = 7
    ///     输出：[]
    ///
    /// 提示：
    ///
    ///     列表中的节点数目在范围 [0, 10^4] 内
    ///     1 <= Node.val <= 50
    ///     0 <= val <= 50
    ///
    /// - 链接：https://leetcode-cn.com/problems/remove-linked-list-elements
    /// - Parameters:
    ///     - head: 链表的头节点
    ///     - val: 移除的元素值
    /// - Returns: 新链表
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode?
    

    /// #206. 反转链表
    ///
    /// 给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
    ///
    /// 示例 1：
    ///
    ///     输入：head = [1,2,3,4,5]
    ///     输出：[5,4,3,2,1]
    /// 示例 2：
    ///
    ///     输入：head = [1,2]
    ///     输出：[2,1]
    /// 示例 3：
    ///
    ///     输入：head = []
    ///     输出：[]
    ///
    /// 提示：
    ///
    ///     链表中节点的数目范围是 [0, 5000]
    ///     -5000 <= Node.val <= 5000
    ///
    ///
    /// 进阶：链表可以选用迭代或递归方式完成反转。你能否用两种方法解决这道题？
    ///
    /// - 链接：https://leetcode-cn.com/problems/reverse-linked-list
    /// - Returns: 反转链表
    func reverseList(_ head: ListNode?) -> ListNode?
    
    
    /// #83. 删除排序链表中的重复元素
    ///
    /// 存在一个按升序排列的链表，给你这个链表的头节点 head ，请你删除所有重复的元素，使每个元素 只出现一次 。
    ///
    /// 返回同样按升序排列的结果链表。
    ///
    /// 示例 1：
    ///
    ///     输入：head = [1,1,2]
    ///     输出：[1,2]
    /// 示例 2：
    ///
    ///     输入：head = [1,1,2,3,3]
    ///     输出：[1,2,3]
    /// 提示：
    ///
    ///     - 链表中节点数目在范围 [0, 300] 内
    ///     - -100 <= Node.val <= 100
    ///     - 题目数据保证链表已经按升序排列
    ///
    /// - 链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list
    /// - Returns: <#description#>
    func deleteDuplicates(_ head: ListNode?) -> ListNode?
}

class DataStructure {
    
}

extension DataStructure:Question {

    // MARK: Day 3
    
    // #350. 两个数组的交集 II
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var newNums: [Int] = []
        
        var dict:[Int: Int] = [:]
        
        for i in nums1 {
            if let _ = dict[i] {
                dict[i]! += 1
            } else {
                dict[i] = 1
            }
        }
        
        for j in nums2 {
            if dict.keys.count == 0 {
                break
            }
            else if let c = dict[j] {
                newNums.append(j)
                if (c > 1) {
                    dict[j]! -= 1
                } else {
                    dict.removeValue(forKey: j)
                }
            }
        }
        return newNums
    }
    
    // #121. 买卖股票的最佳时机
    func maxProfit(_ prices: [Int]) -> Int {
        return 0
    }
    
    // MARK: Day 4

    // #118. 杨辉三角
    func generate(_ numRows: Int) -> [[Int]] {
        if numRows < 0 { return [] }
        var rows = Array<[Int]>()

        for i in 0..<numRows {
            var row = Array(repeating: 1, count: i + 1)
            for j in 0...i {
                if (j == 0 || j == i) {
                    row[j] = 1
                } else {
                    row[j] = rows[i-1][j-1] + rows[i-1][j]
                }
            }
            rows.append(row)
        }
        return rows
    }
    

    // #566. 重塑矩阵
    func matrixReshape(_ mat: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
        let m = mat.count
        let n = mat[0].count
        guard m * n == r * c else {
            return mat
        }
        
        // r * c 矩阵
        var newMat = Array(repeating: Array(repeating: 0, count: c), count: r)
        
        var index = 0
        var r1 = 0, c1 = 0
        var r2 = 0, c2 = 0

        while (index < m * n) {
            newMat[r2][c2] = mat[r1][c1]
            
            index += 1
            c1 += 1
            if (c1 == n) { c1 = 0; r1 += 1 }
            
            c2 += 1
            if (c2 == c) { c2 = 0; r2 += 1 }
        }
        return newMat
    }
    
// MARK: Day 5.
    
    // #36. 有效的数独
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        for i in 0..<3 {
            for j in 0..<3 {
                let x = 3 * i + j, y = 3 * j + i
                
                // h
                var hash: [Character: Int] = [:]
                for z in 0..<9 {
                    let ch = board[x][z]
                    if ch >= "0", ch <= "9", hash.keys.contains(ch) {
                        return false
                    }
                    hash[ch] = z
                }
                // v
                hash.removeAll()
                for z in 0..<9 {
                    let ch = board[z][y]
                    if ch >= "0", ch <= "9", hash.keys.contains(ch) {
                        return false
                    }
                    hash[ch] = z
                }
                // gird
                hash.removeAll()
                for s in 0..<3 {
                    for t in 0..<3 {
                        let ch = board[3 * i + s][3 * j + t]
                        if ch >= "0", ch <= "9", hash.keys.contains(ch) {
                            return false
                        }
                        hash[ch] = s * 3 + t
                    }
                }
            }
        }
        return true
    }
    
    
    // #73. 矩阵置零
    func setZeroes(_ matrix: inout [[Int]]) {
        
        let m = matrix.count
        let n = matrix[0].count
        
        /// O(m + n)
        var rows = Array(repeating: 1, count: m)
        var cols = Array(repeating: 1, count: n)
        
        for i in 0..<m {
            for j in 0..<n {
                if matrix[i][j] == 0 {
                    rows[i] = 0
                    cols[j] = 0
                }
            }
        }
        
        for i in 0..<m {
            for j in 0..<n {
                if matrix[i][j] != 0, (rows[i] == 0 || cols[j] == 0) {
                    matrix[i][j] = 0
                }
            }
        }
        
        /// O(1)
    }
    
// MARK: Day 6.
    
    // #387. 字符串中的第一个唯一字符
    func firstUniqChar(_ s: String) -> Int {
        var dict: [Character:Int] = [:]
        
        for ch in s {
            if let c = dict[ch] {
                dict[ch] =  c + 1
            } else {
                dict[ch] = 1
            }
            
        }
        
        for ch in s {
            if let c = dict[ch], c == 1 {
                return s.firstIndex(of: ch)!.utf16Offset(in: s)
            }
            
        }
        
        /**
         */
        return -1
    }
    
    // #383. 赎金信
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
       
//        var dict1: [Character:Int] = [:]
//        var dict2: [Character:Int] = [:]
//
//        for ch in ransomNote {
//            if let c = dict1[ch] {
//                dict1[ch] =  c + 1
//            } else {
//                dict1[ch] = 1
//            }
//        }
//
//        for ch in magazine {
//            if let c = dict2[ch] {
//                dict2[ch] =  c + 1
//            } else {
//                dict2[ch] = 1
//            }
//        }
//
//        for key in dict1.keys {
//            if let c1 = dict1[key], let c2 = dict2[key], c1 <= c2 {
//
//            } else {
//                return false
//            }
//        }
        
        // 数组替代哈希表查找，缩短执行时间
        var counter = Array(repeating: 0, count: 128)
        for ch in ransomNote {
            let v = ch.asciiValue
            counter[Int(v!)] += 1
        }
        
        for ch in magazine {
            let v = ch.asciiValue
            counter[Int(v!)] -= 1
        }
        
        for value in counter {
            if value > 0 {
                return false
            }
        }
        
        return true
    }
    
    // #242. 有效的字母异位词
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count { return false }
        
        // 数组替代哈希表查找，缩短执行时间
        var counter = Array(repeating: 0, count: 128)
        for ch in s {
            let v = ch.asciiValue
            counter[Int(v!)] += 1
        }
        
        for ch in t {
            let v = ch.asciiValue
            counter[Int(v!)] -= 1
        }
        
        for value in counter {
            if value != 0 {
                return false
            }
        }
        
        return true
    }
    
    // MARK: Day 7
    func hasCycle(_ head: ListNode?) -> Bool {
        return false
    }
    
    func testHasCycle() -> Bool {
        let head = [3,2,0,-4], pos = 1
        let node = ListNode(0)
        var current = node
        for i in 0..<head.count {
            if i == 0 {
                current.val = head[i]
            } else {
                let n = ListNode(head[i])
                current.next = n
                current = n
            }
        }
        
        var index = 0
        var lNode = node
        while (pos >= 0 && index <= pos) {
            if index == pos {
                current.next = lNode
                break
            }
            index += 1
            lNode = node.next!
        }
        
        return hasCycle(node)
    }
    
    // #21. 合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 迭代
//        var next1 = l1
//        guard next1 != nil else { return l2 }
//
//        var next2 = l2
//        guard next2 != nil else { return l1 }
//
//        var l: ListNode? = nil
//        var current: ListNode!
//        while (next1 != nil || next2 != nil) {
//            var flag = 1
//            if let lll1 = next1, let lll2 = next2 {
//                if lll2.val < lll1.val {
//                    flag = 2
//                }
//            } else if let _ = next2 {
//                flag = 2
//            }
//
//            var min = next1
//            if flag == 2 {
//                min = next2
//                next2 = next2?.next
//            } else {
//                next1 = next1?.next
//            }
//
//            if l == nil {
//                l = min
//                current = l
//            } else {
//                current.next = min
//                current = current.next
//            }
//        }
//        return l
        
        // 递归
        if l1 == nil {
            return l2
        }
        else if l2 == nil {
            return l1
        }
        else if l1!.val < l2!.val {
            l1?.next = mergeTwoLists(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists(l1, l2?.next)
            return l2
        }
    }
    
    func testMergeTwoLists() {
        let l1 = [1,2,4], l2 = [1,3,4]
        
        let node1 = ListNode(0)
        let node2 = ListNode(0)
        var current = node1
        for i in 0..<l1.count {
            if i == 0 {
                current.val = l1[i]
            } else {
                let n = ListNode(l1[i])
                current.next = n
                current = n
            }
        }
        
        current = node2
        for i in 0..<l2.count {
            if i == 0 {
                current.val = l2[i]
            } else {
                let n = ListNode(l2[i])
                current.next = n
                current = n
            }
        }
        
        mergeTwoLists(node1, node2)
    }
    
    
    // #203. 移除链表元素
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        if head == nil { return nil }
        if head?.val == val {
            return removeElements(head?.next, val)
        } else {
            head?.next = removeElements(head?.next, val)
        }
        
        return head
    }
    
    func testRemoveElements() {
        let head = [1,2,6,3,4,5,6], val = 6
        
        let node1 = ListNode(0)
        var current = node1
        for i in 0..<head.count {
            if i == 0 {
                current.val = head[i]
            } else {
                let n = ListNode(head[i])
                current.next = n
                current = n
            }
        }
        
        removeElements(node1, val)
    }
    
    // MARK: Day 8
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        if let next = head?.next {
            let nn = reverseList(head?.next)
            next.next = head
            head?.next = nil
            return nn
        }
        
        return head
    }
    
    func testReverseList() {
        let head = [1,2,3,4,5]
        
        let node1 = ListNode(0)
        var current = node1
        for i in 0..<head.count {
            if i == 0 {
                current.val = head[i]
            } else {
                let n = ListNode(head[i])
                current.next = n
                current = n
            }
        }
        
        let l = reverseList(node1)
        print(l)
    }
    
    // # 83. 删除排序链表中的重复元素
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        
        var last:ListNode?
        var next = head
        var dict: [Int: Int] = [:]
        while next != nil {
            if let _ = dict[next!.val] {
                last?.next = nil
            } else {
                dict[next!.val] = 1
                last?.next = next
                last = next
            }
            next = next?.next
        }
        return head
    }
    
    func testDeleteDuplicates() {
        let head = [1,1,2,3,3]
        
        let node1 = ListNode(0)
        var current = node1
        for i in 0..<head.count {
            if i == 0 {
                current.val = head[i]
            } else {
                let n = ListNode(head[i])
                current.next = n
                current = n
            }
        }
        
        let l = deleteDuplicates(node1)
//        print(l)
    }
}

extension DataStructure {
    
    // MARK: #20. 有效的括号
    
    /// #20. 有效的括号
    ///
    /// 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。
    ///
    /// 有效字符串需满足：
    ///
    ///     左括号必须用相同类型的右括号闭合。
    ///     左括号必须以正确的顺序闭合。
    ///
    /// 示例 1：
    ///
    ///     输入：s = "()"
    ///     输出：true
    /// 示例 2：
    ///
    ///     输入：s = "()[]{}"
    ///     输出：true
    /// 示例 3：
    ///
    ///     输入：s = "(]"
    ///     输出：false
    /// 示例 4：
    ///
    ///     输入：s = "([)]"
    ///     输出：false
    /// 示例 5：
    ///
    ///     输入：s = "{[]}"
    ///     输出：true
    ///
    /// 提示：
    ///
    ///     1 <= s.length <= 104
    ///     s 仅由括号 '()[]{}' 组成
    ///
    /// - 链接：https://leetcode-cn.com/problems/valid-parentheses
    ///
    func isValid(_ s: String) -> Bool {
        let sets: [String.Element: String.Element] = [")": "(", "[": "]", "}": "{"]
                
        var s1 = ""
        for ch in s {
            
            if ch == "(" || ch == "{" || ch == "[" {
                s1.append(ch)
            }
            else if let ch1 = s1.last, let ch2 = sets[ch], ch1 == ch2 {
                s1.removeLast()
            }
            else {
                s1.append(ch)
                break
            }
        }
        
        return s1.count == 0
    }
    
    // MARK: #232. 用栈实现队列
    
    /// #232. 用栈实现队列
    class MyQueue {
        private var list: [Int] = []
        init() {
            
        }
        
        func push(_ x: Int) {
            list.append(x)
        }
        
        func pop() -> Int {
            list.removeFirst()
        }
        
        func peek() -> Int {
            return list[0]
        }
        
        func empty() -> Bool {
            return list.count == 0
        }
    }
}

/**
 * Definition for a binary tree node.
 */
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

// MARK: 第 10 天 - 树 (-- 2021-12-13)
extension DataStructure {
    
    // MARK: #144. 二叉树的前序遍历
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil { return []}
        var values: [Int] = []
        values.append(root!.val)
        values.append(contentsOf: preorderTraversal(root?.left))
        values.append(contentsOf: preorderTraversal(root?.right))
        return values
    }
    
    // MARK: #94. 二叉树的中序遍历
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil { return []}
        var values: [Int] = []
        values.append(contentsOf: inorderTraversal(root?.left))
        values.append(root!.val)
        values.append(contentsOf: inorderTraversal(root?.right))
        return values
    }
    
    // MARK: #145. 二叉树的后序遍历
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil { return []}
        var values: [Int] = []
        values.append(contentsOf: postorderTraversal(root?.left))
        values.append(contentsOf: postorderTraversal(root?.right))
        values.append(root!.val)
        return values
    }
}

// MARK: 第 11 天 - 树 (-- 2021-12-13)
extension DataStructure {
    // MARK: #102. 二叉树的层序遍历
    
    /// #102. 二叉树的层序遍历
    ///
    ///给你一个二叉树，请你返回其按 层序遍历 得到的节点值。 （即逐层地，从左到右访问所有节点）。
    ///
    /// 示例：
    ///
    ///     二叉树：[3,9,20,null,null,15,7],
    ///
    ///       3
    ///      / \
    ///     9  20
    ///       /  \
    ///      15   7
    ///     返回其层序遍历结果：
    ///     [
    ///       [3],
    ///       [9,20],
    ///       [15,7]
    ///     ]
    ///
    /// - 链接：https://leetcode-cn.com/problems/binary-tree-level-order-traversal
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：8 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：13.7 MB, 在所有 Swift 提交中击败了80.85%的用户
    ///     通过测试用例：34 / 34
    ///
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil { return [] }
        
        func nextLevelTrees(_ trees: [TreeNode]) -> [TreeNode] {
            var nexts: [TreeNode] = []
            for tree in trees {
                if tree.left != nil {
                    nexts.append(tree.left!)
                }
                if tree.right != nil {
                    nexts.append(tree.right!)
                }
            }
            return nexts
        }

        var levelValues: [[Int]] = []
        var trees: [TreeNode] = [root!]
        while trees.count > 0 {
            var values: [Int] = []
            for tree in trees {
                values.append(tree.val)
            }
            levelValues.append(values)
            trees = nextLevelTrees(trees)
        }
        
        return levelValues
    }
    
    // MARK: #104. 二叉树的最大深度
    
    /// #104. 二叉树的最大深度
    ///
    /// 给定一个二叉树，找出其最大深度。
    ///
    /// 二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。
    ///
    /// 说明: 叶子节点是指没有子节点的节点。
    ///
    /// 示例：
    ///
    ///     给定二叉树 [3,9,20,null,null,15,7]，
    ///
    ///     3
    ///    / \
    ///   9  20
    ///     /  \
    ///    15   7
    /// 返回它的最大深度 3 。
    ///
    /// - 链接：https://leetcode-cn.com/problems/maximum-depth-of-binary-tree
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：20 ms, 在所有 Swift 提交中击败了99.66%的用户
    ///     内存消耗：13.8 MB, 在所有 Swift 提交中击败了98.32%的用户
    ///     通过测试用例：39 / 39
    ///
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    // MARK: #101. 对称二叉树
    
    /// #101. 对称二叉树
    ///
    /// 给定一个二叉树，检查它是否是镜像对称的。
    /// 
    /// 例如，二叉树 [1,2,2,3,4,4,3] 是对称的。
    ///
    ///         1
    ///        / \
    ///       2   2
    ///      / \ / \
    ///     3  4 4  3
    ///
    ///     但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:
    ///
    ///        1
    ///       / \
    ///      2   2
    ///       \   \
    ///       3    3
    ///
    ///
    /// 进阶：
    ///
    ///     你可以运用递归和迭代两种方法解决这个问题吗？
    ///
    /// - 链接：https://leetcode-cn.com/problems/symmetric-tree
    ///
    func isSymmetric(_ root: TreeNode?) -> Bool {

        func _isSymmetric(_ l: TreeNode?, _ r: TreeNode?) -> Bool {
            if l == nil && r == nil { return true }
            if l == nil || r == nil || l!.val != r!.val { return false }
            return _isSymmetric(l!.left, r!.right) && _isSymmetric(l!.right, r!.left)
        }
        return _isSymmetric(root?.left, root?.right)
    }
}
