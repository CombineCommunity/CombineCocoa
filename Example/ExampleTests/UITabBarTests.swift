//
//  UITabBarTests.swift
//  ExampleTests
//
//  Created by TaeHyeongKim on 2021/10/22.
//  Copyright © 2021 Shai Mishali. All rights reserved.
//

import XCTest
import Combine
@testable import CombineCocoa

class UITabBarTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()

    override func tearDown() {
        subscriptions = .init()
    }

    func test_didSelect() {
        let tab1 = UITabBarItem(title: "testTab_1", image: nil, tag: 0)
        let tab2 = UITabBarItem(title: "testTab_2", image: nil, tag: 1)
        let tab3 = UITabBarItem(title: "testTab_3", image: nil, tag: 2)
        let tabBar = UITabBar()
        tabBar.items = [tab1, tab2, tab3]

        var resultTabBarItem: UITabBarItem? = nil

        tabBar.didSelectPublisher
            .sink { resultTabBarItem = $0 }
            .store(in: &subscriptions)

        let givenTabBarItem = tab2
        tabBar.delegate?.tabBar?(tabBar, didSelect: tab2)

        XCTAssertEqual(resultTabBarItem, givenTabBarItem)
    }


}
