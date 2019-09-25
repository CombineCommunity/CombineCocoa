//
//  DelegateProxyType.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25.09.19.
//

import Foundation

public protocol DelegateProxyType {
    associatedtype Object

    func setDelegate(to object: Object)
}
