//
//  LinearSearchTest.swift
//  swiftDSATests
//
//  Created by Raymond Moay on 1/8/23.
//

import XCTest
@testable import swiftDSA

final class SearchTest: XCTestCase {
    
    var sut: SearchAlgo?

    override func setUpWithError() throws {
        sut = SearchAlgo()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLinearSearch() {
        let haystack = [1,2,3,4,5]
        
        guard let sut = sut else {
            return
        }
        
        XCTAssertTrue(sut.linearSearch(needle: 5, haystack: haystack))
        XCTAssertTrue(sut.linearSearch(needle: 1, haystack: haystack))
        XCTAssertTrue(sut.linearSearch(needle: 3, haystack: haystack))
        XCTAssertFalse(sut.linearSearch(needle: 6, haystack: haystack))
    }
    
    func testBinarySearch() {
        let haystack = [1,2,3,4,5]
        
        guard let sut = sut else {
            return
        }
        
        XCTAssertTrue(sut.binarySearch(needle: 5, haystack: haystack))
        XCTAssertTrue(sut.binarySearch(needle: 1, haystack: haystack))
        XCTAssertTrue(sut.binarySearch(needle: 3, haystack: haystack))
        XCTAssertFalse(sut.binarySearch(needle: 6, haystack: haystack))
    }

}
