//
//  ExamAnkiTests.swift
//  ExamAnkiTests
//
//  Created by kongyunpeng on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import XCTest
@testable import ExamAnki
class ExamAnkiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
          let seg = EAPAbstractSegmentedControl.createSegmentedControl(["a","b","c"])
        XCTAssertEqual(seg, nil, "passed")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
