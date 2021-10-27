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
    }


}

