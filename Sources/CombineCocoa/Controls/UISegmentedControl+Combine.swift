//
//  UISegmentedControl+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
public extension UISegmentedControl {
    /// A publisher emitting selected segment index changes for this segmented control.
    var selectedSegmentIndexPublisher: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.selectedSegmentIndex)
                  .eraseToAnyPublisher()
    }
}
#endif
