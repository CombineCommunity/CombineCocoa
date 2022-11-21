//
//  UITabBar+Combine.swift
//  CombineCocoa
//
//  Created by TaeHyeongKim on 2021/10/21.
//


#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
public extension UITabBar {

    /// Combine wrapper for `tabBar(_:didSelect:)`
    var didSelectPublisher: AnyPublisher<UITabBarItem, Never> {
        let selector = #selector(UITabBarDelegate.tabBar(_:didSelect:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! UITabBarItem }
            .eraseToAnyPublisher()
    }

    private var delegateProxy: UITabBarProxy {
        .createDelegateProxy(for: self)
    }

}

@available(iOS 13.0, *)
private class UITabBarProxy: DelegateProxy, UITabBarDelegate, DelegateProxyType {
    func setDelegate(to object: UITabBar) {
        object.delegate = self
    }
}
#endif
