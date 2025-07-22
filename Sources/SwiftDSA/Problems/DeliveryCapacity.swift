//
//  DeliveryCapacity.swift
//  SwiftDSA
//
//  Created by Ray on 7/7/25.
//

struct DeliveryCapacity {
    
    /// Orders: [ [1, 4], [2, 3], [3, 5], [5, 7] ]
    /// k: 2
    ///
    /// This means we pick:
    /// - at 1 - yes, pick first order
    /// - at 2 - do i still have capcity? if so, yes
    static func perform(orders: [[Int]], k: Int) -> Int {
        
        var bag: [[Int]] = []
        var noOrdersPicked: Int = 0
        
        for order in orders {
            let currentTime = order[0]
            
            // at this time, do I have orders to end?
            for (index, item) in bag.enumerated() {
                let endTime = item[1]
                if endTime <= currentTime {
                    // remove from bag at index
                    bag[index] = [] // empty is cleared!
                }
            }
            
            bag = bag.filter { $0.isEmpty == false }
            
            // at this time, can I pick this order?
            
            if bag.count < k {
                bag.append(order)
                noOrdersPicked += 1
            }
        }
        
        return noOrdersPicked
    }
}
