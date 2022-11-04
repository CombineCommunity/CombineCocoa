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
    var subscriptions = Set<AnyCancellable>()
    
    override func tearDown() {
        subscriptions = .init()
    }
    
    func test_didSelectRowAt() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil

        tableView.didSelectRowPublisher
            .sink(receiveValue: { resultIndexPath = $0 })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, didSelectRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
    }

    func test_didDeselectRowAt() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil

        tableView.didDeselectRowPublisher
            .sink(receiveValue: { resultIndexPath = $0 })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, didDeselectRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
    }

    func test_willDisplayCell() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil
        var resultTableViewCell: UITableViewCell? = nil

        tableView.willDisplayCellPublisher
            .sink(receiveValue: { cell, indexPath in
                resultTableViewCell = cell
                resultIndexPath = indexPath
            })
            .store(in: &subscriptions)

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

        tableView.didEndDisplayingCellPublisher
            .sink(receiveValue: { cell, indexPath in
                resultTableViewCell = cell
                resultIndexPath = indexPath
            })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenTableViewCell = UITableViewCell()
        tableView.delegate!.tableView!(tableView, didEndDisplaying: givenTableViewCell, forRowAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultTableViewCell, givenTableViewCell)
    }

    func test_itemAccessoryButtonTapped() {
        let tableView = UITableView()

        var resultIndexPath: IndexPath? = nil

        tableView.itemAccessoryButtonTappedPublisher
            .sink(receiveValue: { resultIndexPath = $0 })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, accessoryButtonTappedForRowWith: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
    }
    
    func test_didSelectRowAt_for_multiple_subscribers() {
        let tableView = UITableView()

        var firstResultIndexPaths = [IndexPath]()
        var secondResultIndexPaths = [IndexPath]()

        tableView.didSelectRowPublisher
            .sink(receiveValue: { firstResultIndexPaths.append($0) })
            .store(in: &subscriptions)

        tableView.didSelectRowPublisher
            .sink(receiveValue: { secondResultIndexPaths.append($0) })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, didSelectRowAt: givenIndexPath)

        XCTAssertEqual(firstResultIndexPaths, [givenIndexPath])
        XCTAssertEqual(firstResultIndexPaths, secondResultIndexPaths)
    }

    func test_setDelegate() {
        let tableView = UITableView()
        let delegate = StubTableViewDelegate()

        var resultIndexPath: IndexPath? = nil

        tableView.didSelectRowPublisher
            .sink(receiveValue: { resultIndexPath = $0 })
            .store(in: &subscriptions)
        
        tableView.setDelegate(delegate)
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        tableView.delegate!.tableView!(tableView, didSelectRowAt: givenIndexPath)
        let selector = #selector(UITableViewDelegate.tableView(_:heightForRowAt:))
        let height = tableView.delegate!.tableView!(tableView, heightForRowAt: givenIndexPath)

        XCTAssertTrue(tableView.delegate!.responds(to: selector))
        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(height, StubTableViewDelegate.height)
    }
}

private class StubTableViewDelegate: NSObject, UITableViewDelegate {
    static let height = 10.0
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Self.height
    }
}
