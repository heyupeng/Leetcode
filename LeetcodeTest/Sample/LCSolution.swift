//
//  LCSolution.swift
//  LeetcodeTest
//
//  Created by Peng on 2022/4/13.
//

import Foundation

class LCSolution {
    
}

// MARK: #1 - #99

protocol LCSolution99 {
    
}

extension LCSolution: LCSolution99 {

}

extension LCSolution99 {
    /* -- 2022-04-15 */
    
    // MARK: #6. Z 字形变换
    
    /// #6. Z 字形变换
    ///
    /// 难度:中等
    ///
    /// 将一个给定字符串 s 根据给定的行数 numRows ，以从上往下、从左到右进行 Z 字形排列。
    ///
    /// 比如输入字符串为 "PAYPALISHIRING" 行数为 3 时，排列如下：
    ///
    ///     P   A   H   N
    ///     A P L S I I G
    ///     Y   I   R
    /// 之后，你的输出需要从左往右逐行读取，产生出一个新的字符串，比如："PAHNAPLSIIGYIR"。
    ///
    /// 请你实现这个将字符串进行指定行数变换的函数：
    ///
    /// string convert(string s, int numRows);
    ///
    ///     示例 1：
    ///     输入：s = "PAYPALISHIRING", numRows = 3
    ///     输出："PAHNAPLSIIGYIR"
    ///
    ///     示例 2：
    ///     输入：s = "PAYPALISHIRING", numRows = 4
    ///     输出："PINALSIGYAHRPI"
    ///     解释：
    ///     P     I    N
    ///     A   L S  I G
    ///     Y A   H R
    ///     P     I
    ///
    ///     示例 3：
    ///     输入：s = "A", numRows = 1
    ///     输出："A"
    ///
    /// 提示：
    ///
    ///     1 <= s.length <= 1000
    ///     s 由英文字母（小写和大写）、',' 和 '.' 组成
    ///     1 <= numRows <= 1000
    func convert(_ s: String, _ numRows: Int) -> String {
        if s.count <= numRows || numRows == 1 {
            return s
        }
        /* ↓↗︎↓↗︎ */
        var rows = Array(repeating: String(), count: numRows)
        var index = s.startIndex
        var idx = 0
        var flag = 1
        while (index != s.endIndex) {
            rows[idx].append(String(s[index]))
            
            index = s.index(after: index)
            idx += flag
            if idx == numRows - 1 ||
                idx == 0
            {
                flag *= -1
            }
        }
        
        return rows.joined()
    }
    
    /* -- 2022-04-17 */
    
    // MARK: #7. 整数反转
    
    /// #7. 整数反转
    ///
    /// 难度：中等
    ///
    /// 给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。
    ///
    /// 如果反转后整数超过 32 位的有符号整数的范围 [−2^31,  2^31 − 1] ，就返回 0。
    ///
    /// 假设环境不允许存储 64 位整数（有符号或无符号）。
    ///
    ///     示例 1：
    ///     输入：x = 123
    ///     输出：321
    ///
    ///     示例 2：
    ///     输入：x = -123
    ///     输出：-321
    ///     
    ///     示例 3：
    ///     输入：x = 120
    ///     输出：21
    ///
    ///     示例 4：
    ///     输入：x = 0
    ///     输出：0
    ///
    /// 提示：
    ///
    ///     -2^31 <= x <= 2^31 - 1
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：0 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：13.4 MB, 在所有 Swift 提交中击败了62.89%的用户
    ///     通过测试用例：1032 / 1032
    func reverse(_ x: Int) -> Int {
        // 19:06 -- 19:26
        let negative = x & 0x8000
        var value = x
        var num = 0
        
        while value != 0 {
            let r = value % 10
            num = num * 10 + r
            value /= 10
        }
        if negative == 1 {
            num *= -1
        }
        
        if num > 0x7fffffff || num < -0x80000000 {
            return 0
        }
        
        return num
    }
    
    // MARK: #8. 字符串转换整数 (atoi)
    
