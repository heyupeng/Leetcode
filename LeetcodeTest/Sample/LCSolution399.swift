//
//  LCSolution.swift
//  LeetcodeTest
//
//  Created by Peng on 2022/4/13.
//

import Foundation

// MARK: #300 - #399
protocol LCSolution_399 {
    
}

extension LCSolution: LCSolution_399 {
    
}

extension LCSolution_399 {
    
    // MARK: #385. 迷你语法分析器
    /// #385. 迷你语法分析器 (-- 2022-04-15)
    ///
    /// 给定一个字符串 s 表示一个整数嵌套列表，实现一个解析它的语法分析器并返回解析的结果 NestedInteger 。
    ///
    /// 列表中的每个元素只可能是整数或整数嵌套列表
    ///
    /// 示例 1：
    ///
    ///     输入：s = "324",
    ///     输出：324
    ///     解释：你应该返回一个 NestedInteger 对象，其中只包含整数值 324。
    /// 示例 2：
    ///
    ///     输入：s = "[123,[456,[789]]]",
    ///     输出：[123,[456,[789]]]
    ///     解释：返回一个 NestedInteger 对象包含一个有两个元素的嵌套列表：
    ///     1. 一个 integer 包含值 123
    ///     2. 一个包含两个元素的嵌套列表：
    ///         i.  一个 integer 包含值 456
    ///         ii. 一个包含一个元素的嵌套列表
    ///              a. 一个 integer 包含值 789
    /// 提示：
    ///
    ///     1 <= s.length <= 5 * 104
    ///     s 由数字、方括号 "[]"、负号 '-' 、逗号 ','组成
    ///     用例保证 s 是可解析的 NestedInteger
    ///     输入中的所有值的范围是 [-106, 106]
    ///
    /// 链接：https://leetcode-cn.com/problems/mini-parser
    func deserialize(_ s: String) -> NestedInteger {
        let symbols = ["[", "-", ",", "]"]
        
        func recursion(start: String.Index) -> (NestedInteger, String.Index) {
            if start == s.endIndex { return (NestedInteger() , start) }
            let endIndex = s.endIndex
            
            let n = NestedInteger()
            let firstChar = s[Range(uncheckedBounds: (start, s.index(after: start)))]
            let isCollection = String(firstChar).elementsEqual(symbols[0])
            var startIdx = start
            
            if (!isCollection) {
                // 数组
                startIdx = s.index(after: startIdx)
                while(startIdx != endIndex) {
                    let prefix = s[Range(uncheckedBounds: (startIdx, s.index(after: startIdx)))]
                    if prefix == symbols[3] {
                        startIdx = s.index(after: startIdx)
                        break
                    }
                    if prefix == symbols[2] {
                        startIdx = s.index(after: startIdx)
                        continue
                    }
                    else if prefix == symbols[0] {
                        let (nn, idx) = recursion(start: startIdx)
                        n.add(elem:nn)
                        startIdx = idx
                        continue
                    }
                    
                    var idx = s.firstIndex(Character(symbols[2]), startIdx, endIndex)
                    if idx == nil {
                        idx = s.firstIndex(Character(symbols[3]), startIdx, endIndex)
                    }
                    if idx == nil { idx = endIndex }
                    
                    let curRange = Range(uncheckedBounds: (startIdx, idx!))
                    let subStr = s[curRange]
                    let v = Int(subStr)
                    let nn = NestedInteger()
                    nn.setInteger(value: v!)
                    n.add(elem: nn)
                    
                    startIdx = idx!
                }
            } else {
                // 数字
                while(startIdx != endIndex) {
                    var idx = s.firstIndex(Character(symbols[2]), startIdx, endIndex)
                    if idx == nil {
                        idx = s.firstIndex(Character(symbols[3]), startIdx, endIndex)
                    }
                    if idx == nil { idx = endIndex }
                    
                    let curRange = Range(uncheckedBounds: (startIdx, idx!))
                    let subStr = s[curRange]
                    if let v = Int(subStr) {
                        n.setInteger(value: v)
                    }
                    
                    startIdx = idx!
                    break
                }
            }
            return (n, startIdx)
        }
        
        let nested = recursion(start: s.startIndex)
        return nested.0
    }
    
