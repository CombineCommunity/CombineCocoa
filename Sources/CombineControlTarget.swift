//
//  CombineControlTarget.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import Combine
import Foundation

// MARK: - Publisher
public extension Combine.Publishers {
    /// A publisher which wraps objects that use the Target & Action mechanism,
    /// for example - a UIBarButtonItem which isn't KVO-compliant and doesn't use UIControlEvent(s).
    ///
    /// Instead, you pass in a generic Control, and two functions:
    /// One to add a target action to the provided control, and a second one to
    /// remove a target action from a provided control.
    struct ControlTarget<Control: AnyObject>: Publisher {
        public typealias Output = Void
        public typealias Failure = Never
        
        private let control: Control
        private let addTargetAction: (Control, AnyObject, Selector) -> Void
        private let removeTargetAction: (Control?, AnyObject, Selector) -> Void
        
        /// Initialize a publisher that emits a Void whenever the
        /// provided control fires an action.
        ///
        /// - parameter control: UI Control.
        /// - parameter addTargetAction: A function which accepts the Control, a Target and a Selector and
        ///                              responsible to add the target action to the provided control.
        /// - parameter removeTargetAction: A function which accepts the Control, a Target and a Selector and it
        ///                                 responsible to remove the target action from the provided control.
        public init(control: Control,
                    addTargetAction: @escaping (Control, AnyObject, Selector) -> Void,
                    removeTargetAction: @escaping (Control?, AnyObject, Selector) -> Void) {
            self.control = control
            self.addTargetAction = addTargetAction
            self.removeTargetAction = removeTargetAction
        }
        
        public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
            let subscription = Subscription(subscriber: subscriber,
                                            control: control,
                                            addTargetAction: addTargetAction,
                                            removeTargetAction: removeTargetAction)
            
            subscriber.receive(subscription: subscription)
        }
    }
}

// MARK: - Subscription
private extension Combine.Publishers.ControlTarget {
    private final class Subscription<S: Subscriber, Control: AnyObject>: Combine.Subscription where S.Input == Void {
        private var subscriber: S?
        weak private var control: Control?
        
        private let removeTargetAction: (Control?, AnyObject, Selector) -> Void
        private let action = #selector(handleAction)
        
        init(subscriber: S,
             control: Control,
             addTargetAction: @escaping (Control, AnyObject, Selector) -> Void,
             removeTargetAction: @escaping (Control?, AnyObject, Selector) -> Void) {
            self.subscriber = subscriber
            self.control = control
            self.removeTargetAction = removeTargetAction
            
            addTargetAction(control, self, action)
        }
        
        func request(_ demand: Subscribers.Demand) {
            // We don't care about the demand at this point.
            // As far as we're concerned - The control's target events are endless until it is deallocated.
        }
        
        func cancel() {
            subscriber = nil
            removeTargetAction(control, self, action)
        }
        
        @objc private func handleAction() {
            _ = subscriber?.receive()
        }
    }
}
