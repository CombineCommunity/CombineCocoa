//
//  CombineControlTarget.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine)
import Combine
import Foundation

// MARK: - Publisher
@available(iOS 13.0, *)
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
@available(iOS 13.0, *)
private extension Combine.Publishers.ControlTarget {
    private final class Subscription<S: Subscriber, Control: AnyObject>: Combine.Subscription where S.Input == Void {
        private var subscriber: S?
        weak private var control: Control?

        private let removeTargetAction: (Control?, AnyObject, Selector) -> Void
        private let action = #selector(handleAction)

        // keep track of subscibers demand
        var currentDemand = Subscribers.Demand.none
        
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
            // add new demand of subscriber to previously requested demand
            currentDemand += demand
        }

        func cancel() {
            subscriber = nil
            removeTargetAction(control, self, action)
        }

        @objc private func handleAction() {
            // only sending value when subscriber has a demand
            // this implentation does not buffer values
            if currentDemand > 0 {
                let newDemand = subscriber?.receive() ?? .none
                //fullfilled demand with one value -> reduce current demand by one
                // adding subscribers new demand to current demand
                currentDemand = currentDemand + newDemand - 1
            }
        }
    }
}
#endif
