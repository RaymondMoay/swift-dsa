/*

 Mock Interview — Heap / Priority Queue Flavour

 ────────────────────────────────────────────────────────────────────────────

 Problem: Busiest Meeting Room

 You are designing the scheduler for an office that has `n` meeting rooms,
 numbered from `0` to `n - 1`.

 You are also given a list `meetings`, where each entry
 `meetings[i] = [start_i, end_i]` represents a meeting that is requested to
 run during the half-open interval `[start_i, end_i)`. All `start_i` values
 are distinct.

 Meetings are processed in order of their *original* `start_i` time, and are
 assigned to rooms according to the following rules:

   1. Each meeting keeps its original duration: `end_i - start_i`.

   2. When a meeting is processed, if there is at least one room that is
      free at that moment, the meeting is held in the FREE ROOM WITH THE
      LOWEST NUMBER.

   3. If every room is busy, the meeting is DELAYED until the earliest
      moment any room becomes free. It is then held in that room. If
      multiple rooms free up at the same moment, the one with the LOWEST
      NUMBER is used. The meeting's duration is unchanged — only its start
      is pushed back.

   4. A delayed meeting does NOT change the order in which subsequent
      meetings are processed. The next meeting in the original `meetings`
      list is still processed next (so a meeting that was originally later
      can finish earlier than one that was delayed).

 Return the number of the room that hosted the MOST meetings. If two or
 more rooms tied for the most meetings, return the one with the LOWEST
 number.

 ────────────────────────────────────────────────────────────────────────────

 Example 1:
   n = 2
   meetings = [[0, 10], [1, 5], [2, 7], [3, 4]]

   - Meeting [0,10]  -> room 0 free, take room 0. Room 0 busy until 10.
   - Meeting [1, 5]  -> room 1 free, take room 1. Room 1 busy until 5.
   - Meeting [2, 7]  -> both busy. Next free is room 1 at time 5.
                       Delay to [5, 10) in room 1. Room 1 busy until 10.
   - Meeting [3, 4]  -> both busy. Both free at 10 — pick room 0.
                       Delay to [10, 11) in room 0. Room 0 busy until 11.

   Room 0 hosted 2 meetings, room 1 hosted 2 meetings. Tie -> return 0.

   Answer: 0

 Example 2:
   n = 3
   meetings = [[1, 20], [2, 10], [3, 5], [4, 9], [6, 8]]

   - [1,20]  -> room 0, busy until 20.
   - [2,10]  -> room 1, busy until 10.
   - [3, 5]  -> room 2, busy until 5.
   - [4, 9]  -> all busy. Earliest free: room 2 at 5. Delay to [5, 10) in room 2.
   - [6, 8]  -> all busy. Earliest free: rooms 1 and 2 both at 10. Pick room 1.
                Delay to [10, 12) in room 1.

   Room counts: 0->1, 1->2, 2->2. Tie between 1 and 2 -> return 1.

   Answer: 1

 ────────────────────────────────────────────────────────────────────────────

 Constraints:
   - 1 <= n <= 100
   - 1 <= meetings.length <= 10^5
   - 0 <= start_i < end_i <= 5 * 10^5
   - All start_i are unique.

 ────────────────────────────────────────────────────────────────────────────

 Write a function with the signature you think fits best, then walk me
 through your approach before coding. Talk through your data structures
 and time/space complexity as you go.

 */

import Foundation

// Goal: find the room that serves the most meetings

// n = number of rooms
// meetings = array of meetings

