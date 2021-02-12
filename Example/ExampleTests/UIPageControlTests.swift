//
//  UIPageControlTests.swift
//  ExampleTests
//
//  Created by Lu Hao on 2021/2/12.
//  Copyright © 2021 Shai Mishali. All rights reserved.
//

import XCTest
import Combine
@testable import CombineCocoa

class UIPageControlTests: XCTestCase {

    func test_pageControl() {

        let maxPageCount = 10

        let pc = UIPageControl()
        pc.numberOfPages = maxPageCount

        var values = [Int]()

        let sub = pc.currentPagePublisher.sink { values.append($0) }

        for page in 1..<maxPageCount {
            pc.currentPage = page
        }

        XCTAssertEqual(values, Array(0..<maxPageCount))

        sub.cancel()
    }
}
