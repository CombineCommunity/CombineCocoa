//
//  UIControl+Combine.swift
//  CombineCocoa
//
//  Created by Wes Wickwire on 9/23/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine)
import Combine
import UIKit

@available(iOS 13.0, *)
public extension UIControl {
    /// A publisher emitting events from this control.
    func controlEventPublisher(for events: UIControl.Event) -> AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: self, events: events)
                  .eraseToAnyPublisher()
    }
}
#endif
