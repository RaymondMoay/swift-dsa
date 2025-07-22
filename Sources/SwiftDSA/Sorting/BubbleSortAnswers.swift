//
//  BubbleSortAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 21/6/25.
//

struct BubbleSortAnswers {
    
    static func perform(array: [Int]) -> [Int] {
        
        var mutableArray = array
        let n = mutableArray.count
        for i in 0..<n { // we need to loop through n times
            var swapped: Bool = false
            for j in 0..<(n - 1 - i) { // and we always ignore the last item as the last item progressively gets sorted as the largest
                if mutableArray[j] > mutableArray[j + 1] { // indexing won't fail here, since its always below N
                    mutableArray.swapAt(j, j + 1) // we can optimize this further by checking if any swap was done in a pass.
                    swapped = true
                }
            }
            if !swapped { break }
        }
        return mutableArray
    }
}
