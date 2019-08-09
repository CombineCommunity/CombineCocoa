//
//  UIScrollView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 09.08.19.
//

import Foundation
import Combine

public extension UIScrollView {
    /// A publisher emitting content offset changes from this UIScrollView.
    var contentOffsetPublisher: AnyPublisher<CGPoint, Never> {
        publisher(for: \.contentOffset)
            .eraseToAnyPublisher()
    }
}
