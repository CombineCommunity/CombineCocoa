//
//  UIPageControl+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import Combine
import UIKit

public extension UIPageControl {
    /// A publisher emitting current page changes for this page control.
    var currentPagePublisher: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.currentPage)
                  .eraseToAnyPublisher()
    }
}
