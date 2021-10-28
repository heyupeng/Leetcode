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
        
        print("=== 数据结构入门篇 ===")
        print("=== Day 1 ===")
        print("\(ContainsDuplicate().test1())")
        
        print("\(MaxSubArray().test1())")
        
        print("=== Day 2 ===")
        print("\(TwoSum().test1())")
        
        print("\(MergeSortedArray().test1())")
        
        testAlgorithm()
    }

    func testAlgorithm() {
        print("=== 算法入门篇 ===")
        print("\(BinarySearch().test1())")
        
        print("\(FirstBadVersion().test1())")
        
        print("\(SearchInsert().test1())")
    }
}