    // MARK: #357. 统计各位数字都不同的数字个数
    /// #357. 统计各位数字都不同的数字个数
    ///
    /// 难度:中等。 (-- 2022-04-15)
    ///
    /// 给你一个整数 n ，统计并返回各位数字都不同的数字 x 的个数，其中 0 <= x < 10n 。
    ///
    ///     示例 1：
    ///     输入：n = 2
    ///     输出：91
    ///     解释：答案应为除去 11、22、33、44、55、66、77、88、99 外，在 0 ≤ x < 100 范围内的所有数字。
    ///
    ///     示例 2：
    ///     输入：n = 0
    ///     输出：1
    ///
    /// 提示：
    ///
    ///     0 <= n <= 8
    func countNumbersWithUniqueDigits(_ n: Int) -> Int {
        /* 17:10 - 15:40 */
        /*
         s0 = 1
         sn = s(n-1) + 9*A(9,n-1)
         */
        
        func A(_ m: Int, _ n: Int) -> Int {
            if m < n { return -1 }
            var num = 1
            for i in 0..<n {
                num *= (m - i)
            }
            return num
        }
        
        var sum = 0
        for digit in 0..<n {
            if digit == 0 { sum += 1}
            else { sum += 9 * A(9, digit-1) }
        }
        return sum
    }
    
    // MARK: -- 2022/04/18
    
    // MARK: #386. 字典序排数
    
    /// #386. 字典序排数
    ///
    /// 难度：中等
    ///
    /// 给你一个整数 n ，按字典序返回范围 [1, n] 内所有整数。
    ///
    /// 你必须设计一个时间复杂度为 O(n) 且使用 O(1) 额外空间的算法。
    ///
    ///     示例 1：
    ///     输入：n = 13
    ///     输出：[1,10,11,12,13,2,3,4,5,6,7,8,9]
    ///
    ///     示例 2：
    ///     输入：n = 2
    ///     输出：[1,2]
    ///
    /// 提示：
    ///
    ///     1 <= n <= 5 * 104
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：48 ms, 在所有 Swift 提交中击败了80.00%的用户
    ///     内存消耗：17.8 MB, 在所有 Swift 提交中击败了20.00%的用户
    ///     通过测试用例：26 / 26
    ///
    func lexicalOrder(_ n: Int) -> [Int] {
        // 09:54-10:28
        
        var order: [Int] = []
        func resur(_ num: Int, _ idx: Int) {
            if num > n {
                return
            }
            order.append(num)
            if num * 10 > n {
                return
            }
            for i in 0...9 {
                resur(num * 10 + i, idx)
            }
        }
        for num in 1...9 {
            resur(num, num)
        }
        return order
    }
    
    // MARK: -- 2022/04/20
    
    // MARK: #388. 文件的最长绝对路径
    
