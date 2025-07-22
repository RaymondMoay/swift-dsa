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
        data.append(value)
        heapifyUp(idx: length)
        length += 1
    }
    
    func delete() -> Int? {
        guard length > 0 else { return nil }
        
        let value = data[0]
        length -= 1
        
        if length == 0 {
            data = []
            return value
        }
        
        data.swapAt(0, length)
        heapifyDown(idx: 0)
        return value
    }
    
    private func heapifyUp(idx: Int) {
        if idx == 0 {
            return
        }
        
        let parentIdx = self.parent(idx: idx)
        let parentValue = self.data[parentIdx]
        let currValue = self.data[idx]
        
        if parentValue > currValue {
            self.data.swapAt(parentIdx, idx)
            heapifyUp(idx: parentIdx)
        }
    }
    
    private func heapifyDown(idx: Int) {
        let leftIdx = self.leftChild(idx: idx)
        let rightIdx = self.rightChild(idx: idx)
        
        if idx >= length || leftIdx >= length {
            return
        }
        
        if rightIdx >= length {
            data.swapAt(leftIdx, idx)
            heapifyUp(idx: leftIdx)
            return
        }
        
        let leftValue = self.data[leftIdx]
        let rightValue = self.data[rightIdx]
        let value = self.data[idx]
        
        if leftValue > rightValue && rightValue < value {
            data.swapAt(rightIdx, idx)
            heapifyDown(idx: rightIdx)
        }
        
        if rightValue > leftValue && leftValue < value {
            data.swapAt(leftIdx, idx)
            heapifyDown(idx: leftIdx)
        }
    }
    
    private func parent(idx: Int) -> Int {
        (idx - 1) / 2
    }
    
    private func leftChild(idx: Int) -> Int {
        return 2 * idx + 1
    }
    
    private func rightChild(idx: Int) -> Int {
        return 2 * idx + 2
    }
}
