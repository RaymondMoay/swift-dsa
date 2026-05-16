/*
 ─────────────────────────────────────────────────────────────────────────────
 Problem: Maximum Sum Submatrix
 ─────────────────────────────────────────────────────────────────────────────

 You are given an `m x n` matrix of integers, `matrix`. The matrix may contain
 positive numbers, negative numbers, and zeros.

 Return the maximum possible sum of any non-empty, contiguous rectangular
 submatrix.

 A "submatrix" is defined by choosing:
   • a top row    r1   (0 <= r1 <= r2 < m)
   • a bottom row r2
   • a left col   c1   (0 <= c1 <= c2 < n)
   • a right col  c2

 ...and summing every cell inside that rectangle (inclusive on all sides).

 ─────────────────────────────────────────────────────────────────────────────
 Examples
 ─────────────────────────────────────────────────────────────────────────────

   Input:
     matrix = [
       [ 1, -2,  0,  3],
       [-1,  4, -1,  2],
       [ 3, -2,  5, -3],
       [ 2,  1, -4,  1],
     ]
   Output: 9
   Explanation: The submatrix spanning rows 1..2 and columns 1..2
                 [[ 4, -1],
                  [-2,  5]]
                ... actually sums to 6. The true best is rows 1..2 cols 1..2
                plus extensions — work it out as part of the problem.
                (The expected return value is the maximum achievable sum.)

   Input:
     matrix = [[-3, -2, -1]]
   Output: -1
   Explanation: All values are negative. The best non-empty submatrix is the
                single cell with the largest value.

   Input:
     matrix = [[5]]
   Output: 5

 ─────────────────────────────────────────────────────────────────────────────
 Constraints
 ─────────────────────────────────────────────────────────────────────────────

   • 1 <= m, n <= 200
   • -1000 <= matrix[i][j] <= 1000
   • The submatrix must be non-empty (at least one cell).

 ─────────────────────────────────────────────────────────────────────────────
 */


func maxSubmatrixSum(matrix: [[Int]]) -> Int {
  let rows = matrix.count
  let cols = matrix[0].count

  var largestSum: Int = Int.min

  for top in 0..<rows {
    var sumArray: [Int] = Array(repeating: 0, count: cols)
    for bottom in top..<rows {
      for c in 0..<cols {
        sumArray[c] += matrix[bottom][c]
      }
      largestSum = max(largestSum, largestValue(nums: sumArray))
    }
  }

  return largestSum
}

/// 3   -2    5   -1    4    -10    2
func largestValue(nums: [Int]) -> Int {
  var runningSum: Int = 0
  var low: Int = 0
  var largest: Int = Int.min
  for n in nums {
    runningSum += n
    largest = max(runningSum - low, largest)
    low = min(low, runningSum)
  }
  return largest
}