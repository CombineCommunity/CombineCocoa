//
//  UISwitch+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Combine
import UIKit

public extension UISwitch {
    /// A publisher emitting on status changes for this switch.
    var isOnPublisher: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.isOn)
                  .eraseToAnyPublisher()
    }
}
