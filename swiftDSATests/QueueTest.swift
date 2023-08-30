//
//  QueueTest.swift
//  swiftDSATests
//
//  Created by Raymond Moay on 27/8/23.
//

import XCTest
@testable import swiftDSA

final class QueueTest: XCTestCase {
    var sut: Queue<Int>?

    override func setUpWithError() throws {
        let tailNode = Node(value: 1)
        let headNode = Node(value: 5, next: Node(value: 4, next: Node(value: 3, next: Node(value: 2, next: tailNode))))
        sut = Queue(length: 5, head: headNode, tail: tailNode)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testEnqueueWithNonZeroQueue() {
        guard var sut = sut else {
            return
        }
        
        sut.enqueue(val: 0)
        XCTAssertEqual(sut.tail?.value, 0)
        sut.enqueue(val: -1)
        XCTAssertEqual(sut.tail?.value, -1)
    }
    
    func testEnqueueWithZeroInQueue() {
        var sut = Queue<Int>(length: 0)
        
        sut.enqueue(val: 5)
        XCTAssertEqual(sut.head?.value, 5)
        XCTAssertEqual(sut.tail?.value, 5)
        XCTAssertEqual(sut.peek(), 5)
        XCTAssertEqual(sut.length, 1)
    }
    
    func testDequeue() {
        guard var sut = sut else {
            return
        }
        
        XCTAssertEqual(sut.dequeue(), 5)
        XCTAssertEqual(sut.peek(), 4)
        XCTAssertEqual(sut.dequeue(), 4)
        XCTAssertEqual(sut.peek(), 3)
    }
}