    /// #8. 字符串转换整数 (atoi)
    ///
    /// 难度：中等
    ///
    /// 请你来实现一个 myAtoi(string s) 函数，使其能将字符串转换成一个 32 位有符号整数（类似 C/C++ 中的 atoi 函数）。
    ///
    /// 函数 myAtoi(string s) 的算法如下：
    ///
    ///     读入字符串并丢弃无用的前导空格
    ///     检查下一个字符（假设还未到字符末尾）为正还是负号，读取该字符（如果有）。 确定最终结果是负数还是正数。 如果两者都不存在，则假定结果为正。
    ///     读入下一个字符，直到到达下一个非数字字符或到达输入的结尾。字符串的其余部分将被忽略。
    ///     将前面步骤读入的这些数字转换为整数（即，"123" -> 123， "0032" -> 32）。如果没有读入数字，则整数为 0 。必要时更改符号（从步骤 2 开始）。
    ///     如果整数数超过 32 位有符号整数范围 [−231,  231 − 1] ，需要截断这个整数，使其保持在这个范围内。具体来说，小于 −231 的整数应该被固定为 −231 ，大于 231 − 1 的整数应该被固定为 231 − 1 。
    ///     返回整数作为最终结果。
    /// 注意：
    ///
    ///     本题中的空白字符只包括空格字符 ' ' 。
    ///     除前导空格或数字后的其余字符串外，请勿忽略 任何其他字符。
    ///
    /// 示例
    ///
    ///     示例 1：
    ///     输入：s = "42"
    ///     输出：42
    ///     解释：加粗的字符串为已经读入的字符，插入符号是当前读取的字符。
    ///     第 1 步："42"（当前没有读入字符，因为没有前导空格）
    ///              ^
    ///     第 2 步："42"（当前没有读入字符，因为这里不存在 '-' 或者 '+'）
    ///              ^
    ///     第 3 步："42"（读入 "42"）
    ///                ^
    ///     解析得到整数 42 。
    ///     由于 "42" 在范围 [-231, 231 - 1] 内，最终结果为 42 。
    ///
    ///     示例 2：
    ///     输入：s = "   -42"
    ///     输出：-42
    ///     解释：
    ///     第 1 步："   -42"（读入前导空格，但忽视掉）
    ///             ^
    ///     第 2 步："   -42"（读入 '-' 字符，所以结果应该是负数）
    ///              ^
    ///     第 3 步："   -42"（读入 "42"）
    ///               ^
    ///     解析得到整数 -42 。
    ///     由于 "-42" 在范围 [-231, 231 - 1] 内，最终结果为 -42 。
    ///
    ///     示例 3：
    ///     输入：s = "4193 with words"
    ///     输出：4193
    ///     解释：
    ///     第 1 步："4193 with words"（当前没有读入字符，因为没有前导空格）
    ///              ^
    ///     第 2 步："4193 with words"（当前没有读入字符，因为这里不存在 '-' 或者 '+'）
    ///              ^
    ///     第 3 步："4193 with words"（读入 "4193"；由于下一个字符不是一个数字，所以读入停止）
    ///                  ^
    ///     解析得到整数 4193 。
    ///     由于 "4193" 在范围 [-231, 231 - 1] 内，最终结果为 4193 。
    ///
    /// 提示：
    ///
    ///     0 <= s.length <= 200
    ///     s 由英文字母（大写和小写）、数字（0-9）、' '、'+'、'-' 和 '.' 组成
    func myAtoi(_ s: String) -> Int {
        var num: Int = 0
        var signed = 1
        var hasSigned = false
        var hasNum = false
        
        let minimum = -0x80000000, maximum = 0x7fffffff
        
        for ch in s {
            if (ch.isWhitespace) && !hasSigned && !hasNum {
                continue
            }
            if ch.isLetter || ch == Character("."){
                break
            }

            if (hasNum || hasSigned) && !isNumCharacter(ch) {
                break
            }

            if isSignedCharacter(ch) {
                signed = signedCharacterIntValue(ch)
                hasSigned = true
                continue
            }
            if isNumCharacter(ch) {
                num *= 10
                num += numCharacterIntValue(ch)
                hasNum = true
                
                let value = num * signed;
                if value < minimum {
                    return minimum
                }
                else if value > maximum {
                    return maximum
                }
            }
        }
        
        let value = num * signed;
        return value
    }
    
    // "+", "-"
    func isSignedCharacter(_ c: Character) -> Bool {
        let signedSymbols = [Character("+"), Character("-")]
        let index = signedSymbols .firstIndex(of: c)
        if let _ = index {
            return true
        }
        return false
    }
    func signedCharacterIntValue(_ c: Character) -> Int {
        let signedSymbolValues = [Character("+"): 1, Character("-"): -1]
        if let value = signedSymbolValues[c] {
            return value
        }
        return 0
    }
    
    // 0-9
    func isNumCharacter(_ c: Character) -> Bool {
        let asciiValue0 = Character("0").asciiValue!
        if !c.isASCII || c.asciiValue! < asciiValue0 || c.asciiValue! - asciiValue0 > 9 {
            return false
        }
        return true
    }
    func numCharacterIntValue(_ c: Character) -> Int {
        if !c.isASCII {
            return -1
        }
        let asciiValue0 = Character("0").asciiValue!
        let value = c.asciiValue! - asciiValue0
        if  value < 0 || value > 9 {
            return -1
        }
        return Int(value)
    }
    
    // MARK: #9. 回文数
    
    /// #9. 回文数
    /// 给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。
    ///
    /// 回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。
    ///
    ///     例如，121 是回文，而 123 不是。
    ///
    ///     示例 1：
    ///     输入：x = 121
    ///     输出：true
    ///
    ///     示例 2：
    ///     输入：x = -121
    ///     输出：false
    ///     解释：从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
    ///
    ///     示例 3：
    ///     输入：x = 10
    ///     输出：false
    ///     解释：从右向左读, 为 01 。因此它不是一个回文数。
    ///
    /// 提示：
    ///     -2^31 <= x <= 2^31 - 1
    ///
    /// 链接：https://leetcode-cn.com/problems/palindrome-number
    func isPalindrome(_ x: Int) -> Bool {
        return isPalindrome3(x)
    }
    
    /** 3
     执行用时：16 ms, 在所有 Swift 提交中击败了98.51%的用户
     内存消耗：13.6 MB, 在所有 Swift 提交中击败了89.55%的用户
     通过测试用例：11510 / 11510
     */
    func isPalindrome3(_ x: Int) -> Bool {
        if x < 0 { return false }
        if x == 0 { return true }
        if x % 10 == 0 { return false }
        
        var num = x
        var numReverse = 0
        while (num != 0) {
            numReverse *= 10
            numReverse += num % 10
            num /= 10
        }
        return numReverse == x
    }
    
    func isPalindrome2(_ x: Int) -> Bool {
        if x < 0 { return false }
        if x == 0 { return true }
        if x % 10 == 0 { return false }
        
        /* way 2 */
        var value = x
        var nums:[Int] = []
        while (value != 0) {
            nums.append(value % 10)
            value /= 10
        }
        
        let count = nums.count
        for i in 0..<count/2 {
            if nums[i] != nums[count-1 - i] {
                return false
            }
        }
        return true
    }
    
    func isPalindrome1(_ x: Int) -> Bool {
        if x < 0 { return false }
        if x == 0 { return true }
        if x % 10 == 0 { return false }
        
        /* way 1 */
        let str = String(x)
        if (!str.elementsEqual(String(str.reversed()))) {
            return false
        }
        return true
    }
    
