//
//  GenerateParentheses.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/27.
//

import UIKit

/* 22. 括号生成
 数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
 有效括号组合需满足：左括号必须以正确的顺序闭合。
 */ /*
 示例 1：
 输入：n = 3
 输出：["((()))","(()())","(())()","()(())","()()()"]
 000111 7
 010101 21
 示例 2：
 输入：n = 1
 输出：["()"]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/generate-parentheses
 */

/*
 n = 1
 ()
 (_
 
 n = 2
 (()) ()()
 (_(_
 
 n = 3
 ((())) (()()) (())() ()()()
 
 */
class GenerateParentheses: NSObject {
    
    func generateParenthesis(_ n: Int) -> [String] {
        if n == 0 { return [] }
        if n == 1 { return ["()"] }
        
        var minimum = 0, maximum = 0
        for i in 0..<n {
            minimum += Int(pow(Double(2), Double(i)))
        }
        for i in 0..<n {
            maximum += Int(pow(Double(2), Double( 2 * i )))
        }
        if minimum == maximum {
            return ["()"]
        }
        
        var array = Array<String>()
        
        var num = minimum
        while num <= maximum {
            var counter = 0
            var str = ""
            for i in 0..<2*n {
                let flag = (num >> i) & 0x01
                if flag == 1 {
                    counter += 1
                    str.append("(")
                }
                else {
                    counter -= 1
                    str.append(")")
                }
                if counter < 0 { break }
                
            }
            num += 2
            if counter != 0 { continue }
            
            array.append(str)
        }
        
        return array
    }
}
