//
//  Search2DMatrix.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/27.
//

import UIKit

/* 240. 搜索二维矩阵 II
 编写一个高效的算法来搜索 m x n 矩阵 matrix 中的一个目标值 target 。该矩阵具有以下特性：

 每行的元素从左到右升序排列。
 每列的元素从上到下升序排列。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/search-a-2d-matrix-ii
 */
class Search2DMatrix: NSObject {
    static let matrix1 = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]]
    static let target1 = 5
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count
        let n = matrix[0].count
        
        /// 1
//        for i in 0..<m {
//            for j in 0..<n {
//                if (matrix[i][j] == target) {
//                    return true
//                }
//            }
//        }
        for i in 0..<m {
            if matrix[i][0] > target {
                return false
            }
            if matrix[i][n-1] < target {
               continue
            }
            if (dichotomySearch(matrix[i], target) > -1) {
                return true
            }
        }
        
        return false
    }
    
    func dichotomySearch(_ matrix: [Int], _ target: Int) -> Int {
        var l = 0, r = matrix.count - 1
        
        while (l <= r) {
            let index = (l + r) / 2
            if matrix[index] == target {
                return index
            }
            else if matrix[index] < target {
                if l < index { l = index } else { l += 1}
            } else {
                if l > index { r = index } else { r -= 1}
            }
        }
        
        return -1
    }
}