    // MARK: #10. 正则表达式匹配
    
    /// #10. 正则表达式匹配
    ///
    /// 难度：困难
    ///
    /// 给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
    ///
    ///     '.' 匹配任意单个字符
    ///     '*' 匹配零个或多个前面的那一个元素
    ///     所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。
    ///
    /// 示例
    ///
    ///     示例 1：
    ///     输入：s = "aa", p = "a"
    ///     输出：false
    ///     解释："a" 无法匹配 "aa" 整个字符串。
    ///
    ///     示例 2:
    ///     输入：s = "aa", p = "a*"
    ///     输出：true
    ///     解释：因为 '*' 代表可以匹配零个或多个前面的那一个元素, 在这里前面的元素就是 'a'。因此，字符串 "aa" 可被视为 'a' 重复了一次。
    ///
    ///     示例 3：
    ///     输入：s = "ab", p = ".*"
    ///     输出：true
    ///     解释：".*" 表示可匹配零个或多个（'*'）任意字符（'.'）。
    ///
    /// 提示：
    ///
    ///     1 <= s.length <= 20
    ///     1 <= p.length <= 30
    ///     s 只包含从 a-z 的小写字母。
    ///     p 只包含从 a-z 的小写字母，以及字符 . 和 *。
    ///     保证每次出现字符 * 时，前面都匹配到有效的字符
    func isMatch(_ s: String, _ p: String) -> Bool {
        // 22:47 - 23:17
        
        let cAll = Character(".")
        let cLikePre = Character("*")
        
        var pIdx = p.startIndex
        let pEndIdx = p.endIndex
        
        var sIdx = s.startIndex
        let sEndIdx = s.endIndex
        
        func gotoNext(_ sForward: Bool, _ pForward: Bool) {
            if sForward {
                sIdx = s.index(after: sIdx)
            }
            if pForward {
                pIdx = p.index(after: pIdx)
            }
        }
        
        var preP: Character?
        
        while (sIdx != sEndIdx && pIdx != pEndIdx) {
            let chs = s[sIdx]
            let chp = p[pIdx]
            
            if chs == chp {
                // 1. "ab" , "ab"
                preP = chp
                gotoNext(true, true)
                continue
            }
            
            if chp == cAll {
                // 2. "ab", ".."
                preP = chp
                gotoNext(true, true)
            }
            else if chp == cLikePre {
                // 3. "aa", "a*" / ".*"
                if let prep = preP, (prep == cAll || prep == chs) {
                    gotoNext(true, false)
                }
                else {
                    // 4. "aab", "a*"
                    gotoNext(false, true)
                }
            }
            else {
                /*
                 abc bbc
                 */

                gotoNext(false, true)
                if pIdx != pEndIdx && p[pIdx] == cLikePre {
                    // "aab", "c*a*b"。指针后移
                    gotoNext(false, true)
                }
                else {
                    break
                }
            }
        }
        
        // "aab", "a*bb*c*"
        // 匹配还需要向前操作。舍弃此方法，考虑dp
        
        
        return sIdx == sEndIdx
    }
    
    // MARK: -- 2022/04/17
    
    // MARK: #12. 整数转罗马数字
    
    /// #12. 整数转罗马数字
    /// 罗马数字包含以下七种字符： I， V， X， L，C，D 和 M。
    ///
    ///     字符          数值
    ///     I             1
    ///     V             5
    ///     X             10
    ///     L             50
    ///     C             100
    ///     D             500
    ///     M             1000
    ///
    /// 例如， 罗马数字 2 写做 II ，即为两个并列的 1。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
    ///
    /// 通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：
    ///
    ///     I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
    ///     X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。
    ///     C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
    ///
    /// 给你一个整数，将其转为罗马数字。
    ///
    ///     示例 1:
    ///     输入: num = 3
    ///     输出: "III"
    ///
    ///     示例 2:
    ///     输入: num = 4
    ///     输出: "IV"
    ///     示例 3:
    ///     输入: num = 9
    ///     输出: "IX"
    ///
    ///     示例 4:
    ///     输入: num = 58
    ///     输出: "LVIII"
    ///     解释: L = 50, V = 5, III = 3.
    ///
    ///     示例 5:
    ///     输入: num = 1994
    ///     输出: "MCMXCIV"
    ///     解释: M = 1000, CM = 900, XC = 90, IV = 4.
    ///
    /// 提示：
    ///
    ///     1 <= num <= 3999
    ///
    /// 链接：https://leetcode-cn.com/problems/integer-to-roman
    func intToRoman(_ num: Int) -> String {
        
        if num < 1 { return "" }
        
        let romanValueSymbols = [
            (1,     "I"),
            (4,     "IV"),
            (5,     "V"),
            (9,     "IX"),
            (10,    "X"),
            (40,    "XL"),
            (50,    "L"),
            (90,    "XC"),
            (100,   "C"),
            (400,   "CD"),
            (500,   "D"),
            (900,   "CM"),
            (1000,  "M"),
        ]
        
        var roman = ""
        var number = num
        for idx in (0..<romanValueSymbols.count).reversed() {
            if number == 0 {
                break
            }
            let symbol = romanValueSymbols[idx]
            let romanValue = symbol.0
            if number >= romanValue {
                let cnt = number / romanValue
                number = number % romanValue
                for _ in 0..<cnt {
                    roman.append(symbol.1)
                }
            }
        }
        return roman
    }
    
