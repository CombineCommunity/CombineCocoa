//
//  UISlider+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import Combine
import UIKit

public extension UISlider {
    /// A publisher emitting value changes for this slider.
    var valuePublisher: AnyPublisher<Float, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.value)
                  .eraseToAnyPublisher()
    }
}
