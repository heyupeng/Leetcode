//
//  LCSolution.swift
//  LeetcodeTest
//
//  Created by Peng on 2022/4/13.
//

import Foundation

// MARK: #400 - #499
protocol LCSolution_499: LCSolution99 {
    
}

extension LCSolution: LCSolution_499 {
    
}

extension LCSolution_499 {
    /* -- 2022-04-16 */
    
    // MARK: #479. 最大回文数乘积
    
    /// #479. 最大回文数乘积
    ///
    /// 给定一个整数 n ，返回 可表示为两个 n 位整数乘积的 最大回文整数 。因为答案可能非常大，所以返回它对 1337 取余 。
    ///
    ///     示例 1:
    ///     输入：n = 2
    ///     输出：987
    ///     解释：99 x 91 = 9009, 9009 % 1337 = 987
    ///
    ///     示例 2:
    ///     输入： n = 1
    ///     输出： 9
    ///
    /// 提示:
    ///
    ///     1 <= n <= 8

    /// 来源：力扣（LeetCode）
    /// 链接：https://leetcode-cn.com/problems/largest-palindrome-product
    ///
    ///     执行用时：304 ms, 在所有 Swift 提交中击败了33.33%的用户
    ///     内存消耗：14.4 MB, 在所有 Swift 提交中击败了33.33%的用户
    ///     通过测试用例：8 / 8
    ///
    func largestPalindrome(_ n: Int) -> Int {
        if n == 1 { return 9 }
        let maximumValue = powi(10, n) - 1
        // 最大回文数必然为9开头
//        var flag = 0
        // var nums = [maximumValue, maximumValue - 1]
        var largest = 0
        let lowwer = maximumValue - powi(10, (n + 1)/2)
        NSLog("start: n = \(n), [\(lowwer), \(maximumValue)]")
        
        let lowwer1 = ( lowwer + powi(10, (n-1)/2 ) + maximumValue )/2
        for i in (lowwer1...maximumValue).reversed() {
            if i % 2 == 0 {
                continue
            }
            var l1 = 0
            for j in (lowwer...maximumValue).reversed() {
                if j % 10 == 0 || i * j % 10 == 0 {
                    continue
                }
                if i * j % 10 != 9 {
                    continue;
                }
                let value = i * j
                if (!isPalindrome(value)) {
                    continue
                }
                l1 = max(l1, value)
                break
            }
            if l1 > 0 { NSLog("\(i) * \(l1/i) = \(l1) %% 1337 = \(l1 % 1337)") }
            if largest < l1 {
                largest = l1
            }
            else if l1 != 0 && l1 < largest * 2 / 3 {
             
            }
        }
        
        if (largest > 1337) {
            largest %= 1337
        }
        /*
         3 123
         4 597
         5 677
         6 1218
         7 877 94677111177649
         8 457
         */
        NSLog("end \(largest)")
        return largest
    }
}
