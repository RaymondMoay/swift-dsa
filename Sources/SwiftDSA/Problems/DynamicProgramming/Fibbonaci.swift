//
//  Fibbonaci.swift
//  SwiftDSA
//
//  Created by Ray on 27/6/25.
//

struct Fibbonaci {
    
    static func performTopDown(_ n: Int) -> Int {
        
        var memo: [Int] = Array(repeating: -1, count: n)
        
        func getFib(i: Int) -> Int {
            var result: Int = 0
            if memo[i] != -1 {
                return memo[i]
            }
            
            if i == 0 || i == 1 {
                result = 1
            } else {
                result = getFib(i: i - 1) + getFib(i: i - 2)
            }
            memo[i] = result
            return result
        }
        
        return getFib(i: n - 1)
    }
    
    static func performBottomUpWithTabulation(_ n: Int) -> Int {
        
        var memo = Array(repeating: -1, count: n)
        
        for i in 1...n {
            var result: Int = 0
            if (i == 1 || i == 2) {
                result = 1
            } else {
                result = memo[i-1-1] + memo[i-2-1]
            }
            memo[i-1] = result
        }
        return memo[n - 1]
    }
    
    static func performNoMemory(_ n: Int) -> Int {
        if n <= 2 { return 1 }
        
        var a = 0
        var b = 1
        for _ in 3...n {
            let temp = b
            b += a
            a = temp
        }
        
        return a + b
    }
}

/// 1. Recursive Backtracking
/// 2. Top down DP using memoisation
/// 3. Bottom-up DP, tabulation
/// 4. Bottom-up, no memory, DP
