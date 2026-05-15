//
//  TaskSchedulerAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// Reference implementation of LC 621 — Task Scheduler.
///
/// Strategy: greedy with a max-heap + cooldown queue.
///   1. Count each task's frequency.
///   2. Push every non-zero count into a max-heap.
///   3. Each tick: pop the heaviest task; if any work remains for it, schedule
///      it to be "ready" again at `time + n + 1` via a FIFO queue.
///   4. Whenever the queue's front becomes ready, push it back into the heap.
///   5. If the heap is empty but the queue is not, the CPU idles — `time`
///      still advances.
///
/// Time:  O(T log K) where T is the total runtime and K <= 26.
/// Space: O(K) — bounded by the alphabet.
struct TaskSchedulerAnswer {

    static func leastInterval(_ tasks: [Character], n: Int) -> Int {
        var counts: [Character: Int] = [:]
        for t in tasks { counts[t, default: 0] += 1 }

        var heap = MaxCountHeap()
        for (_, c) in counts { heap.push(c) }

        // FIFO of (remainingCount, readyAtTime).
        var cooldown: [(remaining: Int, readyAt: Int)] = []
        var time = 0

        while !heap.isEmpty || !cooldown.isEmpty {
            time += 1

            if let count = heap.pop() {
                let remaining = count - 1
                if remaining > 0 {
                    cooldown.append((remaining, time + n))
                }
            }

            if let front = cooldown.first, front.readyAt == time {
                heap.push(front.remaining)
                cooldown.removeFirst()
            }
        }

        return time
    }
}

/// Max-heap of `Int`. Scoped to this file.
private struct MaxCountHeap {
    private var data: [Int] = []

    var isEmpty: Bool { data.isEmpty }

    mutating func push(_ value: Int) {
        data.append(value)
        siftUp(from: data.count - 1)
    }

    mutating func pop() -> Int? {
        guard !data.isEmpty else { return nil }
        data.swapAt(0, data.count - 1)
        let popped = data.removeLast()
        if !data.isEmpty { siftDown(from: 0) }
        return popped
    }

    private mutating func siftUp(from index: Int) {
        var i = index
        while i > 0 {
            let parent = (i - 1) / 2
            guard data[i] > data[parent] else { return }
            data.swapAt(i, parent)
            i = parent
        }
    }

    private mutating func siftDown(from index: Int) {
        var i = index
        let n = data.count
        while true {
            let left = 2 * i + 1
            let right = 2 * i + 2
            var largest = i
            if left < n, data[left] > data[largest] { largest = left }
            if right < n, data[right] > data[largest] { largest = right }
            if largest == i { return }
            data.swapAt(i, largest)
            i = largest
        }
    }
}
