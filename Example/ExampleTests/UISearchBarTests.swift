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

    func test_setDelegate() {
        var subscriptions = Set<AnyCancellable>()
        let searchbar = UISearchBar()
        let delegate = StubSearchBarDelegate()

        var resultSearchText = ""

        searchbar.textDidChangePublisher
            .sink(receiveValue: { resultSearchText = $0 })
            .store(in: &subscriptions)
        
        searchbar.setDelegate(delegate)
            .store(in: &subscriptions)

        let givenSearchText = "Hello world"
        searchbar.delegate!.searchBar!(searchbar, textDidChange: givenSearchText)
        let shouldBeginEditing = searchbar.delegate!.searchBarShouldBeginEditing!(searchbar)

        XCTAssertEqual(resultSearchText, givenSearchText)
        XCTAssertEqual(shouldBeginEditing, StubSearchBarDelegate.shouldBeginEditing)
    }
}

private class StubSearchBarDelegate: NSObject, UISearchBarDelegate {
    static let shouldBeginEditing = true
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        Self.shouldBeginEditing
    }
}
