//
//  DeliveryCapacityAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 8/7/25.
//

struct DeliveryCapacityAnswers {
    
    /// Orders: [ [1, 4], [2, 3], [3, 5], [5, 7] ]
    /// k: 2
    ///
    /// This means we pick:
    /// - at 1 - yes, pick first order
    /// - at 2 - do i still have capcity? if so, yes
    static func perform(orders: [[Int]], k: Int) -> Int {
        
        let sortedOrders = orders.sorted { $0[0] < $1[0] }
        var bag: [[Int]] = []
        var totalPicked: Int = 0
        
        for order in sortedOrders {
            
            let startTime = order[0]
            
            // 1. Check to see if i have delivered any orders?
            for (index, currentOrder) in bag.enumerated() {
                let endTime = currentOrder[1]
                if endTime <= startTime {
                    bag[index] = []
                }
            }
            
            bag = bag.filter { $0.count == 2 }
            
            // 2. Check to see if we can pick up this order
            if bag.count < k {
                bag.append(order)
                totalPicked += 1
            }
        }
        
        return totalPicked
    }
}
