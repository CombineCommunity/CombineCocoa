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

  /// Combine wrapper for `textViewDidBeginEditing(_:)`
  var didBeginEditingPublisher: AnyPublisher<Void, Never> {
    let selector = #selector(UITextViewDelegate.textViewDidBeginEditing(_:))
    return delegateProxy.interceptSelectorPublisher(selector)
        .map { _ in () }
        .eraseToAnyPublisher()
  }

  /// Combine wrapper for `textViewDidEndEditing(_:)`
  var didEndEditingPublisher: AnyPublisher<Void, Never> {
    let selector = #selector(UITextViewDelegate.textViewDidEndEditing(_:))
    return delegateProxy.interceptSelectorPublisher(selector)
        .map { _ in () }
        .eraseToAnyPublisher()
  }

  /// A publisher emits on first responder changes
  var isFirstResponderPublisher: AnyPublisher<Bool, Never> {
    Just<Void>(())
      .merge(with: didBeginEditingPublisher, didEndEditingPublisher)
      .map { [weak self] in
        self?.isFirstResponder ?? false
      }
      .eraseToAnyPublisher()
  }

  @objc override var delegateProxy: DelegateProxy {
      TextViewDelegateProxy.createDelegateProxy(for: self)
  }
}

@available(iOS 13.0, *)
private class TextViewDelegateProxy: DelegateProxy, UITextViewDelegate, DelegateProxyType {
    func setDelegate(to object: UITextView) {
        object.delegate = self
    }
}
#endif
