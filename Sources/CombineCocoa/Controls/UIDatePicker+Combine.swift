//
//  UIDatePicker+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
public extension UIDatePicker {
    /// A publisher emitting date changes from this date picker.
    var datePublisher: AnyPublisher<Date, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.date)
                  .eraseToAnyPublisher()
    }

    /// A publisher emitting countdown duration changes from this date picker.
    var countDownDurationPublisher: AnyPublisher<TimeInterval, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.countDownDuration)
                  .eraseToAnyPublisher()
    }
}
#endif
