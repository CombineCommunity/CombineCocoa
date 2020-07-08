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

    func test_didSelectRowAt() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = tableView.didSelectRowPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { resultIndexPath = $0 }
            )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, didSelectRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }

    func test_didDeselectRowAt() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = tableView.didDeselectRowPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { resultIndexPath = $0 }
            )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, didDeselectRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }

    func test_willDisplayCell() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil
        var resultTableViewCell: UITableViewCell? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = tableView.willDisplayCellPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { cell, indexPath in
                    resultTableViewCell = cell
                    resultIndexPath = indexPath
                }
            )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenTableViewCell = UITableViewCell()
        tableView.delegate!.tableView!(tableView, willDisplay: givenTableViewCell, forRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultTableViewCell, givenTableViewCell)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }

    func test_didEndDisplayingCell() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil
        var resultTableViewCell: UITableViewCell? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = tableView.didEndDisplayingCellPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { cell, indexPath in
                    resultTableViewCell = cell
                    resultIndexPath = indexPath
                }
            )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenTableViewCell = UITableViewCell()
        tableView.delegate!.tableView!(tableView, didEndDisplaying: givenTableViewCell, forRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultTableViewCell, givenTableViewCell)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }

    func test_itemAccessoryButtonTapped() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = tableView.itemAccessoryButtonTappedPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { resultIndexPath = $0 }
            )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, accessoryButtonTappedForRowWith: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }
}
