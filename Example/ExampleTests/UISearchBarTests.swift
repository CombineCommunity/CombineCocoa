//
//  UISearchBarTests.swift
//  ExampleTests
//
//  Created by Kevin Renskers on 01/10/2020.
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

    func test_searchButtonClicked() {
        let searchbar = UISearchBar()

        var clicked = false

        subscription = searchbar.searchButtonClickedPublisher
            .sink(receiveValue: { clicked = true })

        searchbar.delegate!.searchBarSearchButtonClicked!(searchbar)

        XCTAssertEqual(clicked, true)
        subscription.cancel()
    }

    func test_cancelButtonClicked() {
        let searchbar = UISearchBar()

        var clicked = false

        subscription = searchbar.cancelButtonClickedPublisher
            .sink(receiveValue: { clicked = true })

        searchbar.delegate!.searchBarCancelButtonClicked!(searchbar)

        XCTAssertEqual(clicked, true)
        subscription.cancel()
    }
}
