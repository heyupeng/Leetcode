//
//  LCSolution.swift
//  LeetcodeTest
//
//  Created by Peng on 2022/4/13.
//

import Foundation

// MARK: #800 - #899
protocol LC_899 {
    
}

extension LCSolution: LC_899 {
    
}

extension LC_899 {
    /* -- 2022-04-15 */
    
    // MARK: #806. 写字符串需要的行数
    
    /// #806. 写字符串需要的行数
    ///
    /// 难度: 简单
    ///
    /// 我们要把给定的字符串 S 从左到右写到每一行上，每一行的最大宽度为100个单位，如果我们在写某个字母的时候会使这行超过了100 个单位，那么我们应该把这个字母写到下一行。我们给定了一个数组 widths ，这个数组 widths[0] 代表 'a' 需要的单位， widths[1] 代表 'b' 需要的单位，...， widths[25] 代表 'z' 需要的单位。
    ///
    /// 现在回答两个问题：至少多少行能放下S，以及最后一行使用的宽度是多少个单位？将你的答案作为长度为2的整数列表返回。
    ///
    ///     示例 1:
    ///     输入:
    ///     widths = [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
    ///     S = "abcdefghijklmnopqrstuvwxyz"
    ///     输出: [3, 60]
    ///     解释:
    ///     所有的字符拥有相同的占用单位10。所以书写所有的26个字母，
    ///     我们需要2个整行和占用60个单位的一行。
    ///
    ///     示例 2:
    ///     输入:
    ///     widths = [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
    ///     S = "bbbcccdddaaa"
    ///     输出: [2, 4]
    ///     解释:
    ///     除去字母'a'所有的字符都是相同的单位10，并且字符串 "bbbcccdddaa" 将会覆盖 9 * 10 + 2 * 4 = 98 个单位.
    ///     最后一个字母 'a' 将会被写到第二行，因为第一行只剩下2个单位了。
    ///     所以，这个答案是2行，第二行有4个单位宽度。
    /// 注:
    ///
    ///     字符串 S 的长度在 [1, 1000] 的范围。
    ///     S 只包含小写字母。
    ///     widths 是长度为 26的数组。
    ///     widths[i] 值的范围在 [2, 10]。
    func numberOfLines(_ widths: [Int], _ s: String) -> [Int] {
        let limitWidth = 100
        var width = 0, lines = 1
        let aValue = Character("a").asciiValue!

        for ch in s {
            if let value = Character(String(ch)).asciiValue {
                let w = widths[Int(value - aValue)]
                if width + w > limitWidth {
                    lines += 1
                    width = 0
                }
                width += w
            }
        }
        return [width, lines]
    }
    
    /* -- 2022-04-17 */
    
    // MARK: #819. 最常见的单词
    
    /// #819. 最常见的单词
    ///
    /// 难度：简单
    ///
    /// 给定一个段落 (paragraph) 和一个禁用单词列表 (banned)。返回出现次数最多，同时不在禁用列表中的单词。
    ///
    /// 题目保证至少有一个词不在禁用列表中，而且答案唯一。
    ///
    /// 禁用列表中的单词用小写字母表示，不含标点符号。段落中的单词不区分大小写。答案都是小写字母。
    ///
    /// 示例：
    ///
    ///     输入:
    ///     paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
    ///     banned = ["hit"]
    ///     输出: "ball"
    ///     解释:
    ///     "hit" 出现了3次，但它是一个禁用的单词。
    ///     "ball" 出现了2次 (同时没有其他单词出现2次)，所以它是段落里出现次数最多的，且不在禁用列表中的单词。
    ///     注意，所有这些单词在段落里不区分大小写，标点符号需要忽略（即使是紧挨着单词也忽略， 比如 "ball,"），
    ///     "hit"不是最终的答案，虽然它出现次数更多，但它在禁用单词列表中。
    ///
    /// 提示：
    ///
    ///     1 <= 段落长度 <= 1000
    ///     0 <= 禁用单词个数 <= 100
    ///     1 <= 禁用单词长度 <= 10
    ///     答案是唯一的, 且都是小写字母 (即使在 paragraph 里是大写的，即使是一些特定的名词，答案都是小写的。)
    ///     paragraph 只包含字母、空格和下列标点符号!?',;.
    ///     不存在没有连字符或者带有连字符的单词。
    ///     单词里只包含字母，不会出现省略号或者其他标点符号。
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：8 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：14.2 MB, 在所有 Swift 提交中击败了50.00%的用户
    ///     通过测试用例：47 / 47
    ///
    func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
        
        var wordMap: [String: Int] = [:]
        func wordMapInsert(_ lowerWord: String) {
            if let cnt = wordMap[lowerWord] {
                wordMap[lowerWord] = cnt + 1
            } else {
                wordMap[lowerWord] = 1
            }
        }
        
        var word = ""
        for letter in paragraph {
            if (letter.isLetter) {
                word.append(letter)
                continue
            }
            if word.count > 0 {
                wordMapInsert(word.lowercased())
                word = ""
            }
        }
        
//        let characterSet = CharacterSet(charactersIn: " !?',;.")
//        let words = paragraph.components(separatedBy: characterSet).filter { word in
//            return word.count > 0
//        }
//        for word in words {
//            let lowerWord = word.lowercased()
//            wordMapInsert(lowerWord)
//        }
        
        for ban in banned {
            if let _ = wordMap[ban.lowercased()] {
                wordMap.removeValue(forKey: ban.lowercased())
            }
        }
        
