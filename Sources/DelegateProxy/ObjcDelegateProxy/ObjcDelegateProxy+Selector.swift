//
//  ObjcDelegateProxy+Selector.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

extension ObjcDelegateProxy {
    @objc(canRespondToSelector:)
    public func canRespond(to selector: Selector) -> Bool {
        return selectors.map { $0 as? Selector }.contains(selector)
    }

    @objc(selectors:encodedReturnType:)
    public static func selectorsOfClass(_ c: AnyClass, encodedReturnType: String) -> NSSet {
        return NSSet(set: selectors(ofClass: c, encodedReturnType: encodedReturnType))
    }

    private static func selectors(ofClass c: AnyClass, encodedReturnType: String) -> Set<Selector> {
        var protocolsCount: UInt32 = 0
        guard let protocolPointer = class_copyProtocolList(c, &protocolsCount) else { return .init() }

        let protocolSelectors = selectors(ofProtocolPointer: protocolPointer, count: Int(protocolsCount), encodedReturnType: encodedReturnType)

        guard let superClass = class_getSuperclass(c) else { return protocolSelectors }
        return protocolSelectors.union(selectors(ofClass: superClass, encodedReturnType: encodedReturnType))
    }

    private static func selectors(ofProtocol p: Protocol, encodedReturnType: String) -> Set<Selector> {
        var protocolMethodCount: UInt32 = 0
        let methodDescriptions = protocol_copyMethodDescriptionList(p, false, true, &protocolMethodCount)
        defer { free(methodDescriptions) }

        var protocolsCount: UInt32 = 0
        let protocols = protocol_copyProtocolList(p, &protocolsCount)

        let methodSelectors = (0..<protocolMethodCount)
            .compactMap { methodDescriptions?[Int($0)] }
            .filter { encodedMethodReturnType($0) == encodedReturnType }
            .compactMap { $0.name }

        let protocolSelectors = protocols.map { selectors(ofProtocolPointer: $0, count: Int(protocolsCount), encodedReturnType: encodedReturnType) } ?? []

        return Set(methodSelectors).union(protocolSelectors)
    }

    private static func selectors(ofProtocolPointer p: AutoreleasingUnsafeMutablePointer<Protocol>, count: Int, encodedReturnType: String) -> Set<Selector> {
        return (0..<count)
            .compactMap { p[$0] }
            .map { selectors(ofProtocol: $0, encodedReturnType: encodedReturnType) }
            .reduce(.init()) { $0.union($1) }
    }

    private static func encodedMethodReturnType(_ method: objc_method_description) -> String? {
        guard let pointee = method.types?.pointee else { return nil }
        return String(bytes: [UInt8(pointee)], encoding: .ascii)
    }
}