    /// #388. 文件的最长绝对路径
    ///
    ///难度：中等
    ///
    /// 假设有一个同时存储文件和目录的文件系统。下图展示了文件系统的一个示例：
    ///
    /// 这里将 dir 作为根目录中的唯一目录。dir 包含两个子目录 subdir1 和 subdir2 。subdir1 包含文件 file1.ext 和子目录 subsubdir1；subdir2 包含子目录 subsubdir2，该子目录下包含文件 file2.ext 。
    ///
    /// 在文本格式中，如下所示(⟶表示制表符)：
    ///
    ///     dir
    ///     ⟶ subdir1
    ///     ⟶ ⟶ file1.ext
    ///     ⟶ ⟶ subsubdir1
    ///     ⟶ subdir2
    ///     ⟶ ⟶ subsubdir2
    ///     ⟶ ⟶ ⟶ file2.ext
    /// 如果是代码表示，上面的文件系统可以写为 "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext" 。'\n' 和 '\t' 分别是换行符和制表符。
    ///
    /// 文件系统中的每个文件和文件夹都有一个唯一的 绝对路径 ，即必须打开才能到达文件/目录所在位置的目录顺序，所有路径用 '/' 连接。上面例子中，指向 file2.ext 的 绝对路径 是 "dir/subdir2/subsubdir2/file2.ext" 。每个目录名由字母、数字和/或空格组成，每个文件名遵循 name.extension 的格式，其中 name 和 extension由字母、数字和/或空格组成。
    ///
    /// 给定一个以上述格式表示文件系统的字符串 input ，返回文件系统中 指向 文件 的 最长绝对路径 的长度 。 如果系统中没有文件，返回 0。
    ///
    ///     示例 1：
    ///     输入：input = "dir\n\tsubdir1\n\tsubdir2\n\t\tfile.ext"
    ///     输出：20
    ///     解释：只有一个文件，绝对路径为 "dir/subdir2/file.ext" ，路径长度 20
    ///
    ///     示例 2：
    ///     输入：input = "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"
    ///     输出：32
    ///     解释：存在两个文件：
    ///     "dir/subdir1/file1.ext" ，路径长度 21
    ///     "dir/subdir2/subsubdir2/file2.ext" ，路径长度 32
    ///     返回 32 ，因为这是最长的路径
    ///
    ///     示例 3：
    ///     输入：input = "a"
    ///     输出：0
    ///     解释：不存在任何文件
    ///
    ///     示例 4：
    ///     输入：input = "file1.txt\nfile2.txt\nlongfile.txt"
    ///     输出：12
    ///     解释：根目录下有 3 个文件。
    ///     因为根目录中任何东西的绝对路径只是名称本身，所以答案是 "longfile.txt" ，路径长度为 12
    ///
    /// 提示：
    ///
    ///     1 <= input.length <= 104
    ///     input 可能包含小写或大写的英文字母，一个换行符 '\n'，一个制表符 '\t'，一个点 '.'，一个空格 ' '，和数字。
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：0 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：14.5 MB, 在所有 Swift 提交中击败了100.00%的用户
    ///     通过测试用例：26 / 26
    ///
    func lengthLongestPath(_ input: String) -> Int {
        // 00:20 - 00:40
        var longestLen = 0
        
        let components: [String] = input .components(separatedBy: CharacterSet(charactersIn: "\n"))
        
        var lens: [Int] = []
        var cmpLen = 0
        for component in components {
            var cmp = component
            var cnt = 0
            // 计算层级
            while cmp.hasPrefix("\t") {
                cnt += 1
                cmp.removeFirst()
            }
            // 定位层级
            while lens.count > 0, lens.count > cnt {
                cmpLen -= lens.removeLast()
            }
            // 计算长度
            lens.append(cmp.count)
            cmpLen += cmp.count
            if let _ = cmp.firstIndex(of: Character(".")) {
                longestLen = max(longestLen, cmpLen + lens.count - 1)
            }
        }
        return longestLen
    }
    
