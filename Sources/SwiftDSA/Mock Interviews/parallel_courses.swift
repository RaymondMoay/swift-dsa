/*

 Mock Interview — Topological Sort Flavour

 ────────────────────────────────────────────────────────────────────────────

 Problem: Parallel Course Schedule

 You are helping a university build its course planner.

 There are `n` courses, labeled from `1` to `n`. You are given a list of
 prerequisite pairs `relations`, where each `relations[i] = [a, b]` means
 course `a` must be completed BEFORE course `b` can be taken.

 In a single semester, a student muay take any number of corses, AS LONG AS
 all prerequisites for those courses have been completed in previous
 semesters.

 Return the minimum number of semesters required to complete all `n`
 courses. If it is impossible to finish every course (because of a cycle
 in the prerequisites), return `-1`.

 ────────────────────────────────────────────────────────────────────────────

 Example 1:
   n = 3
   relations = [[1, 3], [2, 3]]

   Semester 1: take courses 1 and 2 (in parallel — no prereqs)
   Semester 2: take course 3 (both prereqs done)
   Answer: 2

 Example 2:
   n = 3
   relations = [[1, 2], [2, 3], [3, 1]]

   There is a cycle: 1 -> 2 -> 3 -> 1.
   Answer: -1

 Example 3:
   n = 5
   relations = [[1, 2], [1, 3], [3, 4], [2, 4], [4, 5]]

   Semester 1: course 1
   Semester 2: courses 2 and 3
   Semester 3: course 4
   Semester 4: course 5
   Answer: 4

 ────────────────────────────────────────────────────────────────────────────

 Constraints:
   1 <= n <= 5000
   0 <= relations.length <= 5000
   relations[i].count == 2
   1 <= relations[i][0], relations[i][1] <= n
   relations[i][0] != relations[i][1]
   All prerequisite pairs are unique.

 ────────────────────────────────────────────────────────────────────────────

 Write your solution below. Define the function signature yourself.

*/

func ways(relations: [[Int]], n: Int) -> Int {
  // 1. create an adjacency list
  // 2. At the same time, create a lookup table for: each course and its number of prerequisites
  // 3. start the BFS by seeding the queue with course with prereqs of 0

  var adjList: [[Int]] = [] // index = course, content = list of "to"s
  var lookup: [Int: Int] = [:] // [Course: Prerequisite counts]

  adjList = Array(repeating: [], count: n + 1) // +1 to allow course "1" to directly index adjList[1]

  for i in 1...n {
    lookup[i] = 0
  }

  for relation in relations { // O(relations) complexity
    lookup[relation[1]] += 1
    adjList[relation[0]].append(relation[1])
  }

  var coursesCompleted: Int = 0
  var semesters: Int = 0
  var queue: [[Int]] = [] // using array list here, assuming its a queue. In reality, this is O(n) for removeLast()

  // seed the first courses
  var startCourses: [Int] = []
  for i in 1...n {
    if lookup[i] == 0 {
      startCourses.append(i)
    }
  }

  guard !startCourses.isEmpty else { return 0 }
  
  queue.append(startCourses)

  while !queue.isEmpty { // Walk every course, so O(n)
    let courses = queue.removeFirst()
    semesters += 1

    var coursesNextSemester: [Int] = []
    for course in courses {
      coursesCompleted += 1

      let adjs = adjList[course]
      for e in adjs { // Walk edge for each course at once, O(relation)
        lookup[e] -= 1 // we completed a pre-req, so we decrement first.
        if lookup[e] == 0 { // if we completed it in the last semester, add it to the next
          coursesNextSemester.append(e)
        }
      }
    }
    if !coursesNextSemester.isEmpty {
      queue.append(coursesNextSemester)
    }
  }

  if coursesCompleted == n {
    return semesters
  } else {
    return -1
  }
}