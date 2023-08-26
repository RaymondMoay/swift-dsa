//
//  SortAlgoTest.swift
//  swiftDSATests
//
//  Created by Raymond Moay on 26/8/23.
//

import XCTest
@testable import swiftDSA

final class SortAlgoTest: XCTestCase {
    
    var sut: SortAlgo?

    override func setUpWithError() throws {
        sut = SortAlgo()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testBubbleSort() {
        let testNumbers1 = [1,3,2,7,5]
        let testNumbers2 = [1,3,3,5,9,12,0,3,4,2,7,5]
        let testNumbers3 = Array(repeating: 0, count: 10)
        
        guard let sut = sut else {
            return
        }
        
        XCTAssertEqual(sut.bubbleSort(numbers: testNumbers1), testNumbers1.sorted())
        XCTAssertEqual(sut.bubbleSort(numbers: testNumbers2), testNumbers2.sorted())
        XCTAssertEqual(sut.bubbleSort(numbers: testNumbers3), testNumbers3.sorted())
    }

}
