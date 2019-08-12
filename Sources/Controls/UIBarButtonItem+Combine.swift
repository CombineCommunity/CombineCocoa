//
//  UIBarButtonItem+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import Combine
import UIKit

public extension UIBarButtonItem {
  /// A publisher which emits whenever this UIBarButtonItem is tapped.
  var tapPublisher: AnyPublisher<Void, Never> {
    return TapPublisher(barButtonItem: self).eraseToAnyPublisher()
  }
}

private extension UIBarButtonItem {
  struct TapPublisher: Publisher {
    public typealias Output = Void
    public typealias Failure = Never

    private let barButtonItem: UIBarButtonItem

    public init(barButtonItem: UIBarButtonItem) {
      self.barButtonItem = barButtonItem
    }

    public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
      let subscription = Subscription(subscriber: subscriber,
                                      barButtonItem: barButtonItem)

      subscriber.receive(subscription: subscription)
    }
  }
}

// MARK: - Subscription
extension UIBarButtonItem.TapPublisher {
  private final class Subscription<S: Subscriber>: Combine.Subscription where S.Input == Void {
    private var subscriber: S?
    weak private var barButtonItem: UIBarButtonItem?

    init(subscriber: S, barButtonItem: UIBarButtonItem) {
      self.subscriber = subscriber
      self.barButtonItem = barButtonItem

      barButtonItem.target = self
      barButtonItem.action = #selector(handleTap)
    }

    func request(_ demand: Subscribers.Demand) {
      // We don't care about the demand at this point.
      // As far as we're concerned - UIBarButtonItem taps are endless until it is deallocated.
    }

    func cancel() {
      subscriber = nil
      barButtonItem?.target = nil
      barButtonItem?.action = nil
    }

    @objc private func handleTap() {
      _ = subscriber?.receive()
    }
  }
}
