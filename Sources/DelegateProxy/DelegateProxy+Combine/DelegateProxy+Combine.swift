//
//  DelegateProxy+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation
import Combine

public extension DelegateProxy {
    func interceptSelectorPublisher(_ selector: Selector) -> AnyPublisher<[Any], Never> {
        let publisher = DelegateProxyPublisher<[Any]> { subscriber in
            return self.intercept(selector) { args in
                _ = subscriber.receive(args)
                subscriber.receive(completion: .finished)
            }
        }
        return publisher.eraseToAnyPublisher()
    }
}
