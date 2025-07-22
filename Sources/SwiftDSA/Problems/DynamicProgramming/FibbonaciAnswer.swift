//
//  FibbonaciAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 28/6/25.
//

struct FibbonaciAnswer {
    
    /// [1,1,2,3,5,8,13...]
    static func perform(_ n: Int) -> Int {
        
        var memo = Array(repeating: -1, count: n + 1)
        
        func fib(n: Int) -> Int {
            var result = 0
            
            if memo[n] != -1 {
                return memo[n]
            }
            
            if n == 1 || n == 2 {
                result = 1
            } else {
                result = fib(n: n - 1) + fib(n: n - 2)
            }
            
            memo[n] = result
            return result
        }
        
        return fib(n: n)
    }
}
