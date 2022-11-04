//
//  DelegateProxyType.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Foundation
import Combine

private var associatedKey = "delegateProxy"

public protocol DelegateProxyType {
    associatedtype Object
    associatedtype Delegate

    func setDelegate(to object: Object)
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension DelegateProxyType where Self: DelegateProxy {
    static func createDelegateProxy(for object: Object) -> Self {
        let delegateProxy = proxy(for: object)

        delegateProxy.setDelegate(to: object)

        return delegateProxy
    }

    /// Sets forward delegate for `DelegateProxyType` associated with a specific object and return cancellable that can be used to unset the forward to delegate.
    ///
    /// - parameter forwardDelegate: Delegate object to set.
    /// - parameter object: Object that has `delegate` property.
    /// - returns: Cancellable object that can be used to clear forward delegate.
    static func installForwardDelegate(_ forwardDelegate: Delegate, for object: Object) -> Cancellable {
        weak var weakForwardDelegate: AnyObject? = forwardDelegate as AnyObject

        let delegateProxy = proxy(for: object)
        delegateProxy.setForwardToDelegate(forwardDelegate)

        return AnyCancellable {
            let delegate: AnyObject? = weakForwardDelegate

            assert(delegate == nil || delegateProxy.forwardToDelegate() === delegate, "Delegate was changed from time it was first set. Current \(String(describing: delegateProxy.forwardToDelegate())), and it should have been \(delegateProxy)")

            delegateProxy.setForwardToDelegate(nil)
        }
    }

    private static func proxy(for object: Object) -> Self {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        let delegateProxy: Self

        if let associatedObject = objc_getAssociatedObject(object, &associatedKey) as? Self {
            delegateProxy = associatedObject
        } else {
            delegateProxy = .init()
            objc_setAssociatedObject(object, &associatedKey, delegateProxy, .OBJC_ASSOCIATION_RETAIN)
        }

        return delegateProxy
    }

    /// Sets reference of normal delegate that receives all forwarded messages through `self`.
    ///
    /// - parameter delegate: Reference of delegate that receives all messages through `self`.
    func setForwardToDelegate(_ delegate: Delegate?) {
        self._setForwardToDelegate(delegate)
    }

    private func forwardToDelegate() -> AnyObject? {
        self._forwardToDelegate.map { $0 as AnyObject }
    }
}
#endif
