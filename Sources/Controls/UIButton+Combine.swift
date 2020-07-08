//
//  UIButton+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Combine
import UIKit

public extension UIButton {
    /// A publisher emitting tap events from this button.
    var tapPublisher: AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: self, events: .touchUpInside)
                  .eraseToAnyPublisher()
    }
}
