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

    /// A publisher emitting if the bottom of the UIScrollView is reached.
    ///- parameter offset: A threshhold indicating the bottom of the UIScrollView. Default 0.0.
    ///- returns: AnyPublisher that emits when the bottom of the UIScrollView is reached.
    func reachedBottomPublisher(offset: CGFloat = 0.0) -> AnyPublisher<Void, Never> {
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