func maxMeetings(rooms n: Int, meetings: [[Int]]) -> Int {

  // There are n number of rooms, the way they should be picked, is 2 conditions:
    // - Available
    // - Lowest number

  // Naively, if there are 3 rooms in an "available" array, say [1, 2, 3], we would always have to sort the room by number whenever we add to it.
  // this amounts to, if we use the best sorting algorithm, at best O(nlog(n)) everytime we append and sort. Therefore, we should use a min heap
  // priority queue here to mantain an "available" room queue. Whenever a room is made available, pop it back to that queue. O(log(n)) operation.

  // I do not want to progress / walk / iterate by timing, because the constraint limits it to 5 * 10^5, which is a massive walk.
  // Instead, we would progress the timing to the next best available timing as we walk through the meetings.

  // Proposed solution: Mantain 2 min heaps (1) available, ranked by n, and (2) taken ranked by earliest available time
  // Walk through each meeting, and first, manage the heaps, then assign the meeting to:
  // (1) If available room, assign to room: dequeue the room out of the available queue, assign it a earliest availble time value, and enqueue it into the taken queue
  // (2) Otherwise, dequeue the room out of the taken queue, update the earliest available time value (add duration of the meeting)
  // In (1) and (2), we would increment the value in a lookup table, to calculate how many meetings a room took on

  // Total runtime: O(meetings * 2log(n)) -> because we loop through every meeting, and in each iteration, we will assign. Assignment of room, is a dequeue + enqueue, so 2*log(n).

  var counter: [Int] = Array(repeating: 0, count: n)
  var availableHeap = AvailableMinHeap()
  var takenHeap = TakenMinHeap()

  for r in 0..<n {
    availableHeap.enqueue(Room(n: r)) // seed
  }

  for meeting in meetings {
    let currentTime = meeting[0]

    // 1. clean up heaps

    var earliestEndAt = takenHeap.peek()?.endAt ?? Int.max
    while currentTime >= earliestEndAt {
      // dequeue from taken heap
      // enqueue into available heap
      availableHeap.enqueue(takenHeap.dequeue())
      earliestEndAt = takenHeap.peek()?.endAt ?? Int.max
    }

    // 2. assign rooms
    if let availableRoom = availableHeap.dequeue() {
      counter[availableRoom.n] += 1
      availableRoom.endAt = meeting[1]
      takenHeap.enqueue(availableRoom)
    } else let takenRoom = takenHeap.dequeue() {
      counter[takenRoom.n] += 1
      takenRoom.endAt += meeting[1] - meeting[0] // add the difference
      takenHeap.enqueue(takenRoom)
    }
  }

  let max = counter.max()
  return counter.index(of: max) // pseudo code, not enough time, but the idea is there. 
}

class Room {
  var n: Int
  var endAt: Int

  init(n: Int, endAt: Int = 0) {
    self.n = n
    self.endAt = endAt
  }
}

class AvailableMinHeap {

  var container: [Room] = []

  func enqueue(_ room: Room) {
    container.append(room)
    heapifyUp(container.count - 1)
  }

  func dequeue() -> Room? {
    guard container.count > 0 else { return nil }
    container.swapAt(0, container.count - 1)
    let room = container.removeLast()
    heapifyDown(0)
    return room
  }

  // MARK: Helpers

  private func heapifyUp(_ id: Int) {
    let parentIdx = parentIndex(of: id)
    let parentValue = container[parentIdx].n
    let value = container[id].n

    if parentValue > value {
      container.swapAt(parentIdx, id)
      heapifyUp(parentIdx)
    }
  }

  private func heapifyDown() {
    // heapify down logic for min heap
    // compares left and right child (if exists), pick the smaller of both
    // then compare value, and swap if value > chosenValue
  }

  private func parentIndex(of id: Int) -> Int {
    (i - 1) / 2
  }

  private func leftChildIndex(of id: Int) -> Int {
    2*i + 1
  }

  private func rightChildIndex(of id: Int) -> Int {
    2*i + 2
  }
}

class TakenMinHeap {

  var container: [Room] = []

  func peek() -> Room? {
    guard container.count > 0 else { return nil }
    return container[0]
  }

  func enqueue(_ room: Room) {
    container.append(room)
    heapifyUp(container.count - 1)
  }

  func dequeue() -> Room {
    container.swapAt(0, container.count - 1)
    let room = container.removeLast()
    heapifyDown(0)
    return room
  }

  // MARK: Helpers

  private func heapifyUp(_ id: Int) {
    let parentIdx = parentIndex(of: id)
    let parentValue = container[parentIdx].endAt
    let value = container[id].endAt

    if parentValue > value {
      container.swapAt(parentIdx, id)
      heapifyUp(parentIdx)
    } else if parentValue == value {
      if container[parentIdx].n > container[id].n {
        container.swapAt(parentIdx, id)
        heapifyUp(parentIdx)
      }
    }
  }

  private func heapifyDown() {
    // heapify down logic for min heap
    // compares left and right child (if exists), pick the smaller of both
    // then compare value, and swap if value > chosenValue
    // BONUS for taken heap: compare endAt, then if similar, compare n
  }

  private func parentIndex(of id: Int) -> Int {
    (i - 1) / 2
  }

  private func leftChildIndex(of id: Int) -> Int {
    2*i + 1
  }

  private func rightChildIndex(of id: Int) -> Int {
    2*i + 2
  }
}
