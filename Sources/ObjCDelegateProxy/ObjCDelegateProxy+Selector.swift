//
//  ObjCDelegateProxy+Selector.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25.09.19.
//

import Foundation

extension ObjCDelegateProxy {

    @objc(canRespondToSelector:)
    static func canRespond(to selector: Selector) -> Bool {
        return selectors().map { $0 as? Selector }.contains(selector)
    }

    @objc
    static func selectorsOfClass(_ c: AnyClass) -> NSSet {
        return NSSet(set: selectors(ofClass: c))
    }

    private static func selectors(ofClass c: AnyClass) -> Set<Selector> {
        var protocolsCount: UInt32 = 0
        guard let protocolPointer = class_copyProtocolList(c, &protocolsCount) else { return .init() }

        let protocolSelectors = selectors(ofProtocolPointer: protocolPointer, count: Int(protocolsCount))

        guard let superClass = class_getSuperclass(c) else { return protocolSelectors }
        return protocolSelectors.union(selectors(ofClass: superClass))
    }

    private static func selectors(ofProtocol p: Protocol) -> Set<Selector> {
        var protocolMethodCount: UInt32 = 0
        let methodDescriptions = protocol_copyMethodDescriptionList(p, false, true, &protocolMethodCount)
        defer { free(methodDescriptions) }

        var protocolsCount: UInt32 = 0
        let protocols = protocol_copyProtocolList(p, &protocolsCount)

        let methodSelectors = (0..<protocolMethodCount)
            .compactMap { methodDescriptions?[Int($0)] }
            .compactMap { $0.name }

        let protocolSelectors = protocols.map { selectors(ofProtocolPointer: $0, count: Int(protocolsCount)) } ?? []

        return Set(methodSelectors).union(protocolSelectors)
    }

    private static func selectors(ofProtocolPointer p: AutoreleasingUnsafeMutablePointer<Protocol>, count: Int) -> Set<Selector> {
        return (0..<count)
            .compactMap { p[$0] }
            .map(selectors(ofProtocol:))
            .reduce(.init()) { $0.union($1) }
    }
}

