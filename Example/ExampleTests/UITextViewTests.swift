//
//  UITextViewTests.swift
//  ExampleTests
//
//  Created by Shai Mishali on 10/08/2020.
//  Copyright © 2020 Shai Mishali. All rights reserved.
//

import XCTest
import Combine
@testable import CombineCocoa

class UITextViewTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()

    override func tearDown() {
        subscriptions = .init()
    }

    func test_valuePublisher() {
        let tv = UITextView(frame: .zero)
        var values = [String?]()

        tv.valuePublisher
          .sink(receiveValue: { values.append($0) })
          .store(in: &subscriptions)

        tv.text = "hey"
        tv.text = "hey ho"
        tv.text = "test"
        tv.text = "shai"
        tv.text = ""

        XCTAssertEqual(values, ["", "hey", "hey ho", "test", "shai", ""])
    }
}
