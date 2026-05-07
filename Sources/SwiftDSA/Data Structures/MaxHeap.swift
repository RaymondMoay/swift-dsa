//
//  MaxHeap.swift
//  SwiftDSA
//
//  Created by Ray on 7/5/26.
//

class MaxHeap {
    
    var length: Int
    var data: [Int]
    
    init(length: Int, data: [Int]) {
        self.length = length
        self.data = data
    }
    
    func enqueue(_ value: Int) {
        length += 1
        data.append(value)
        heapifyUp(idx: length - 1)
    }
    
    func dequeue() -> Int? {
        guard length > 0 else { return nil }
        data.swapAt(0, length - 1)
        length -= 1
        let value = data.popLast()
        heapifyDown(idx: 0)
        return value
    }
    
    // private functions
    
    private func parentIndex(of idx: Int) -> Int {
        (idx - 1) / 2 // no need to floor, Int floors naturally
    }
    
    private func leftChildIndex(of idx: Int) -> Int {
        2 * idx + 1
    }
    
    private func rightChildIndex(of idx: Int) -> Int {
        2 * idx + 2
    }
    
    private func heapifyUp(idx: Int) {
        // base case
        if idx <= 0 { return }
        
        let parentIdx = parentIndex(of: idx)
        let parentVal = data[parentIdx]
        
        if parentVal >= data[idx] { return }
        
        // recurse
        data.swapAt(parentIdx, idx)
        heapifyUp(idx: parentIdx)
    }
    
    private func heapifyDown(idx: Int) {
        // base case
        if idx >= length { return } // out of bounds
        
        let leftIdx = leftChildIndex(of: idx)
        let rightIdx = rightChildIndex(of: idx)
        
        if leftIdx >= length { return } // no child / the end
        
        let val = data[idx]
        let leftVal = data[leftIdx]
        
        if rightIdx >= length { // only has left child
            if val < leftVal {
                data.swapAt(leftIdx, idx)
                heapifyDown(idx: leftIdx)
            }
            return
        }
        
        let rightVal = data[rightIdx]
        
        if leftVal > rightVal && val <= leftVal {
            data.swapAt(idx, leftIdx)
            heapifyDown(idx: leftIdx)
        } else if rightVal > leftVal && val <= rightVal {
            data.swapAt(idx, rightIdx)
            heapifyDown(idx: rightIdx)
        } else if rightVal == leftVal && val <= leftVal {
            data.swapAt(idx, leftIdx)
            heapifyDown(idx: leftIdx)
        }
    }
}