    /// #396. 旋转函数
    ///
    /// 难度：中等
    ///
    /// 给定一个长度为 n 的整数数组 nums 。
    ///
    /// 假设 arrk 是数组 nums 顺时针旋转 k 个位置后的数组，我们定义 nums 的 旋转函数  F 为：
    /// - F(k) = 0 * arrk[0] + 1 * arrk[1] + ... + (n - 1) * arrk[n - 1]
    ///
    /// 返回 F(0), F(1), ..., F(n-1)中的最大值 。
    ///
    /// 生成的测试用例让答案符合 32 位 整数。
    ///
    ///     示例 1:
    ///     输入: nums = [4,3,2,6]
    ///     输出: 26
    ///     解释:
    ///     F(0) = (0 * 4) + (1 * 3) + (2 * 2) + (3 * 6) = 0 + 3 + 4 + 18 = 25
    ///     F(1) = (0 * 6) + (1 * 4) + (2 * 3) + (3 * 2) = 0 + 4 + 6 + 6 = 16
    ///     F(2) = (0 * 2) + (1 * 6) + (2 * 4) + (3 * 3) = 0 + 6 + 8 + 9 = 23
    ///     F(3) = (0 * 3) + (1 * 2) + (2 * 6) + (3 * 4) = 0 + 2 + 12 + 12 = 26
    ///     所以 F(0), F(1), F(2), F(3) 中的最大值是 F(3) = 26 。
    ///
    ///     示例 2:
    ///     输入: nums = [100]
    ///     输出: 0
    ///
    /// 提示:
    /// - n == nums.length
    /// - 1 <= n <= 105
    /// - -100 <= nums[i] <= 100
    ///
    /// 链接：https://leetcode-cn.com/problems/rotate-function
    ///
    /// 执行结果：通过
    /// - 执行用时：744 ms, 在所有 Swift 提交中击败了100.00%的用户
    /// - 内存消耗：18.1 MB, 在所有 Swift 提交中击败了100.00%的用户
    /// - 通过测试用例：58 / 58
    ///
    func maxRotateFunction(_ nums: [Int]) -> Int {
        // 00:06 - 12:17
        if nums.count < 2 {
            return 0
        }
        // 1
//        func F(_ k: Int) -> Int {
//            let cnt = nums.count
//            var value = 0
//            for idx in 0..<cnt {
//                var kIdx = idx - k
//                if kIdx < 0 {
//                    kIdx += cnt
//                }
//                value += idx * nums[kIdx]
//            }
//            return value
//        }
//
//        var maximum = F(0)
//        for k in 1..<nums.count {
//            maximum = max(maximum, F(k))
//        }
//
//        return maximum
        
        /* 数学归纳
          F(0) = i * nums[i]
          F(k) = F(k-1) + sum - count * nums[count-k]
               = F(0) + k * sum - count * sum(count-k, count - 1)
               = F(0) + k * sum - count * (sum - sum(0, count-k-1)
         */
        var fk = 0, sum = 0
        let count = nums.count
        for idx in 0..<count {
            fk += idx * nums[idx]
            sum += nums[idx]
        }
        
        var maxF = fk
        for k in 1..<count {
            fk += sum - count * nums[count - k]
            maxF = max(maxF, fk)
        }
        
        return maxF
    }
    
}

// MARK: #380. O(1) 时间插入、删除和获取随机元素

/// #380. O(1) 时间插入、删除和获取随机元素   (-- 2022-04-13)
///
/// 实现RandomizedSet 类：
///
/// RandomizedSet() 初始化 RandomizedSet 对象
///
/// bool insert(int val) 当元素 val 不存在时，向集合中插入该项，并返回 true ；否则，返回 false 。
///
/// bool remove(int val) 当元素 val 存在时，从集合中移除该项，并返回 true ；否则，返回 false 。
///
/// int getRandom() 随机返回现有集合中的一项（测试用例保证调用此方法时集合中至少存在一个元素）。每个元素应该有 相同的概率 被返回。
///
/// 你必须实现类的所有函数，并满足每个函数的 平均 时间复杂度为 O(1) 。
///
/// 链接：https://leetcode-cn.com/problems/insert-delete-getrandom-o1
///
/// 执行结果：通过
///
///     执行用时：628 ms, 在所有 Swift 提交中击败了40.00%的用户
///     内存消耗：29.9 MB, 在所有 Swift 提交中击败了83.33%的用户
///     通过测试用例：19 / 19
class RandomizedSet {
    var numMap: [Int: Int] = [:]
    init() {

    }
    
    func has( _ val: Int) -> Bool {
        return numMap.contains { (key: Int, value: Int) in
            if key == val { return true}
            return false
        }
    }
    
    func insert(_ val: Int) -> Bool {
        let isHas = has(val)
        if !isHas {
            numMap[val] = val
        }
        return !isHas
    }
    
    func remove(_ val: Int) -> Bool {
        let isHas = has(val)
        if isHas {
            numMap.removeValue(forKey: val)
        }
        return isHas
    }
    
    func getRandom() -> Int {
//        let count = numMap.count
//        let random = Int.random(in: 0..<count)
//        let keys = numMap.keys
//        let v = keys[keys.index(keys.startIndex, offsetBy: random)]
        
//        let keys = Array(numMap.keys) as [Int]
//        let v = keys[random]
                
//        print("\(keys)")
        
        let randomElement = numMap.randomElement()
        let v = randomElement?.key
        return v ?? 0
    }
}
