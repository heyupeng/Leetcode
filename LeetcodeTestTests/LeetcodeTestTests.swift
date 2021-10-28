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
            print("\(BinarySearch().test1())")
        }
    }
}
