//
//  UIScrollView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 09/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import UIKit
import Combine

public extension UIScrollView {
    /// A publisher emitting content offset changes from this UIScrollView.
    var contentOffsetPublisher: AnyPublisher<CGPoint, Never> {
        publisher(for: \.contentOffset)
            .eraseToAnyPublisher()
    }

    /// A publisher emitting if the bottom of the UIScrollView is reached.
    ///
    /// - parameter offset: A threshold indicating how close to the bottom of the UIScrollView this publisher should emit.
    ///                     Defaults to 0
    /// - returns: A publisher that emits when the bottom of the UIScrollView is reached within the provided threshold.
    func reachedBottomPublisher(offset: CGFloat = 0) -> AnyPublisher<Void, Never> {
        contentOffsetPublisher
            .map { [weak self] contentOffset -> Bool in
                guard let self = self else { return false }
                let visibleHeight = self.frame.height - self.contentInset.top - self.contentInset.bottom
                let y = contentOffset.y + self.contentInset.top
                let threshold = max(offset, self.contentSize.height - visibleHeight)
                return y > threshold
            }
            .removeDuplicates()
            .filter { $0 }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