        var mostWord = ""
        var cnt = 0
        for (key, value) in wordMap {
            if value > cnt {
                cnt = value
                mostWord = key
            }
        }
        return mostWord
    }
    
    // MARK: #804. 唯一摩尔斯密码词
    
    /// #804. 唯一摩尔斯密码词
    ///
    ///难度：简单
    ///
    /// 国际摩尔斯密码定义一种标准编码方式，将每个字母对应于一个由一系列点和短线组成的字符串， 比如:
    ///
    ///     '   a' 对应 ".-" ，
    ///     '   b' 对应 "-..." ，
    ///     '   c' 对应 "-.-." ，以此类推。
    /// 为了方便，所有 26 个英文字母的摩尔斯密码表如下：
    ///
    ///     [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
    ///
    /// 给你一个字符串数组 words ，每个单词可以写成每个字母对应摩尔斯密码的组合。
    
    /// 例如，"cab" 可以写成 "-.-..--..." ，(即 "-.-." + ".-" + "-..." 字符串的结合)。我们将这样一个连接过程称作 单词翻译 。
    ///
    /// 对 words 中所有单词进行单词翻译，返回不同 单词翻译 的数量。
    ///
    ///     示例 1：
    ///     输入: words = ["gin", "zen", "gig", "msg"]
    ///     输出: 2
    ///     解释:
    ///     各单词翻译如下:
    ///     "gin" -> "--...-."
    ///     "zen" -> "--...-."
    ///     "gig" -> "--...--."
    ///     "msg" -> "--...--."
    ///     共有 2 种不同翻译, "--...-." 和 "--...--.".
    ///
    ///     示例 2：
    ///     输入：words = ["a"]
    ///     输出：1
    ///
    /// 提示：
    ///
    ///     1 <= words.length <= 100
    ///     1 <= words[i].length <= 12
    ///     words[i] 由小写英文字母组成
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：8 ms, 在所有 Swift 提交中击败了70.42%的用户
    ///     内存消耗：14.4 MB, 在所有 Swift 提交中击败了49.29%的用户
    ///     通过测试用例：82 / 82
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let morseTable = [".-","-...","-.-.","-..",".","..-.",
                          "--.","....","..",".---","-.-",".-..",
                          "--","-.","---",".--.","--.-",".-.",
                          "...","-","..-","...-",".--","-..-",
                          "-.--","--.."]
        if words.count <= 1 { return words.count }
        
        var morseMap: [String: Int] = [:]
        for word in words {
            var morseString = ""
            for ch in word {
                if let ascii = ch.asciiValue {
                    let morse = morseTable[Int(ascii) - Int(Character("a").asciiValue!)]
                    morseString.append(morse)
                }
            }
            if morseString.count > 0, let cnt = morseMap[morseString] {
                morseMap[morseString] = cnt + 1
            } else if morseString.count > 0 {
                morseMap[morseString] = 1
            }
        }
        
        return morseMap.count
    }
    
    // MARK: -- 2022/04/19
    
    // MARK: #821. 字符的最短距离
    
    /// #821. 字符的最短距离
    ///
    /// 难度：简单
    ///
    /// 给你一个字符串 s 和一个字符 c ，且 c 是 s 中出现过的字符。
    ///
    /// 返回一个整数数组 answer ，其中 answer.length == s.length 且 answer[i] 是 s 中从下标 i 到离它 最近 的字符 c 的 距离 。
    ///
    /// 两个下标 i 和 j 之间的 距离 为 abs(i - j) ，其中 abs 是绝对值函数。
    ///
    ///     示例 1：
    ///     输入：s = "loveleetcode", c = "e"
    ///     输出：[3,2,1,0,1,0,0,1,2,2,1,0]
    ///     解释：字符 'e' 出现在下标 3、5、6 和 11 处（下标从 0 开始计数）。
    ///     距下标 0 最近的 'e' 出现在下标 3 ，所以距离为 abs(0 - 3) = 3 。
    ///     距下标 1 最近的 'e' 出现在下标 3 ，所以距离为 abs(1 - 3) = 2 。
    ///     对于下标 4 ，出现在下标 3 和下标 5 处的 'e' 都离它最近，但距离是一样的 abs(4 - 3) == abs(4 - 5) = 1 。
    ///     距下标 8 最近的 'e' 出现在下标 6 ，所以距离为 abs(8 - 6) = 2 。
    ///
    ///     示例 2：
    ///     输入：s = "aaab", c = "b"
    ///     输出：[3,2,1,0]
    ///
    /// 提示：
    ///
    ///     1 <= s.length <= 104
    ///     s[i] 和 c 均为小写英文字母
    ///     题目数据保证 c 在 s 中至少出现一次
    ///
    func shortestToChar(_ s: String, _ c: Character) -> [Int] {
        // 12:49
        var ans :[Int] = Array(repeating: s.count, count: s.count)
        var lastCIdx = -1, currentIdx = 0
        for ch in s {
            if ch != c {
                if lastCIdx > 0 { ans[currentIdx] = currentIdx - lastCIdx }
                currentIdx += 1
                continue
            }
            ans[currentIdx] = 0
            
            // 向前修正
            var lft = 0
            if (lastCIdx > 0) {
                lft = (lastCIdx + currentIdx + 1) / 2
            }
            for i in lft..<currentIdx {
                ans[i] = min(ans[i], currentIdx - i)
            }
            lastCIdx = currentIdx
            currentIdx += 1
        }
        return ans
    }
}
