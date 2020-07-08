//
//  UIStepper+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Combine
import UIKit

public extension UIStepper {
    /// A publisher emitting value changes for this stepper.
    var valuePublisher: AnyPublisher<Double, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.value)
                  .eraseToAnyPublisher()
    }
}
