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

class UICollectionViewTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()

    override func tearDown() {
        subscriptions = .init()
    }

    func test_didSelectItemAt() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var resultIndexPath: IndexPath? = nil

        collectionView.didSelectItemPublisher
            .sink(receiveValue: { resultIndexPath = $0 })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        collectionView.delegate!.collectionView!(collectionView, didSelectItemAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
    }

    func test_didDeselectItemAt() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var resultIndexPath: IndexPath? = nil

        collectionView.didDeselectItemPublisher
            .sink(receiveValue: { resultIndexPath = $0 })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        collectionView.delegate!.collectionView!(collectionView, didDeselectItemAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
    }

    func test_willDisplayCell() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var resultIndexPath: IndexPath? = nil
        var resultCollectioViewCell: UICollectionViewCell? = nil

        collectionView.willDisplayCellPublisher
            .sink(receiveValue: { cell, indexPath in
                resultCollectioViewCell = cell
                resultIndexPath = indexPath
            })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenCollectionViewCell = UICollectionViewCell()
        collectionView.delegate!.collectionView?(collectionView, willDisplay: givenCollectionViewCell, forItemAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultCollectioViewCell, givenCollectionViewCell)
    }

    func test_didEndDisplayingCell() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var resultIndexPath: IndexPath? = nil
        var resultCollectioViewCell: UICollectionViewCell? = nil

        collectionView.didEndDisplayingCellPublisher
            .sink(receiveValue: { cell, indexPath in
                resultCollectioViewCell = cell
                resultIndexPath = indexPath
            })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenCollectionViewCell = UICollectionViewCell()
        collectionView.delegate!.collectionView?(collectionView, didEndDisplaying: givenCollectionViewCell, forItemAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultCollectioViewCell, givenCollectionViewCell)
    }
    
    func test_didSelectItemAt_for_multiple_subscribers() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var firstResultIndexPaths = [IndexPath]()
        var secondResultIndexPaths = [IndexPath]()

        collectionView.didSelectItemPublisher
            .sink(receiveValue: { firstResultIndexPaths.append($0) })
            .store(in: &subscriptions)

        collectionView.didSelectItemPublisher
            .sink(receiveValue: { secondResultIndexPaths.append($0) })
            .store(in: &subscriptions)

        let givenIndexPath = IndexPath(row: 1, section: 0)
        collectionView.delegate!.collectionView!(collectionView, didSelectItemAt: givenIndexPath)

        XCTAssertEqual(firstResultIndexPaths, [givenIndexPath])
        XCTAssertEqual(firstResultIndexPaths, secondResultIndexPaths)
    }
}
