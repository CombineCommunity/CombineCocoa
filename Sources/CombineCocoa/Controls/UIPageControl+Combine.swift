//
//  UIPageControl+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine)
import Combine
import UIKit

@available(iOS 13.0, *)
public extension UIPageControl {
    /// A publisher emitting current page changes for this page control.
    var currentPagePublisher: AnyPublisher<Int, Never> {
        publisher(for: \.currentPage).eraseToAnyPublisher()
    }
}
#endif
