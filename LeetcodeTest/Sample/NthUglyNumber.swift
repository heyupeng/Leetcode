//
//  NthUglyNumber.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/26.
//

import UIKit

class NthUglyNumber {

    func nthUglyNumber(_ n: Int) -> Int {
                
        var db = Array(repeating: 0, count: n)
        db[0] = 1
        var f2 = 0, f3 = 0, f5 = 0
        for i in  1..<n {
            let n2 = db[f2] * 2
            let n3 = db[f3] * 3
            let n5 = db[f5] * 5
            let minimum = min(n2, n3, n5)
            db[i] = minimum
            
            if minimum == n2 { f2 += 1 }
            if minimum == n3 { f3 += 1 }
            if minimum == n5 { f5 += 1 }
        }
        return db.last!
    }
}
