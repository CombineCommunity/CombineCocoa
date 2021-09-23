//
//  AnimatedAssignSubscriber.swift
//  CombineCocoa
//
//  Created by Marin Todorov on 05/03/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Foundation

#if canImport(UIKit) && !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

/// A list of animations that can be used with `Publisher.assign(to:on:animation:)`
@available(iOS 13.0, *)
public enum AssignTransition {
    public enum Direction {
        case top, bottom, left, right
    }

    /// Flip from either bottom, top, left, or right.
    case flip(direction: Direction, duration: TimeInterval)

    /// Cross fade with previous value.
    case fade(duration: TimeInterval)

    /// A custom animation. Do not include your own code to update the target of the assign subscriber.
    case animation(duration: TimeInterval, options: UIView.AnimationOptions, animations: () -> Void, completion: ((Bool) -> Void)?)
}

@available(iOS 13.0, *)
public extension Publisher where Self.Failure == Never {
    /// Behaves identically to `Publisher.assign(to:on:)` except that it allows the user to
    /// "wrap" emitting output in an animation transition.
    ///
    /// For example if you assign values to a `UILabel` on screen you
    /// can make it flip over when each new value is set:
    ///
    /// ```
    /// myPublisher
    ///   .assign(to: \.text,
    ///             on: myLabel,
    ///             animation: .flip(direction: .bottom, duration: 0.33))
    /// ```
    ///
    /// You may also provide a custom animation block, as follows:
    ///
    /// ```
    /// myPublisher
    ///   .assign(to: \.text, on: myLabel, animation: .animation(duration: 0.33, options: .curveEaseIn, animations: { _ in
    ///     myLabel.center.x += 10.0
    ///   }, completion: nil))
    /// ```
    func assign<Root: UIView>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root, animation: AssignTransition) -> AnyCancellable {
        var transition: UIView.AnimationOptions
        var duration: TimeInterval

        switch animation {
        case .fade(let interval):
            duration = interval
            transition = .transitionCrossDissolve
        case let .flip(dir, interval):
            duration = interval
            switch dir {
            case .bottom: transition = .transitionFlipFromBottom
            case .top: transition    = .transitionFlipFromTop
            case .left: transition   = .transitionFlipFromLeft
            case .right: transition  = .transitionFlipFromRight
            }
        case let .animation(interval, options, animations, completion):
            // Use a custom animation.
            return handleEvents(
                receiveOutput: { value in
                    UIView.animate(withDuration: interval,
                                   delay: 0,
                                   options: options,
                                   animations: {
                                    object[keyPath: keyPath] = value
                                    animations()
                                   },
                                   completion: completion)
                    }
                )
                .sink { _ in }
        }

        // Use one of the built-in transitions like flip or crossfade.
        return self
            .handleEvents(receiveOutput: { value in
                UIView.transition(with: object,
                                  duration: duration,
                                  options: transition,
                                  animations: {
                                    object[keyPath: keyPath] = value
                                  },
                                  completion: nil)
            })
            .sink { _ in }
    }
}
#endif
