//
//  UISegmentedControl+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import Combine
import UIKit

public extension UISegmentedControl {
    /// A publisher emitting selected segment index changes for this segmented control.
    var selectedSegmentIndexPublisher: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.selectedSegmentIndex)
                  .eraseToAnyPublisher()
    }
}
