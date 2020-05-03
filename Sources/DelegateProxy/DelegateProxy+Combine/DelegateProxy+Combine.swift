//
//  DelegateProxy+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public extension DelegateProxy {
    func interceptSelectorPublisher(_ selector: Selector) -> AnyPublisher<[Any], Never> {
        DelegateProxyPublisher<[Any]> { subscriber in
            return self.intercept(selector) { args in
                _ = subscriber.receive(args)
                subscriber.receive(completion: .finished)
            }
        }.eraseToAnyPublisher()
    }
}
