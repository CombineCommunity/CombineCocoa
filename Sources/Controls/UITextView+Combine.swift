//
//  UITextView+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 10/08/2020.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import UIKit
import Combine

public extension UITextView {
  /// A Combine publisher for the `UITextView's` value.
  ///
  /// - note: This uses the underlying `NSTextStorage` to make sure
  ///         autocorrect changes are reflected as well.
  ///
  /// - seealso: https://git.io/JJM5Q
  var valuePublisher: AnyPublisher<String?, Never> {
    Deferred { [weak textView = self] in
      textView?.textStorage
        .didProcessEditingRangeChangeInLengthPublisher
        .map { _ in textView?.text }
        .prepend(textView?.text)
        .eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
    }
    .eraseToAnyPublisher()
  }

  var textPublisher: AnyPublisher<String?, Never> { valuePublisher }
}