    func intToRoman1(_ num: Int) -> String {
        // 16: 00 - 16:30
        if num < 1 { return "" }
        
        let romanFlags = ["I","V","X","L","C","D","M"]
        let romanValues = [1, 5, 10, 50, 100, 500, 1000]
        let romanRules = [0, 1, 1, 10, 10, 100, 100]
        
        var roman = ""
        var number = num
        for idx in (0..<romanFlags.count).reversed() {
            if number == 0 {
                break
            }
            let romanValue = romanValues[idx]
            if number >= romanValue {
                let cnt = number / romanValue
                number = number % romanValue
                for _ in 0..<cnt {
                    roman.append(romanFlags[idx])
                }
            }
            let ruleValue = romanRules[idx]
            if ruleValue > 0, number >= romanValue - ruleValue {
                let ruleIdx = romanValues.firstIndex(of: ruleValue)!
                number = number - (romanValue - ruleValue)
                roman.append(romanFlags[ruleIdx])
                roman.append(romanFlags[idx])
            }
        }
        return roman
    }
    
    // MARK: #13. 罗马数字转整数
    
    /// #13. 罗马数字转整数
    /// 难度：简单
    ///
    /// 罗马数字包含以下七种字符: I， V， X， L，C，D 和 M。
    ///
    ///     字符          数值
    ///     I             1
    ///     V             5
    ///     X             10
    ///     L             50
    ///     C             100
    ///     D             500
    ///     M             1000
    /// 例如， 罗马数字 2 写做 II ，即为两个并列的 1 。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
    ///
    /// 通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 /// 表示为 IX。这个特殊的规则只适用于以下六种情况：
    ///
    ///     I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
    ///     X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。
    ///     C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
    ///
    /// 给定一个罗马数字，将其转换成整数。
    ///
    ///     示例 1:
    ///     输入: s = "III"
    ///     输出: 3
    ///
    ///     示例 2:
    ///     输入: s = "IV"
    ///     输出: 4
    ///
    ///     示例 3:
    ///     输入: s = "IX"
    ///     输出: 9
    ///
    ///     示例 4:
    ///     输入: s = "LVIII"
    ///     输出: 58
    ///     解释: L = 50, V= 5, III = 3.
    ///
    ///     示例 5:
    ///     输入: s = "MCMXCIV"
    ///     输出: 1994
    ///     解释: M = 1000, CM = 900, XC = 90, IV = 4.
    ///
    /// 提示：
    ///
    ///     1 <= s.length <= 15
    ///     s 仅含字符 ('I', 'V', 'X', 'L', 'C', 'D', 'M')
    ///     题目数据保证 s 是一个有效的罗马数字，且表示整数在范围 [1, 3999] 内
    ///     题目所给测试用例皆符合罗马数字书写规则，不会出现跨位等情况。
    ///     IL 和 IM 这样的例子并不符合题目要求，49 应该写作 XLIX，999 应该写作 CMXCIX 。
    ///     关于罗马数字的详尽书写规则，可以参考 罗马数字 - Mathematics 。
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：12 ms, 在所有 Swift 提交中击败了93.77%的用户
    ///     内存消耗：14 MB, 在所有 Swift 提交中击败了79.77%的用户
    ///
    func romanToInt(_ s: String) -> Int {
        // 17:05 - 17:19
        let romanToIntTable = [
            ("I", 1),
            ("IV", 4),
            ("V", 5),
            ("IX", 9),
            ("X", 10),
            ("XL", 40),
            ("L", 50),
            ("XC", 90),
            ("C", 100),
            ("CD", 400),
            ("D", 500),
            ("CM", 900),
            ("M", 1000)
        ]
        
        var num = 0
        var tempS = s
        for idx in (0..<romanToIntTable.count).reversed() {
            if tempS.count < 1 { break}
            
            let entry = romanToIntTable[idx]
            while tempS.hasPrefix(entry.0) {
                num += entry.1
                tempS = String(tempS[tempS.index(tempS.startIndex, offsetBy: entry.0.count)..<tempS.endIndex])
            }
        }
        return num
    }
    
    // MARK: -- 2022/04/18
    
    // MARK: #14. 最长公共前缀
    
    /// #14. 最长公共前缀
    /// 难度：简单
    ///
    /// 编写一个函数来查找字符串数组中的最长公共前缀。
    ///
    /// 如果不存在公共前缀，返回空字符串 ""。
    ///
    ///     示例 1：
    ///     输入：strs = ["flower","flow","flight"]
    ///     输出："fl"
    ///
    ///     示例 2：
    ///     输入：strs = ["dog","racecar","car"]
    ///     输出：""
    ///     解释：输入不存在公共前缀。
    ///
    /// 提示：
    ///
    ///     1 <= strs.length <= 200
    ///     0 <= strs[i].length <= 200
    ///     strs[i] 仅由小写英文字母组成
    func longestCommonPrefix(_ strs: [String]) -> String {
        // 17:49 - 17:55
        if strs.count <= 1 { return strs.first ?? ""}
        var longestPrefix = strs.first!
        
        for idx in 1..<strs.count {
            let str = strs[idx]
            longestPrefix = str.commonPrefix(with: longestPrefix)
            if longestPrefix.count == 0 {
                break
            }
        }
        
        return longestPrefix
    }
    
    // MARK: #4. 寻找两个正序数组的中位数
    
    /// #4. 寻找两个正序数组的中位数
    ///
    /// 难度：困难
    ///
    /// 给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。
    ///
    /// 算法的时间复杂度应该为 O(log (m+n)) 。
    ///
    ///     示例 1：
    ///     输入：nums1 = [1,3], nums2 = [2]
    ///     输出：2.00000
    ///     解释：合并数组 = [1,2,3] ，中位数 2
    ///
    ///     示例 2：
    ///     输入：nums1 = [1,2], nums2 = [3,4]
    ///     输出：2.50000
    ///     解释：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5
    ///
    /// 提示：
    ///
    ///     nums1.length == m
    ///     nums2.length == n
    ///     0 <= m <= 1000
    ///     0 <= n <= 1000
    ///     1 <= m + n <= 2000
    ///     -106 <= nums1[i], nums2[i] <= 106
    ///
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        // 10:36 - 10-46
        /*
        O(min(m , n))
        */
        var nums: [Int] = []
        var idx1 = 0, idx2 = 0
        while idx1 < nums1.count && idx2 < nums2.count {
            if nums1[idx1] <= nums2[idx2] {
                nums.append(nums1[idx1])
                idx1 += 1
            }
            else {
                nums.append(nums2[idx2])
                idx2 += 1
            }
        }

