//
//  ViewController.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("\(Search2DMatrix().searchMatrix(Search2DMatrix.matrix1, Search2DMatrix.target1))")
        
        print("\(ValidParentheses().isValid(ValidParentheses.test41))")
        
        print("\(GenerateParentheses().generateParenthesis(3))")
        
        print("\(NextGreaterElement().test1())")
        
        testDataStructure()
        
        testAlgorithm()
        
        testDynamic()
    }
    
    func testDataStructure() {
        print("=== 数据结构入门篇 ===")
        print("=== Day 1 ===")
        print("\(ContainsDuplicate().test1())")
        
        print("\(MaxSubArray().test1())")
        
        print("=== Day 2 ===")
        print("\(TwoSum().test1())")
        
        print("\(MergeSortedArray().test1())")
    }

    func testAlgorithm() {
        print("=== 算法入门篇 ===")
        print("\(BinarySearch().test1())")
        
        print("\(FirstBadVersion().test1())")
        
        print("\(SearchInsert().test1())")
        
        let t_3_3 = "pwwkew"
        let t_3_179 = "dvdf"
        Algorithm().lengthOfLongestSubstring(t_3_3)
        
//        Algorithm().checkInclusion("cbp*zakunxu*e)bawja", Algorithm.t557_t12)
        
        // Day 7
        let image = [[1,1,1],[1,1,0],[1,0,1]]
        let sr = 1, sc = 1, newColor = 2
        Algorithm().floodFill(image, sr, sc, newColor)
        
        testAlgorithmDay9()
        
        testAlgorithmDay11()
        
        testAlgorithmDay13()
    }
    func testAlgorithmDay9() {
        // Day 9
        let mat3 = [[0,0,1,0,1,1,1,0,1,1],
                    [1,1,1,1,0,1,1,1,1,1],
                    [1,1,1,1,1,0,0,0,1,1],
                    [1,0,1,0,1,1,1,0,1,1],
                    [0,0,1,1,1,0,1,1,1,1],
                    [1,0,1,1,1,1,1,1,1,1],
                    [1,1,1,1,0,1,0,1,0,1],
                    [0,1,0,0,0,1,0,0,1,1],
                    [1,1,1,0,1,1,0,1,0,1],
                    [1,0,1,1,1,0,1,1,1,0]]
        
        let mat4 = [[1,1,0,0,1,0,0,1,1,0],
                    [1,0,0,1,0,1,1,1,1,1],
                    [1,1,1,0,0,1,1,1,1,0],
                    [0,1,1,1,0,1,1,1,1,1],
                    [0,0,1,1,1,1,1,1,1,0],
                    [1,1,1,1,1,1,0,1,1,1],
                    [0,1,1,1,1,1,1,0,0,1],
                    [1,1,1,1,1,0,0,1,1,1],
                    [0,1,0,1,1,0,1,1,1,1],
                    [1,1,1,0,1,0,1,1,1,1]]
        
        let mat5 = [[1,1,1,1,1,0,1,0,1,0,1,0,1,1,0,1,1,1,0,1,1,1,0,1,1,1,1,0,1,1],
                    [1,1,1,0,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,1,0,0,1],
                    [1,1,1,1,0,1,0,0,1,1,0,1,1,0,1,1,1,0,1,0,1,0,0,1,0,1,0,1,1,1],
                    [1,1,1,1,1,0,1,1,1,1,1,0,1,1,0,0,0,0,1,0,0,0,0,1,1,1,1,0,0,1],
                    [0,1,0,0,1,0,0,1,1,1,0,1,1,1,1,1,0,1,0,1,1,1,1,1,0,1,1,1,0,1],
                    [1,0,1,1,1,1,0,1,0,1,0,1,1,1,0,1,1,1,1,0,1,1,0,1,0,1,0,0,1,0],
                    [1,1,0,1,1,0,0,0,1,1,0,0,0,1,0,1,1,1,1,1,0,1,0,1,1,0,1,1,1,1],
                    [1,1,1,0,0,0,1,0,0,1,1,1,1,1,1,1,1,0,1,0,1,0,0,1,0,0,1,0,0,1],
                    [0,1,1,0,1,1,1,0,1,0,1,1,0,1,1,1,1,0,1,0,1,1,1,1,1,0,0,1,0,1],
                    [1,1,0,0,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,0,0,0,0,1,1],
                    [1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,0,1,1,0,1,0,1,1,1,0],
                    [1,1,1,1,0,1,0,0,0,1,1,1,0,1,1,1,0,1,0,1,1,1,0,1,0,1,1,1,1,1],
                    [0,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,1,1,0,1,0,0,0,1],
                    [0,1,1,0,0,0,1,1,0,0,0,0,1,1,0,1,1,1,1,1,1,1,0,1,0,0,1,1,1,1],
                    [1,1,1,1,0,0,1,1,1,0,0,1,1,0,1,1,1,0,0,1,1,0,1,0,0,0,0,1,1,1],
                    [1,1,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,1,0,0,0],
                    [1,1,0,1,1,0,0,1,1,0,0,1,0,1,1,1,1,0,1,1,1,0,1,1,0,1,0,1,0,1],
                    [1,0,0,0,1,1,1,0,1,1,1,1,0,0,1,1,1,0,1,1,0,1,0,0,1,1,1,1,1,0],
                    [1,1,0,1,0,1,1,0,0,1,1,0,0,1,0,1,1,1,1,1,1,0,1,0,0,0,0,1,1,1],
                    [1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,0,1,1,1,0,1,1,0,1,0,1,1,0],
                    [1,0,0,1,1,1,1,0,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,1,1,0,1,1],
                    [0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,0,1,0,0,1,0,1,1,0,1,1,0,1,0,1],
                    [1,1,1,0,1,1,1,0,0,1,0,0,0,1,1,1,1,0,1,1,1,0,1,1,1,1,1,1,1,1],
                    [1,1,0,0,1,1,1,1,0,0,1,0,0,1,1,0,0,1,1,1,1,0,1,1,0,1,1,1,1,1],
                    [0,0,0,1,1,1,1,1,1,0,1,1,1,0,0,1,1,1,1,1,1,1,0,1,0,0,0,1,1,0],
                    [1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,0,1,1,1,1,0,1,0,0,0,0,0,1,1,1],
                    [1,0,1,1,0,1,1,0,1,0,1,1,1,0,1,1,1,1,1,0,1,0,0,1,1,0,0,1,1,0],
                    [1,1,1,0,0,1,1,1,1,0,1,0,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1],
                    [1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,0,0,1,1,1],
                    [0,1,1,0,1,1,0,0,1,0,1,1,1,1,0,0,1,1,1,1,1,1,0,0,0,1,1,0,1,0]]
        Algorithm().updateMatrix(mat5)
        
        // #994
        let mat_994_1 = [[2,1,1],[1,1,0],[0,1,1]]
        Algorithm().orangesRotting(mat_994_1)
    }
    
    func testAlgorithmDay11() {
        // 11
        let mat_46_0 = [1,2,3]
        Algorithm().permute(mat_46_0)
        
        let s_784_0 = "a1b2"
        Algorithm().letterCasePermutation(s_784_0)
        
        // 12
        let nums_35 = [1,2,3,1]
        let nums_64 = [2,1,1,2]
        Algorithm().rob(nums_64)
        
        let num_120_0 = [[2],[3,4],[6,5,7],[4,1,8,3]]
        Algorithm().minimumTotal(num_120_0)
    }
    
    func testAlgorithmDay13() {
        // 13
        let num_231_0 = pow(2.0, 10.0)
        Algorithm().isPowerOfTwo(Int(num_231_0))
        
        let num_191_0 = 0b101011011010110
        Algorithm().hammingWeight(num_191_0)
        
        // 14
        let num_190_0 = 0b101011011010110
        Algorithm().reverseBits(num_190_0)
        
        let nums_136_0 = [4, 2, 1, 2, 1]
        Algorithm().singleNumber(nums_136_0)
    }
    
    func testDynamic() {
        print("=== 动态规划篇 ===")
        print("\(Dynamic().tribonacci(3))")
        
        // Day 2
        print("\(Dynamic().climbStairs(5))")
        
        let t_746_263 = Dynamic.TestParam746.t263
        print("\(Dynamic().minCostClimbingStairs(t_746_263.cost)) == \(t_746_263.ans)")
        
    }
}

