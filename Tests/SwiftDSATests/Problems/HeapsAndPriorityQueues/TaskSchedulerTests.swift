//
//  TaskSchedulerTests.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

import Testing

@testable import SwiftDSA

struct TaskSchedulerTests {

    @Test func canonicalExample() async throws {
        // A → B → idle → A → B → idle → A → B  = 8
        #expect(TaskScheduler.leastInterval(["A","A","A","B","B","B"], n: 2) == 8)
    }

    @Test func zeroCooldownRunsBackToBack() async throws {
        #expect(TaskScheduler.leastInterval(["A","A","A","B","B","B"], n: 0) == 6)
    }

    @Test func longCooldownWithDominantTask() async throws {
        // 6 A's dominate. With n=2 the optimal frame is A _ _ A _ _ A _ _ ...
        // Plenty of distinct fillers fit, but the 6 A's still force 16 ticks.
        let tasks: [Character] = ["A","A","A","A","A","A","B","C","D","E","F","G"]
        #expect(TaskScheduler.leastInterval(tasks, n: 2) == 16)
    }

    @Test func singleTask() async throws {
        #expect(TaskScheduler.leastInterval(["A"], n: 5) == 1)
    }

    @Test func allDistinctNoIdleNeeded() async throws {
        #expect(TaskScheduler.leastInterval(["A","B","C","D"], n: 2) == 4)
    }

    @Test func twoTaskTypesWithIdlesBetween() async throws {
        // n=3, two tasks of A only: A _ _ _ A = 5
        #expect(TaskScheduler.leastInterval(["A","A"], n: 3) == 5)
    }

    @Test func multipleTaskTypesTieAtMaxCount() async throws {
        // A and B both appear 3 times: A B _ A B _ A B = 8
        #expect(TaskScheduler.leastInterval(["A","A","A","B","B","B"], n: 2) == 8)
    }

    @Test func equalDistributionLargeCooldown() async throws {
        // 4 task types, 2 each, n=4. Closed form:
        //   (maxCount-1)*(n+1) + numTasksAtMaxCount = 1*5 + 4 = 9.
        // Schedule: A B C D _ A B C D = 9
        let tasks: [Character] = ["A","A","B","B","C","C","D","D"]
        #expect(TaskScheduler.leastInterval(tasks, n: 4) == 9)
    }
}
