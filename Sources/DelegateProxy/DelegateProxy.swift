//
//  DelegateProxy.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25.09.19.
//

import Foundation

public final class DelegateProxy: ObjCDelegateProxy {

    private var dict: [Selector: ([Any]) -> Void] = [:]

    public func intercept(_ selector: Selector, handler: @escaping ([Any]) -> Void) {
        dict[selector] = handler
    }

    

}
