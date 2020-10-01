//
//  UICollectionViewTests.swift
//  ExampleTests
//
//  Created by Joan Disho on 08.07.20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import XCTest
import Combine
@testable import CombineCocoa

class UISearchBarTests: XCTestCase {
    var subscription: AnyCancellable!

    func test_textDidChange() {
        let searchbar = UISearchBar()

        var resultSearchText = ""

        subscription = searchbar.textDidChangePublisher
            .sink(receiveValue: { resultSearchText = $0 })

        let givenSearchText = "Hello world"
        searchbar.delegate!.searchBar!(searchbar, textDidChange: givenSearchText)

        XCTAssertEqual(resultSearchText, givenSearchText)
        subscription.cancel()
    }
}
