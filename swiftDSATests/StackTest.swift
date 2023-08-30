//
//  StackTest.swift
//  swiftDSATests
//
//  Created by Raymond Moay on 30/8/23.
//

import XCTest
@testable import swiftDSA

final class StackTest: XCTestCase {
    
    var sut: Stack<Int>?

    override func setUpWithError() throws {
        let headNode = Node(value: 5, prev: Node(value: 4, prev: Node(value: 3, prev: Node(value: 2, prev: Node(value: 1)))))
        sut = Stack(length: 5, head: headNode)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testPush() {
        guard var sut = sut else {
            return
        }
        
        sut.push(val: 6)
        XCTAssertEqual(sut.length, 6)
        
        sut.push(val: 7)
        XCTAssertEqual(sut.length, 7)
    }
    
    func testPop() {
        guard var sut = sut else {
            return
        }
        
        let poppedValue = sut.pop()
        
        XCTAssertEqual(poppedValue, 5)
        XCTAssertEqual(sut.length, 4)
    }
    
    func testPeek() {
        guard let sut = sut else {
            return
        }
        
        let peekedValue = sut.peek()
        
        XCTAssertEqual(peekedValue, 5)
    }

}
