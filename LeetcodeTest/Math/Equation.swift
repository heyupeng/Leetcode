//
//  Math.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/12/3.
//

@frozen public struct Equation {
    
}

/// 直线方程。二元一次方程。
@frozen public struct LineEquation {
    let A: Int
    let B: Int
    let C: Int
    
    /// 已知两点，求解二维坐标直线方程 Ax + By + C = 0 。
    ///
    /// - Parameters:
    ///   - p1: 点1 [x, y]
    ///   - p2: 点2 [x, y]
    /// - Returns: [A, B, C]。
     static func getABC(_ p1: [Int], _ p2: [Int]) -> [Int] {
        /*
         (y - y1) / (y1 - y2) = (x - x1) / (x1 - x2)
         => (y1 - y2) * x - (x1 - x2) * y - x1 * (y1 - y2) + y1 * (x1 - x2) = 0
         令 A = y1 - y2, B = - (x1 - x2),
         则 C = x1 * A + y1 * (-B).
         */
         var x12 = -(p1[0] - p2[0]), y12 = p1[1] - p2[1]
         
         if x12 != 0, y12 != 0 {
             let gcd = Int.greatestCommonDivisor(x12, y12)
             if abs(gcd) > 1 {
                 x12 /= gcd
                 y12 /= gcd
             }
             if y12 < 0 {
                 x12 *= -1
                 y12 *= -1
             }
         }
         else if y12 == 0 {
             x12 = 1
         }
         else if x12 == 0 {
             y12 = 1
         }
         
         let A = y12
         let B = x12
         let C = -p1[0] * A + p1[1] * (-B)
         
         return [A, B, C]
     }
}
