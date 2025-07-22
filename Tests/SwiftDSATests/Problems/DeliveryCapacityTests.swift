//
//  DeliveryCapacityTests.swift
//  SwiftDSA
//
//  Created by Ray on 7/7/25.
//

import Testing

@testable import SwiftDSA

struct DeliveryCapacityTests {
    
    @Test(arguments: [
        ([[1, 4], [2, 3], [3, 5], [5, 7]], 2, 4),
        ([[1, 4], [2, 5], [3, 5], [5, 7]], 2, 3),
        ([[1, 4], [2, 5], [3, 5], [5, 7]], 1, 2),
    ]) func assert(args: (orders: [[Int]], k: Int, count: Int)) async throws {
        #expect(DeliveryCapacity.perform(orders: args.orders, k: args.k) == args.count)
    }
}
