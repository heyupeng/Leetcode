//
//  ValidParentheses.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/27.
//

import UIKit

/* 20. 有效的括号
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。
 有效字符串需满足：
 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/valid-parentheses
 
 执行用时： 4 ms , 在所有 Swift 提交中击败了 83.49% 的用户
 内存消耗： 13.6 MB , 在所有 Swift 提交中击败了 96.41% 的用户
 通过测试用例：91 / 91
 */
class ValidParentheses: NSObject {
    static let test41 = "()[]{}"
    
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
    
}
