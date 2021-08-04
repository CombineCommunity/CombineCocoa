//
//  UIScrollViewTests.swift
//  ExampleTests
//
//  Created by 최동규 on 2021/08/05.
//  Copyright © 2021 Shai Mishali. All rights reserved.
//

import XCTest
import Combine
@testable import CombineCocoa

class UIScrollViewTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()

    override func tearDown() {
        subscriptions = .init()
    }

    func test_didScroll() {
        let scrollView = UIScrollView()

        var didScroll = false

        scrollView.didScrollPublisher
            .sink(receiveValue: { didScroll = true })
            .store(in: &subscriptions)

        scrollView.delegate!.scrollViewDidScroll!(scrollView)

        XCTAssertEqual(didScroll, true)
    }

    func test_willBeginDecelerating() {
        let scrollView = UIScrollView()

        var willBeginDecelerating = false

        scrollView.willBeginDeceleratingPublisher
            .sink(receiveValue: { willBeginDecelerating = true })
            .store(in: &subscriptions)

        scrollView.delegate!.scrollViewWillBeginDecelerating!(scrollView)

        XCTAssertEqual(willBeginDecelerating, true)
    }

    func test_didEndDecelerating() {
        let scrollView = UIScrollView()

        var didEndDecelerating = false

        scrollView.didEndDeceleratingPublisher
            .sink(receiveValue: { didEndDecelerating = true })
            .store(in: &subscriptions)

        scrollView.delegate!.scrollViewDidEndDecelerating!(scrollView)

        XCTAssertEqual(didEndDecelerating, true)
    }

    func test_willBeginDragging() {
        let scrollView = UIScrollView()

        var willBeginDragging = false

        scrollView.willBeginDraggingPublisher
            .sink(receiveValue: { willBeginDragging = true })
            .store(in: &subscriptions)

        scrollView.delegate!.scrollViewWillBeginDragging!(scrollView)

        XCTAssertEqual(willBeginDragging, true)
    }

    func test_willEndDragging() {
        let scrollView = UIScrollView()

        var resultVelocity: CGPoint? = nil
        var resultTargetContentOffset: UnsafeMutablePointer<CGPoint>? = nil

        scrollView.willEndDraggingPublisher
            .sink(receiveValue: { (velocity, targetContentOffset) in
                resultVelocity = velocity
                resultTargetContentOffset = targetContentOffset
            })
            .store(in: &subscriptions)

        let givenVelocity: CGPoint = .init(x: 42, y: 42)
        let givenTargetContentOffset: UnsafeMutablePointer<CGPoint> = UnsafeMutablePointer<CGPoint> .allocate(capacity: 1)

        defer { givenTargetContentOffset.deallocate(capacity: 1) }

        scrollView.delegate!.scrollViewWillEndDragging!(scrollView, withVelocity: givenVelocity, targetContentOffset: givenTargetContentOffset)

        XCTAssertEqual(resultVelocity, givenVelocity)
        XCTAssertEqual(resultTargetContentOffset, givenTargetContentOffset)
    }

    func test_didEndDragging() {
        let scrollView = UIScrollView()

        var resultWillDecelerate: Bool? = nil

        scrollView.didEndDraggingPublisher
            .sink(receiveValue: { resultWillDecelerate = $0 })
            .store(in: &subscriptions)

        let givenWillDecelerate = true

        scrollView.delegate!.scrollViewDidEndDragging?(scrollView, willDecelerate: givenWillDecelerate)

        XCTAssertEqual(resultWillDecelerate, givenWillDecelerate)
    }

    func test_didZoom() {
        let scrollView = UIScrollView()

        var didZoom = false

        scrollView.didZoomPublisher
            .sink(receiveValue: { didZoom = true })
            .store(in: &subscriptions)

        scrollView.delegate!.scrollViewDidZoom!(scrollView)

        XCTAssertEqual(didZoom, true)
    }

    func test_didScrollToTop() {
        let scrollView = UIScrollView()

        var didScrollToTop = false

        scrollView.didScrollToTopPublisher
            .sink(receiveValue: { didScrollToTop = true })
            .store(in: &subscriptions)

        scrollView.delegate!.scrollViewDidScrollToTop!(scrollView)

        XCTAssertEqual(didScrollToTop, true)
    }

    func test_didEndScrollingAnimation() {
        let scrollView = UIScrollView()
        
        var didEndScrollingAnimation = false

        scrollView.didEndScrollingAnimationPublisher
            .sink(receiveValue: { didEndScrollingAnimation = true })
            .store(in: &subscriptions)

        scrollView.delegate!.scrollViewDidEndScrollingAnimation!(scrollView)

        XCTAssertEqual(didEndScrollingAnimation, true)
    }

    func test_willBeginZooming() {
        let scrollView = UIScrollView()

        var resultView: UIView? = nil

        scrollView.willBeginZoomingPublisher
            .sink(receiveValue: { resultView = $0 })
            .store(in: &subscriptions)

        let givenView: UIView = UIView()

        scrollView.delegate!.scrollViewWillBeginZooming?(scrollView, with: givenView)

        XCTAssertEqual(resultView, givenView)
    }

    func test_didEndZooming() {
        let scrollView = UIScrollView()

        var resultView: UIView? = nil
        var resultScale: CGFloat? = nil

        scrollView.didEndZooming
            .sink(receiveValue: { (view, scale) in
                resultView = view
                resultScale = scale
            })
            .store(in: &subscriptions)

        let givenView: UIView = UIView()
        let givenScale: CGFloat = .zero

        scrollView.delegate!.scrollViewDidEndZooming!(scrollView, with: givenView, atScale: givenScale)

        XCTAssertEqual(resultView, givenView)
        XCTAssertEqual(resultScale, givenScale)
    }
}
