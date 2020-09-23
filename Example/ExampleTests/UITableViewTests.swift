//
//  UITableViewTests.swift
//  ExampleTests
//
//  Created by Joan Disho on 08.07.20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import XCTest
import Combine
@testable import CombineCocoa

class UITableViewTests: XCTestCase {
    var subscription: AnyCancellable!

    func test_didSelectRowAt() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil

        subscription = tableView.didSelectRowPublisher
            .sink(receiveValue: { resultIndexPath = $0 })

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, didSelectRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
    }

    func test_didDeselectRowAt() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil

        subscription = tableView.didDeselectRowPublisher
            .sink(receiveValue: { resultIndexPath = $0 })

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, didDeselectRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
    }

    func test_willDisplayCell() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil
        var resultTableViewCell: UITableViewCell? = nil

        subscription = tableView.willDisplayCellPublisher
            .sink(receiveValue: { cell, indexPath in
                resultTableViewCell = cell
                resultIndexPath = indexPath
            })

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenTableViewCell = UITableViewCell()
        tableView.delegate!.tableView!(tableView, willDisplay: givenTableViewCell, forRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultTableViewCell, givenTableViewCell)
    }

    func test_didEndDisplayingCell() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil
        var resultTableViewCell: UITableViewCell? = nil

        subscription = tableView.didEndDisplayingCellPublisher
            .sink(receiveValue: { cell, indexPath in
                resultTableViewCell = cell
                resultIndexPath = indexPath
            })

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenTableViewCell = UITableViewCell()
        tableView.delegate!.tableView!(tableView, didEndDisplaying: givenTableViewCell, forRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultTableViewCell, givenTableViewCell)
    }

    func test_itemAccessoryButtonTapped() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil

        subscription = tableView.itemAccessoryButtonTappedPublisher
            .sink(receiveValue: { resultIndexPath = $0 })

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, accessoryButtonTappedForRowWith: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
    }
}
