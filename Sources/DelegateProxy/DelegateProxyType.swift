//
//  DelegateProxyType.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25.09.19.
//

import Foundation

private var associatedKey: UInt8 = 123

public protocol DelegateProxyType {
    associatedtype Object

    func setDelegate(to object: Object)
}

public extension DelegateProxyType where Self: DelegateProxy {

    static func createDelegateProxy(for object: Object) -> Self {
        let delegateProxy: Self

        if let associatedObject = objc_getAssociatedObject(object, &associatedKey) as? Self {
            delegateProxy = associatedObject
        } else {
            delegateProxy = .init()
            objc_setAssociatedObject(object, &associatedKey, delegateProxy, .OBJC_ASSOCIATION_RETAIN)
        }

        delegateProxy.setDelegate(to: object)

        return delegateProxy
    }
}

