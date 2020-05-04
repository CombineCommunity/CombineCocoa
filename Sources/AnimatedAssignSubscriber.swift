//
//  AnimatedAssignSubscriber.swift
//
//  Created by Marin Todorov on 5/3/20.
//

import Foundation
import Combine

#if canImport(UIKit)
import UIKit

/// A list of animations that can be used with `Publisher.assign(to:on:animation:)`
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

extension Publisher where Self.Failure == Never {
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
    public func assign<Root: UIView>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root, animation: AssignTransition) -> AnyCancellable {
        guard let view = object as? UIView else {
            return assign(to: keyPath, on: object)
        }

        var transition: UIView.AnimationOptions
        var duration: TimeInterval
        
        switch animation {
        case .fade(let interval):
            duration = interval
            transition = .transitionCrossDissolve
        case .flip(let dir, let interval):
            duration = interval
            switch dir {
            case .bottom: transition = .transitionFlipFromBottom
            case .top: transition    = .transitionFlipFromTop
            case .left: transition   = .transitionFlipFromLeft
            case .right: transition  = .transitionFlipFromRight
            }
        case .animation(let interval, let options, let animations, let completion):
            return self
                .handleEvents(receiveOutput: { value in
                    UIView.animate(withDuration: interval, delay: 0, options: options, animations: {
                        object[keyPath: keyPath] = value
                        animations()
                    }, completion: completion)
                })
                .assign(to: keyPath, on: object)
        }

        return self
            .handleEvents(receiveOutput: { value in
                UIView.transition(with: view, duration: duration, options: transition, animations: {
                    object[keyPath: keyPath] = value
                }, completion: nil)
            })
            .assign(to: keyPath, on: object)
    }
}
#endif
