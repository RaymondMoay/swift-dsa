//
//  TaskScheduler.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//
//  LC 621 — Task Scheduler
//
//  You are given an array of CPU `tasks` (each represented by a Character) and
//  a non-negative integer `n` representing the cooldown period between two
//  *same* tasks. Each task takes one unit of time per execution. After
//  executing a task, the CPU must wait at least `n` units before running that
//  *same* task again — but it is free to run a different task, or stay idle.
//
//  Return the minimum number of time units required to finish all tasks.
//
//  Example:
//    Input:  tasks = ["A","A","A","B","B","B"], n = 2
//    Output: 8
//    One valid schedule:  A → B → idle → A → B → idle → A → B
//
//    Input:  tasks = ["A","A","A","B","B","B"], n = 0
//    Output: 6   (no cooldown, just run them back-to-back)
//
//    Input:  tasks = ["A","A","A","A","A","A","B","C","D","E","F","G"], n = 2
//    Output: 16
//
//  Constraints:
//    - 1 <= tasks.count <= 10^4
//    - tasks[i] is an uppercase English letter.
//    - 0 <= n <= 100
//
//  Hints:
//    - The greedy intuition: at every tick, run the task with the highest
//      *remaining* count that is not currently on cooldown. A max-heap keyed
//      on remaining count gives you that in O(log k) where k <= 26.
//    - Track tasks in cooldown with a FIFO queue of `(remainingCount, readyAt)`.
//      When a task's `readyAt` reaches the current time, push it back into the
//      heap. This is the textbook heap + queue combo.
//    - Time advances by 1 per loop iteration whether or not work was done —
//      idle ticks still count toward the answer.
//
//  Target:
//    Time:  O(T) where T is the total runtime (bounded by tasks.count * (n+1))
//    Space: O(1) — alphabet is bounded at 26 distinct task types.
//
//  Why this models a real payments problem:
//    Immediate-payment jobs must leapfrog less urgent ones (analytics uploads,
//    receipt sync) on a shared queue, but cannot monopolise a downstream
//    rate-limited resource — the cooldown `n` models exactly that limit.
//
//  Stretch:
//    - There is an O(N) closed-form solution: `max(tasks.count, (maxCount-1) *
//      (n+1) + numTasksAtMaxCount)`. Mention it. The heap solution is the
//      "design pattern" answer the interviewer is testing for, but knowing the
//      formula shows you have done the math too.

struct TaskScheduler {

    /// Returns the minimum number of time units to finish `tasks` given a
    /// cooldown of `n` between two same-type tasks.
    static func leastInterval(_ tasks: [Character], n: Int) -> Int {
        
        // For every character, create a node to represent them.
        // Node will have: (1) character (2) amount - we prioritize highest amount, but in a fn of n
        // n = 2. Keep track of each item's last run timeframe using a map? [Character: Int]
        
        /// ["A","A","A","B","B"]
        ///
        /// A - 3
        /// B - 2
        ///
        /// A-B
        ///
        /// First iteration:
        ///
        /// A - 2
        /// B - 2
        /// cooldown[A] += n
        ///
        /// During iteration, if cooldown[A] == 0, pop A. What do we choose? We chose the one where cooldown is the minimum...
        ///
        /// 1. Pick the longest character to run first
        /// 2. Min heap, prioritized by cooldown
        ///
        /// Whenever we pop, we add it back to the queue.
        ///
        /// Ones on top, have highest qty + lowest cooldown
        ///
        /// While loop to pop everything off the queue IF head.cooldown == 0. Otherwise, if head.cooldown != 0, we will advance the time by 1 (idle)
        ///
        /// 1: A (qty: 3, c: 0)     B (qty: 2, c:0)     -> Head = A -> Pick A
        /// 2. A (qty: 2, c: 2)     B (qty: 2, c:0)     -> Head = B -> Pick B
        ///
        /// When popping the head, we take A out of the max heap.
        /// We do NOT add A back, until cooldown has subsided
        /// Max Heap only considers quantity to rank.
        /// While `completed < task.length` continue
        ///     - if heap is empty, advance and do nothing
        ///     - keep going until completed == task.length
        
        // 1. Create Max Heap
        // 2. While loop and advance time
        // 3. Return time
        
        class MaxHeap {
            
            class Node {
                let value: Character
                var amount: Int
                
                init(value: Character, amount: Int) {
                    self.value = value
                    self.amount = amount
                }
            }
            
            var container: [Node] = []
            var length: Int = 0
            
            func enqueue(_ node: Node) {
                container.append(node)
                length += 1
                heapifyUp(container.count - 1)
            }
            
            func dequeue() -> Node? {
                container.swapAt(0, container.count - 1)
                let returnNode = container.popLast()
                length -= 1
                heapifyDown(0)
                return returnNode
            }
            
            // MARK: Helpers
            
            private func heapifyUp(_ i: Int) {
                let parentIdx = parentIdx(i)
                let parentValue = container[parentIdx].amount
                let value = container[i].amount
                
                if parentValue < value {
                    container.swapAt(parentIdx, i)
                    heapifyUp(parentIdx)
                }
            }
            
            private func heapifyDown(_ i: Int) {
                let leftIdx = lChildIdx(i)
                let rightIdx = rChildIdx(i)
                
                if leftIdx >= length {
                    return
                }
                
                let leftVal = container[leftIdx].amount
                let value = container[i].amount
                
                if rightIdx >= length && value < leftVal {
                    container.swapAt(leftIdx, i)
                    heapifyDown(leftIdx)
                    return
                }
                
                let rightVal = container[rightIdx].amount
                
                if rightVal > leftVal && value < rightVal {
                    container.swapAt(rightIdx, i)
                    heapifyDown(rightIdx)
                } else if leftVal > rightVal && value < leftVal {
                    container.swapAt(leftIdx, i)
                    heapifyDown(leftIdx)
                }
            }
            
            private func parentIdx(_ i: Int) -> Int {
                (1 - i) / 2
            }
            
            private func lChildIdx(_ i: Int) -> Int {
                2 * i + 1
            }
            
            private func rChildIdx(_ i: Int) -> Int {
                2 * i + 2
            }
        }
        
        let pQueue = MaxHeap()
        var remainingCount: [Character: Int] = [:]
        var cooldownCount: [Character: Int] = [:]
        var safeStorage: [Character: MaxHeap.Node] = [:]
        
        for task in tasks {
            if let currentCount = remainingCount[task] {
                remainingCount[task] = currentCount + 1
            } else {
                remainingCount[task] = 1
            }
        }
        
        for (key, value) in remainingCount {
            pQueue.enqueue(MaxHeap.Node(value: key, amount: value))
        }
        
        var currentTime = 1
        var taskCompleted = 0
        
        while taskCompleted <= tasks.count {
            guard let node = pQueue.dequeue() else {
                currentTime += 1
                continue
            }
            safeStorage[node.value] = node
            cooldownCount[node.value] = n
            taskCompleted += 1
            
            // housekeeping
            currentTime += 1
            for (key, value) in cooldownCount { // decrement cooldown period
                let newValue = max(0, value - 1)
                if newValue == 0 {
                    pQueue.enqueue(safeStorage[key]!)
                }
                cooldownCount[key] = newValue
            }
        }
        
        return currentTime
    }
}
