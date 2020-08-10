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
    func test_didSelectItemAt() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var resultIndexPath: IndexPath? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = collectionView.didSelectItemPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { resultIndexPath = $0 }
            )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        collectionView.delegate!.collectionView!(collectionView, didSelectItemAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }

    func test_didDeselectItemAt() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var resultIndexPath: IndexPath? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = collectionView.didDeselectItemPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { resultIndexPath = $0 }
            )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        collectionView.delegate!.collectionView!(collectionView, didDeselectItemAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }

    func test_willDisplayCell() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var resultIndexPath: IndexPath? = nil
        var resultCollectioViewCell: UICollectionViewCell? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = collectionView.willDisplayCellPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { cell, indexPath in
                    resultCollectioViewCell = cell
                    resultIndexPath = indexPath
                }
            )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenCollectionViewCell = UICollectionViewCell()
        collectionView.delegate!.collectionView?(collectionView, willDisplay: givenCollectionViewCell, forItemAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultCollectioViewCell, givenCollectionViewCell)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }

    func test_didEndDisplayingCell() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        var resultIndexPath: IndexPath? = nil
        var resultCollectioViewCell: UICollectionViewCell? = nil
        var completion: Subscribers.Completion<Never>?

        let subscription = collectionView.didEndDisplayingCellPublisher
            .sink(
                receiveCompletion: { completion = $0 },
                receiveValue: { cell, indexPath in
                    resultCollectioViewCell = cell
                    resultIndexPath = indexPath
            }
        )

        let givenIndexPath = IndexPath(row: 1, section: 0)
        let givenCollectionViewCell = UICollectionViewCell()
        collectionView.delegate!.collectionView?(collectionView, didEndDisplaying: givenCollectionViewCell, forItemAt: givenIndexPath)

        XCTAssertEqual(resultIndexPath, givenIndexPath)
        XCTAssertEqual(resultCollectioViewCell, givenCollectionViewCell)
        XCTAssertEqual(completion, .finished)
        subscription.cancel()
    }
}
