//
//  DelegateProxy.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

public class DelegateProxy: ObjcDelegateProxy {
    private var dict: [Selector: ([Any]) -> Void] = [:]

    public required override init() {
        super.init()
    }

    public override func interceptedSelector(_ selector: Selector, arguments: [Any]) {
        dict[selector]?(arguments)
    }

    public func intercept(_ selector: Selector, _ handler: @escaping ([Any]) -> Void) {
        dict[selector] = handler
    }
}
