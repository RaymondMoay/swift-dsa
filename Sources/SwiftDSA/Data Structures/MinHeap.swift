//
//  MinHeap.swift
//  SwiftDSA
//
//  Created by Ray on 24/6/25.
//

class MinHeap {
    
    var length: Int
    var data: [Int]
    
    init(length: Int = 0, data: [Int] = []) {
        self.length = length
        self.data = data
    }
    
    func insert(value: Int) {
        length += 1
        data.append(value) // adding to end is O(1)
        heapifyUp(idx: length - 1)
    }
    
    func delete() -> Int? {
        guard length > 0 else { return nil }
        
        data.swapAt(length - 1, 0)
        let val = data.popLast()
        length -= 1
        
        heapifyDown(idx: 0)
        return val
    }
    
    // private methods
    
    private func parent(idx: Int) -> Int {
        (idx - 1) / 2
    }
    
    private func leftChild(idx: Int) -> Int {
        2 * idx + 1
    }
    
    private func rightChild(idx: Int) -> Int {
        2 * idx + 2
    }
    
    private func heapifyUp(idx: Int) {
        // base condition
        if idx == 0 { return }
        
        let parentIdx = parent(idx: idx)
        let parentVal = data[parentIdx]
        let val = data[idx]
        
        if parentVal < val { return }
        
        // swap and recurse
        data.swapAt(parentIdx, idx)
        heapifyUp(idx: parentIdx)
    }
    
    private func heapifyDown(idx: Int) {
        // base condition
        if idx >= length { return }
        
        let leftIdx = leftChild(idx: idx)
        let rightIdx = rightChild(idx: idx)
        
        // has child
        if leftIdx >= length { return }
        
        let leftVal = data[leftIdx]
        let val = data[idx]
        
        // only has left child
        if rightIdx >= length {
            if val > leftVal {
                data.swapAt(leftIdx, idx)
            }
            return
        }
        
        let rightVal = data[rightIdx]
        
        // recurse
        if leftVal < rightVal && val > leftVal {
            data.swapAt(leftIdx, idx)
            heapifyDown(idx: leftIdx)
        } else if rightVal < leftVal && val > rightVal {
            data.swapAt(rightIdx, idx)
            heapifyDown(idx: rightIdx)
        }
    }
}
