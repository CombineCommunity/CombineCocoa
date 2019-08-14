//
//  UIRefreshControl+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import Combine
import UIKit

public extension UIRefreshControl {
    /// A publisher emitting refresh status changes from this refresh control.
    var isRefreshingPublisher: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.isRefreshing)
                  .eraseToAnyPublisher()
    }
}