        if idx1 < nums1.count {
            for idx in idx1..<nums1.count {
                nums.append(nums1[idx])
            }
        } else if idx2 < nums2.count {
            for idx in idx2..<nums2.count {
                nums.append(nums2[idx])
            }
        }
        
        var median: Double = Double(nums[(nums.count-1)/2])
        if nums.count % 2 == 0 {
            median += Double( nums[(nums.count+1)/2] )
            median *= 0.5
        }
        return median
    }
    
    // MARK: #23. 合并K个升序链表
    
    /// #23. 合并K个升序链表
    ///
    /// 难度：困难
    ///
    /// 给你一个链表数组，每个链表都已经按升序排列。
    ///
    /// 请你将所有链表合并到一个升序链表中，返回合并后的链表。
    ///
    ///     示例 1：
    ///     输入：lists = [[1,4,5],[1,3,4],[2,6]]
    ///     输出：[1,1,2,3,4,4,5,6]
    ///     解释：链表数组如下：
    ///     [
    ///       1->4->5,
    ///       1->3->4,
    ///       2->6
    ///     ]
    ///     将它们合并到一个有序链表中得到。
    ///     1->1->2->3->4->4->5->6
    ///
    ///     示例 2：
    ///     输入：lists = []
    ///     输出：[]
    ///
    ///     示例 3：
    ///     输入：lists = [[]]
    ///     输出：[]
    ///
    /// 提示：
    ///
    ///     k == lists.length
    ///     0 <= k <= 10^4
    ///     0 <= lists[i].length <= 500
    ///     -10^4 <= lists[i][j] <= 10^4
    ///     lists[i] 按 升序 排列
    ///     lists[i].length 的总和不超过 10^4
    ///
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        // 14:08 - 14:26
        let node = ListNode()
        
        var lists: [ListNode?] = lists
        lists = lists.filter { list in
            list != nil
        }
        
        var next: ListNode? = node
        while lists.count > 0 {
            lists.sort { list1, list2 in
                if (list1 == nil) {
                    return false
                }
                if (list2 == nil) {
                    return true
                }
                return list1!.val < list2!.val
            }
            next?.next = lists[0]
            next = next?.next
            if let nn = next?.next {
                lists[0] = nn
            } else {
                lists.remove(at: 0)
            }
        }
        
        return node.next
    }
    
    // MARK: -- 2022/04/19
    
    // MARK: #31. 下一个排列
    
    /// #31. 下一个排列
    ///
    ///难度：中等
    ///
    /// 整数数组的一个 排列  就是将其所有成员以序列或线性顺序排列。
    ///
    /// 例如，arr = [1,2,3] ，以下这些都可以视作 arr 的排列：[1,2,3]、[1,3,2]、[3,1,2]、[2,3,1] 。
    /// 整数数组的 下一个排列 是指其整数的下一个字典序更大的排列。更正式地，如果数组的所有排列根据其字典顺序从小到大排列在一个容器中，那么数组的 下一个排列
    ///
    /// 就是在这个有序容器中排在它后面的那个排列。如果不存在下一个更大的排列，那么这个数组必须重排为字典序最小的排列（即，其元素按升序排列）。
    ///
    ///     例如，arr = [1,2,3] 的下一个排列是 [1,3,2] 。
    ///     类似地，arr = [2,3,1] 的下一个排列是 [3,1,2] 。
    ///     而 arr = [3,2,1] 的下一个排列是 [1,2,3] ，因为 [3,2,1] 不存在一个字典序更大的排列。
    ///
    /// 给你一个整数数组 nums ，找出 nums 的下一个排列。
    ///
    /// 必须 原地 修改，只允许使用额外常数空间。
    ///
    ///     示例 1：
    ///
    ///     输入：nums = [1,2,3]
    ///     输出：[1,3,2]
    ///
    ///     示例 2：
    ///     输入：nums = [3,2,1]
    ///     输出：[1,2,3]
    ///
    ///     示例 3：
    ///     输入：nums = [1,1,5]
    ///     输出：[1,5,1]
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 100
    ///     0 <= nums[i] <= 100
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：4 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：13.6 MB, 在所有 Swift 提交中击败了80.16%的用户
    ///     通过测试用例：265 / 265
    ///
    func nextPermutation(_ nums: inout [Int]) {
        // 14:52
        if nums.count <= 1 {
            return
        }
        if nums.count == 2 {
            nums = nums.reversed()
            return
        }
        let count = nums.count
        var idx = count
        for i in (0..<count-1).reversed() {
           for j in (i+1..<count).reversed() {
               if nums[i] < nums[j] {
                   let temp = nums[j]
                   nums[j] = nums[i]
                   nums[i] = temp
                   idx = j + 1
                   break
               }
           }
           if idx != count {
               break
           }
       }
        
        if idx == count - 1 {
            return
        }
        
        if idx == count {
            nums = nums.reversed()
            return
        }

        for i in idx..<count-1 {
            for j in i+1..<count {
                if nums[i] <= nums[j] {
                    continue
                }
                let temp = nums[j]
                nums[j] = nums[i]
                nums[i] = temp
            }
        }
        
        return
    }
    
    // MARK: -- 22/04/20
    
    // MARK: #42
    func trap(_ height: [Int]) -> Int {
        if height.count < 3 {
            return 0
        }
        var total = 0
        
        return total
    }
    
    // MARK: 22/04/21
    
    // MARK: #24. 两两交换链表中的节点
    
    /// #24. 两两交换链表中的节点
    ///
    /// 难度：中等
    ///
    /// 给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。
    ///
    ///     示例 1：
    ///     输入：head = [1,2,3,4]
    ///     输出：[2,1,4,3]
    ///
    ///     示例 2：
    ///     输入：head = []
    ///     输出：[]
    ///
    ///     示例 3：
    ///     输入：head = [1]
    ///     输出：[1]
    ///
    /// 提示：
    /// - 链表中节点的数目在范围 [0, 100] 内
    /// -  0 <= Node.val <= 100
    ///
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head?.next == nil {
            return head
        }
        let next = head?.next
        head?.next = swapPairs(next?.next)
        next?.next = head
        return next
    }
    
    // MARK: #25. K 个一组翻转链表
    
    /// #25. K 个一组翻转链表
    ///
    /// 难度：困难
    ///
    /// 给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。
    ///
    /// k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
    ///
    /// 你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。
    ///
    ///     示例 1：
    ///     输入：head = [1,2,3,4,5], k = 2
    ///     输出：[2,1,4,3,5]
    ///
    ///     示例 2：
    ///     输入：head = [1,2,3,4,5], k = 3
    ///     输出：[3,2,1,4,5]
    ///
    /// 提示：
    /// - 链表中的节点数目为 n
    /// - 1 <= k <= n <= 5000
    /// - 0 <= Node.val <= 1000
    ///
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        // 15:40
        func reverse(_ node: ListNode?) -> ListNode? {
            if node?.next == nil {
                return node
            }
            let next = node?.next
            let h = reverse(next)
            next?.next = node
            return h
        }
        let reverseHead: ListNode? = ListNode(0, head)
        var pre: ListNode? = reverseHead
        var end: ListNode? = head
        var len = 0
        
        while end != nil {
            len += 1
            if len < k {
                end = end?.next
                continue
            }
            let next = end?.next
            let preNext = pre?.next
            end?.next = nil
            pre?.next = reverse(pre?.next)
            preNext?.next = next
            pre = preNext
            end = next
            len = 0
        }
        return reverseHead?.next
    }
    
    // MARK: #26. 删除有序数组中的重复项
    
    /// #26. 删除有序数组中的重复项
    ///
    /// 难度：简单
    ///
    /// 给你一个 升序排列 的数组 nums ，请你 原地 删除重复出现的元素，使每个元素 只出现一次 ，返回删除后数组的新长度。元素的 相对顺序 应该保持 一致 。
    ///
    /// 由于在某些语言中不能改变数组的长度，所以必须将结果放在数组nums的第一部分。更规范地说，如果在删除重复项之后有 k 个元素，那么 nums 的前 k 个元素应该保存最终结果。
    ///
    /// 将最终结果插入 nums 的前 k 个位置后返回 k 。
    ///
    /// 不要使用额外的空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。
    ///
    /// 判题标准:
    ///
    /// 系统会用下面的代码来测试你的题解:
    ///
    ///     int[] nums = [...]; // 输入数组
    ///     int[] expectedNums = [...]; // 长度正确的期望答案
    ///
    ///     int k = removeDuplicates(nums); // 调用
    ///
    ///     assert k == expectedNums.length;
    ///     for (int i = 0; i < k; i++) {
    ///         assert nums[i] == expectedNums[i];
    ///     }
    /// 如果所有断言都通过，那么您的题解将被 通过。
    ///
    ///     示例 1：
    ///     输入：nums = [1,1,2]
    ///     输出：2, nums = [1,2,_]
    ///     解释：函数应该返回新的长度 2 ，并且原数组 nums 的前两个元素被修改为 1, 2 。不需要考虑数组中超出新长度后面的元素。
    ///
    ///     示例 2：
    ///     输入：nums = [0,0,1,1,1,2,2,3,3,4]
    ///     输出：5, nums = [0,1,2,3,4]
    ///     解释：函数应该返回新的长度 5 ， 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4 。不需要考虑数组中超出新长度后面的元素。
    ///
    /// 提示：
    /// - 0 <= nums.length <= 3 * 104
    /// - -104 <= nums[i] <= 104
    /// - nums 已按 升序 排列
    ///
    /// 链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array
    ///
    /// 执行结果：通过
    /// - 执行用时：40 ms, 在所有 Swift 提交中击败了98.43%的用户
    /// - 内存消耗：14.5MB, 在所有 Swift 提交中击败了70.16%的用户
    /// - 通过测试用例：361 / 361
    ///
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count < 2 {
            return nums.count
        }
        var cnt = 1
        var pre = nums[0]
        
        for i in 1..<nums.count {
            if pre != nums[0] {
                cnt += 1
                pre = nums[i]
                nums[cnt-1] = nums[i]
            }
        }
        return cnt
    }
    
    
    // MARK: #27. 移除元素
    
    /// #27. 移除元素
    ///
    /// 难度：简单
    ///
    /// 给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
    ///
    /// 不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。
    ///
    /// 元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
    ///
    /// 说明:
    ///
    /// 为什么返回数值是整数，但输出的答案是数组呢?
    ///
    /// 请注意，输入数组是以「引用」方式传递的，这意味着在函数里修改输入数组对于调用者是可见的。
    ///
    /// 你可以想象内部操作如下:
    ///
    ///     // nums 是以“引用”方式传递的。也就是说，不对实参作任何拷贝
    ///     int len = removeElement(nums, val);
    ///
    ///     // 在函数里修改输入数组对于调用者是可见的。
    ///     // 根据你的函数返回的长度, 它会打印出数组中 该长度范围内 的所有元素。
    ///     for (int i = 0; i < len; i++) {
    ///         print(nums[i]);
    ///     }
    ///
    /// 示例
    ///
    ///     示例 1：
    ///     输入：nums = [3,2,2,3], val = 3
    ///     输出：2, nums = [2,2]
    ///     解释：函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。你不需要考虑数组中超出新长度后面的元素。例如，函数返回的新长度为 2 ，而 ///  nums = [2,2,3,3] 或 nums = [2,2,0,0]，也会被视作正确答案。
    ///
    ///     示例 2：
    ///     输入：nums = [0,1,2,2,3,0,4,2], val = 2
    ///     输出：5, nums = [0,1,4,0,3]
    ///     解释：函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, /// 4。注意这五个元素可为任意顺序。你不需要考虑数组中超出新长度后面的元素。
    ///
    /// 提示：
    /// - 0 <= nums.length <= 100
    /// - 0 <= nums[i] <= 50
    /// - 0 <= val <= 100
    ///
    /// 链接：https://leetcode-cn.com/problems/remove-element
    ///
    /// 执行结果：通过
    /// - 执行用时：4 ms, 在所有 Swift 提交中击败了88.19%的用户
    /// - 内存消耗：13.7 MB, 在所有 Swift 提交中击败了71.18%的用户
    /// - 通过测试用例：113 / 113
    ///
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        // 17:03
        var cnt = 0
        for i in 0..<nums.count {
            if nums[i] == val {
                continue
            }
            cnt += 1
            nums[cnt-1] = nums[i]
        }
        return cnt
    }
    
    // MARK: #28. 实现 strStr()
    
    /// #28. 实现 strStr()
    ///
    ///难度：简单
    ///
    /// 实现 strStr() 函数。
    ///
    /// 给你两个字符串 haystack 和 needle ，请你在 haystack 字符串中找出 needle 字符串出现的第一个位置（下标从 0 开始）。如果不存在，则返回 ///  -1 。
    ///
    /// 说明：
    ///
    /// 当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。
    ///
    /// 对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与 C 语言的 strstr() 以及 Java 的 indexOf() 定义相符。
    ///
    ///     示例 1：
    ///     输入：haystack = "hello", needle = "ll"
    ///     输出：2
    ///
    ///     示例 2：
    ///     输入：haystack = "aaaaa", needle = "bba"
    ///     输出：-1
    ///
    ///     示例 3：
    ///     输入：haystack = "", needle = ""
    ///     输出：0
    ///
    /// 提示：
    /// - 1 <= haystack.length, needle.length <= 104
    /// - haystack 和 needle 仅由小写英文字符组成
    func strStr(_ haystack: String, _ needle: String) -> Int {
        // 17:17
        if needle.count == 0 {
            return 0
        }
        if haystack.count == 0 || haystack.count < needle.count {
            return -1
        }
        var idx = haystack.startIndex
        var idx1 = haystack.startIndex, idx2 = needle.startIndex
        while (idx1 != haystack.endIndex && idx2 != needle.endIndex) {
            if haystack[idx1] == needle[idx2] {
                idx1 = haystack.index(after: idx1)
                idx2 = needle.index(after: idx2)
                continue
            }
            idx = haystack.index(after: idx)
            idx1 = idx
            idx2 = needle.startIndex
        }
        if idx2 == needle.endIndex {
            return haystack.distance(from: haystack.startIndex, to: idx)
        }
        return -1
    }
    
    // MARK: #29. 两数相除
    
    /// #29. 两数相除
    ///
    /// 难度：中等
    ///
    /// 给定两个整数，被除数 dividend 和除数 divisor。将两数相除，要求不使用乘法、除法和 mod 运算符。

    /// 返回被除数 dividend 除以除数 divisor 得到的商。

    /// 整数除法的结果应当截去（truncate）其小数部分，例如：truncate(8.345) = 8 以及 truncate(-2.7335) = -2
    ///
    ///     示例 1:
    ///     输入: dividend = 10, divisor = 3
    ///     输出: 3
    ///     解释: 10/3 = truncate(3.33333..) = truncate(3) = 3
    ///
    ///     示例 2:
    ///     输入: dividend = 7, divisor = -3
    ///     输出: -2
    ///     解释: 7/-3 = truncate(-2.33333..) = -2
    ///
    /// 提示：
    /// - 被除数和除数均为 32 位有符号整数。
    /// - 除数不为 0。
    /// - 假设我们的环境只能存储 32 位有符号整数，其数值范围是 [−231,  231 − 1]。本题中，如果除法结果溢出，则返回 231 − 1。
    ///
    /// 链接：https://leetcode-cn.com/problems/divide-two-integers
    /// 
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        // 17:50
        let signedValue = 0x80000000
        let signedFlag = (dividend & signedValue) == (divisor & signedValue) ? 1: -1
        
        var dividend1 = abs(dividend)
        let divisor1 = abs(divisor)
        
        var divide = 0
        while dividend1 >= divisor1 {
            divide += 1
            dividend1 -= divisor1
        }
        divide = divide * signedFlag
        // 数值范围是 [−2^31,  2^31 − 1]
        if divide > 0x7fffffff {
            divide = 0x7fffffff
        }
        else if divide < -(0x7fffffff + 1) {
            divide = -(0x7fffffff + 1)
        }
        
        return divide
    }
    
    /// 执行结果：通过
    /// - 执行用时：4 ms, 在所有 Swift 提交中击败了92.19%的用户
    /// - 内存消耗：13 MB, 在所有 Swift 提交中击败了96.88%的用户
    /// - 通过测试用例：992 / 992
    ///
    func divideAdvance(_ dividend: Int, _ divisor: Int) -> Int {
        // 18:11
        // 位运算
        let byteSize = 32
        // 符号位
        let signedFlag = dividend >> (byteSize - 1)  == divisor >> (byteSize - 1) ? 1 : -1
        
        let udividend = abs(dividend)
        let udivisor = abs(divisor)
        var firstBinIdx1 = -1
        var firstBinIdx2 = -1
        for i in (0..<byteSize).reversed() {
            let bin = udividend >> i & 1
            if bin == 1 {
                firstBinIdx1 = i
                break
            }
        }
        for i in (0..<byteSize).reversed() {
            let bin = udivisor >> i & 1
            if bin == 1 {
                firstBinIdx2 = i
                break
            }
        }
        if firstBinIdx1 == -1 || firstBinIdx2 == -1 || firstBinIdx1 < firstBinIdx2 {
            return 0
        }
        
        var divide = 0
        var dividend1 = 0
        
        while firstBinIdx1 >= 0 {
            dividend1 = dividend1 << 1 + ( udividend >> firstBinIdx1 & 1 )
            firstBinIdx1 -= 1
            
            if dividend1 >= udivisor {
                dividend1 -= udivisor
                divide = divide << 1 + 1
            }
            else {
                divide = divide << 1
            }
        }
        
        divide *= signedFlag
        divide = divide.clamp(-0x80000000, 0x7fffffff)
        
        return divide
    }
    
    // MARK: #38. 外观数列
    
    /// #38. 外观数列
    ///
    /// 难度：中等
    ///
    /// 给定一个正整数 n ，输出外观数列的第 n 项。
    ///
    /// 「外观数列」是一个整数序列，从数字 1 开始，序列中的每一项都是对前一项的描述。
    ///
    /// 你可以将其视作是由递归公式定义的数字字符串序列：
    /// - countAndSay(1) = "1"
    /// - countAndSay(n) 是对 countAndSay(n-1) 的描述，然后转换成另一个数字字符串。
    ///
    ///  前五项如下：
    ///
    ///     1.     1
    ///     2.     11
    ///     3.     21
    ///     4.     1211
    ///     5.     111221
    ///     第一项是数字 1
    ///     描述前一项，这个数是 1 即 “ 一 个 1 ”，记作 "11"
    ///     描述前一项，这个数是 11 即 “ 二 个 1 ” ，记作 "21"
    ///     描述前一项，这个数是 21 即 “ 一 个 2 + 一 个 1 ” ，记作 "1211"
    ///     描述前一项，这个数是 1211 即 “ 一 个 1 + 一 个 2 + 二 个 1 ” ，记作 "111221"
    ///
    /// 要 描述 一个数字字符串，首先要将字符串分割为 最小 数量的组，每个组都由连续的最多 相同字符 /// 组成。然后对于每个组，先描述字符的数量，然后描述字符，形成一个描述组。要将描述转换为数字字符串，先将每组中的字符数量用数字替换，再将所有描述组连接起来。
    ///
    /// 例如，数字字符串 "3322251" 的描述如下图：
    ///
    ///     示例 1：
    ///     输入：n = 1
    ///     输出："1"
    ///     解释：这是一个基本样例。
    ///
    ///     示例 2：
    ///     输入：n = 4
    ///     输出："1211"
    ///     解释：
    ///     countAndSay(1) = "1"
    ///     countAndSay(2) = 读 "1" = 一 个 1 = "11"
    ///     countAndSay(3) = 读 "11" = 二 个 1 = "21"
    ///     countAndSay(4) = 读 "21" = 一 个 2 + 一 个 1 = "12" + "11" = "1211"
    ///
    /// 提示：
    /// - 1 <= n <= 30
    ///
    /// 链接：https://leetcode-cn.com/problems/count-and-say
    ///
    /// 执行结果：通过
    /// - 执行用时：12 ms, 在所有 Swift 提交中击败了69.77%的用户
    /// - 内存消耗：13.1 MB, 在所有 Swift 提交中击败了100.00%的用户
    /// - 通过测试用例：30 / 30
    func countAndSay(_ n: Int) -> String {
        // 19:50 - 20:01
        if n == 0 { return "" }
        if n == 1 { return "1" }
        if n == 2 { return "11" }

        let str1 = countAndSay(n - 1)
        var str = ""
        var cnt = 0

        var preCh = Character(" ")
        for ch in str1 {
            if ch == preCh {
                cnt += 1
                continue
            }
            if (cnt != 0) {
                str.append("\(cnt)")
                str.append(preCh)
            }

            cnt = 1
            preCh = ch
        }
        if cnt != 0 {
            str.append("\(cnt)")
            str.append(preCh)
        }
        return str
    }
    
    // MARK: #50. Pow(x, n)
    
    /// #50. Pow(x, n)
    ///
    /// 难度：中等
    ///
    /// 实现 pow(x, n) ，即计算 x 的 n 次幂函数（即，xn ）。
    ///
    ///     示例 1：
    ///     输入：x = 2.00000, n = 10
    ///     输出：1024.00000
    ///
    ///     示例 2：
    ///     输入：x = 2.10000, n = 3
    ///     输出：9.26100
    ///
    ///     示例 3：
    ///     输入：x = 2.00000, n = -2
    ///     输出：0.25000
    ///     解释：2-2 = 1/22 = 1/4 = 0.25
    ///
    /// 链接：https://leetcode-cn.com/problems/powx-n
    ///
    /// 提示：
    /// - -100.0 < x < 100.0
    /// - -231 <= n <= 231-1
    /// - -104 <= xn <= 104
    ///
    func myPow(_ x: Double, _ n: Int) -> Double {
        // 21:28 - 21:31
        
        if (x == 0) { return 0 }
        if (n == 0) { return 1 }
        if (n == 1) { return x }
        if (n == -1) { return 1/x }
        
        var value = myPow(x, n/2)
        value *= value
        value *= myPow(x, n%2)
        return value
    }
    
}

