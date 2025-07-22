//
//  Fibbonaci.swift
//  SwiftDSA
//
//  Created by Ray on 27/6/25.
//

struct Fibbonaci {
    
    /// [1,1,2,3,5,8,13...]
    static func perform(_ n: Int) -> Int {
        
        var memo: [Int] = Array(repeating: -1, count: n + 1)
        
        func getFib(_ n: Int) -> Int {
            
            if memo[n] != -1 {
                return memo[n]
            }
            
            var result = 0
            // base case
            if n == 0 {
                result = 0
            } else if n == 1 || n == 2 {
                result = 1
            } else {
                result = getFib(n - 1) + getFib(n - 2)
            }
            memo[n] = result
            return result
        }
        
        return getFib(n)
    }
}
