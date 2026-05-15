//
//  CourseScheduleIITests.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

import Testing

@testable import SwiftDSA

struct CourseScheduleIITests {

    /// Verifies `order` is a valid topological ordering for the given prereqs.
    /// (Multiple valid orderings exist, so we can't compare by equality.)
    private func isValidTopologicalOrder(
        _ order: [Int],
        numCourses: Int,
        prerequisites: [[Int]]
    ) -> Bool {
        guard order.count == numCourses else { return false }
        guard Set(order).count == numCourses else { return false }

        var position: [Int: Int] = [:]
        for (i, c) in order.enumerated() { position[c] = i }

        for pair in prerequisites {
            let a = pair[0], b = pair[1]
            // b must appear before a.
            guard let pa = position[a], let pb = position[b], pb < pa else {
                return false
            }
        }
        return true
    }

    @Test func singleCourseNoPrereqs() async throws {
        let result = CourseScheduleII.perform(numCourses: 1, prerequisites: [])
        #expect(result == [0])
    }

    @Test func twoCoursesLinearChain() async throws {
        let result = CourseScheduleII.perform(numCourses: 2, prerequisites: [[1, 0]])
        #expect(result == [0, 1])
    }

    @Test func diamondDependency() async throws {
        // 0 -> 1, 0 -> 2, 1 -> 3, 2 -> 3
        let prereqs = [[1, 0], [2, 0], [3, 1], [3, 2]]
        let result = CourseScheduleII.perform(numCourses: 4, prerequisites: prereqs)
        #expect(isValidTopologicalOrder(result, numCourses: 4, prerequisites: prereqs))
    }

    @Test func directCycleReturnsEmpty() async throws {
        let result = CourseScheduleII.perform(
            numCourses: 2,
            prerequisites: [[1, 0], [0, 1]]
        )
        #expect(result == [])
    }

    @Test func longerCycleReturnsEmpty() async throws {
        // 0 -> 1 -> 2 -> 0
        let result = CourseScheduleII.perform(
            numCourses: 3,
            prerequisites: [[1, 0], [2, 1], [0, 2]]
        )
        #expect(result == [])
    }

    @Test func disconnectedGraph() async throws {
        // Components: {0 -> 1} and {2 -> 3}.
        let prereqs = [[1, 0], [3, 2]]
        let result = CourseScheduleII.perform(numCourses: 4, prerequisites: prereqs)
        #expect(isValidTopologicalOrder(result, numCourses: 4, prerequisites: prereqs))
    }

    @Test func noPrereqsAtAll() async throws {
        let result = CourseScheduleII.perform(numCourses: 3, prerequisites: [])
        #expect(Set(result) == Set([0, 1, 2]))
    }

    @Test func paymentFlowOrdering() async throws {
        // 0 = CheckBalance, 1 = ValidateBiometrics, 2 = ExecuteTransfer, 3 = SendReceipt.
        // ExecuteTransfer needs CheckBalance and ValidateBiometrics.
        // SendReceipt needs ExecuteTransfer.
        let prereqs = [[2, 0], [2, 1], [3, 2]]
        let result = CourseScheduleII.perform(numCourses: 4, prerequisites: prereqs)
        #expect(isValidTopologicalOrder(result, numCourses: 4, prerequisites: prereqs))
    }
}
