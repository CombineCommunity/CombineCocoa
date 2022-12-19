//
//  UITextView+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 10/08/2020.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit
import Combine

@available(iOS 13.0, *)
public extension UITextView {
  /// A Combine publisher for the `UITextView's` value.
  ///
  /// - note: This uses the underlying `NSTextStorage` to make sure
  ///         autocorrect changes are reflected as well.
  ///
  /// - seealso: https://git.io/JJM5Q
  var textValuePublisher: AnyPublisher<String?, Never> {
    Deferred { [weak textView = self] in
      textView?.textStorage
        .didProcessEditingRangeChangeInLengthPublisher
        .map { _ in textView?.text }
        .prepend(textView?.text)
        .eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
    }
    .eraseToAnyPublisher()
  }
  
  var attributedTextValuePublisher: AnyPublisher<NSAttributedString?, Never> {
    Deferred { [weak textView = self] in
      textView?.textStorage
        .didProcessEditingRangeChangeInLengthPublisher
        .map { _ in textView?.attributedText }
        .prepend(textView?.attributedText)
        .eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
    }
    .eraseToAnyPublisher()
  }
  
  var attributedTextPublisher: AnyPublisher<NSAttributedString?, Never> { attributedTextValuePublisher }
  
  var textPublisher: AnyPublisher<String?, Never> { textValuePublisher }
}
#endif
