//
//  SudokuSolver.swift
//  SwiftDSA
//
//  Created by Ray on 28/6/25.
//

struct SudokuChecker {
    
    /// 9x9 sudoku
    ///
    /// The solution is to use SET to remove duplicates.
    ///
    /// Every row, column AND subbox has a its SET of 9 characters
    /// We need to loop through each item, check if it exists in all of its 3 containers, and if not, insert it in.
    static func perform(_ board: [[Character]]) -> Bool {
        
        /// 1. Each row of characters have no duplicates
        /// 2. Each column of characters have no duplicates
        /// 3. Each 3x3 subboxes contains no duplicate digits
        /// Board may be incomplete, char can be "." for empty, or "1" - "9" for values.
        
        var rows = Array(repeating: Set<Character>(), count: 9)
        var cols = Array(repeating: Set<Character>(), count: 9)
        var boxes = Array(repeating: Set<Character>(), count: 9)
        
        for row in 0..<9 {
            for col in 0..<9 {
                let val = board[row][col]
                
                if val == "." {
                    continue
                }
                
                // check row
                if rows[row].contains(val) {
                    return false
                } else {
                    rows[row].insert(val)
                }
                
                // check column
                if cols[col].contains(val) {
                    return false
                } else {
                    cols[col].insert(val)
                }
                
                // check subbox
                let idx = (row / 3) * 3 + col / 3 // trickiest part is here, how do i get this formula?
                if boxes[idx].contains(val) {
                    return false
                } else {
                    boxes[idx].insert(val)
                }
            }
        }
        
        return true
    }
}
