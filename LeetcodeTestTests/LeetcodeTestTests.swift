//
//  LeetcodeTestTests.swift
//  LeetcodeTestTests
//
//  Created by Peng on 2021/10/26.
//

import XCTest
@testable import LeetcodeTest

class LeetcodeTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testNthUglyNumber() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            print("\(NthUglyNumber().nthUglyNumber(1699))")
        }
    }
    
    func testSearch2DMatrix() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            print("\(Search2DMatrix().searchMatrix(Search2DMatrix.matrix1, Search2DMatrix.target1))")
        }
    }
    
    func testNextGreaterElement() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            print("\(NextGreaterElement().test1())")
        }
    }
    
    func testContainsDuplicate() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            print("\(ContainsDuplicate().test1())")
        }
    }
    
    func testMaxSubArray() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            print("\(MaxSubArray().test1())")
        }
    }
    
    func testAlgorithm() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
//            print("\(BinarySearch().test1())")
            self.testAlgorithmDay6()
        }
    }
    
    func testAlgorithmDay6() {
//        let words = Algorithm.t557_t12
//        Algorithm().reverseWords(words)
        
        let s1 = "hello" // "ab" // "dszcltvvm(&akg!(cslq*!rilf!$akil%rsr%vlo)&lp&"
        let s2 = "ooolleoooleh" // "eidbaooo" // Algorithm.t557_t12
        Algorithm().checkInclusion(s1, s2)
    }
    
    func testDataStructure() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            // day 3
            DataStructure().intersect([1,2,2,1], [2,2])
            
            // day 4
            DataStructure().generate(5)
             
            DataStructure().matrixReshape([[1,2],[3,4]], 1, 4)
            
            dataStructureDay5()
            
            dataStructureDay6()
         
            dataStructureDay7()
            
            dataStructureDay8()
        }
    }
    func dataStructureDay5() {
        // day5
        DataStructure().isValidSudoku(
            [[".",".",".", ".","5",".", ".","1","."],
             [".","4",".", "3",".",".", ".",".","."],
             [".",".",".", ".",".","3", ".",".","1"],
             ["8",".",".", ".",".",".", ".","2","."],
             [".",".","2", ".","7",".", ".",".","."],
             [".","1","5", ".",".",".", ".",".","."],
             [".",".",".", ".",".","2", ".",".","."],
             [".","2",".", "9",".",".", ".",".","."],
             [".",".","4", ".",".",".", ".",".","."]])
        
        var m = [[1,1,1],[1,0,1],[1,1,1]]
        DataStructure().setZeroes(&m)
    }
    
    func dataStructureDay6() {
        // day 6
        DataStructure().firstUniqChar("loveleetcode")
        
        DataStructure().canConstruct("aa", "aab")
    }
    
    func dataStructureDay7() {
        // day 7
        DataStructure().testHasCycle()
        
        DataStructure().testMergeTwoLists()
        
        DataStructure().testRemoveElements()
    }
    
    func dataStructureDay8() {
        // day 8
        DataStructure().testReverseList()
        
        DataStructure().testDeleteDuplicates()
    }
}
