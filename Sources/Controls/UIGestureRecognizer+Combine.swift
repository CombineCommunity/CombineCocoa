//
//  UIGestureRecognizer+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2019 Shai Mishali. All rights reserved.
//

import Combine
import UIKit

// MARK: - Gesture Publishers

public extension UITapGestureRecognizer {
    /// A publisher which emits when this Tap Gesture Recognizer is triggered
    var tapPublisher: AnyPublisher<UITapGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

public extension UIPinchGestureRecognizer {
    /// A publisher which emits when this Pinch Gesture Recognizer is triggered
    var pinchPublisher: AnyPublisher<UIPinchGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

public extension UIRotationGestureRecognizer {
    /// A publisher which emits when this Rotation Gesture Recognizer is triggered
    var rotationPublisher: AnyPublisher<UIRotationGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

public extension UISwipeGestureRecognizer {
    /// A publisher which emits when this Swipe Gesture Recognizer is triggered
    var swipePublisher: AnyPublisher<UISwipeGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

public extension UIPanGestureRecognizer {
    /// A publisher which emits when this Pan Gesture Recognizer is triggered
    var panPublisher: AnyPublisher<UIPanGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

public extension UIScreenEdgePanGestureRecognizer {
    /// A publisher which emits when this Screen Edge Gesture Recognizer is triggered
    var screenEdgePanPublisher: AnyPublisher<UIScreenEdgePanGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

public extension UILongPressGestureRecognizer {
    /// A publisher which emits when this Long Press Recognizer is triggered
    var longPressPublisher: AnyPublisher<UILongPressGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

// MARK: - Private Helpers

// A private generic helper function which returns the provided
// generic publisher whenever its specific event occurs.
private func gesturePublisher<Gesture: UIGestureRecognizer>(for gesture: Gesture) -> AnyPublisher<Gesture, Never> {
    Publishers.ControlTarget(control: gesture,
                             addTargetAction: { gesture, target, action in
                                gesture.addTarget(target, action: action)
                             },
                             removeTargetAction: { gesture, target, action in
                                gesture?.removeTarget(target, action: action)
                             })
              .map { gesture }
              .eraseToAnyPublisher()
}
