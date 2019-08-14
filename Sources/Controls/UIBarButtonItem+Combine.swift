//
//  UIBarButtonItem+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import Combine
import UIKit

public extension UIBarButtonItem {
    /// A publisher which emits whenever this UIBarButtonItem is tapped.
    var tapPublisher: AnyPublisher<Void, Never> {
        Publishers.ControlTarget(control: self,
                                 addTargetAction: { control, target, action in
                                    control.target = target
                                    control.action = action
                                 },
                                 removeTargetAction: { control, _, _ in
                                    control?.target = nil
                                    control?.action = nil
                                 })
                  .eraseToAnyPublisher()
  }
}
