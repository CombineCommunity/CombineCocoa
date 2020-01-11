//
//  DelegateProxyType.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

private var associatedKey = "delegateProxy"

public protocol DelegateProxyType {
    associatedtype Object

    func setDelegate(to object: Object)
}

public extension DelegateProxyType where Self: DelegateProxy {
    static func createDelegateProxy(for object: Object) -> Self {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

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

