//
//  UITextField+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
public extension UITextField {
    /// A publisher emitting any text changes to a this text field.
    var textPublisher: AnyPublisher<String?, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.text)
                  .eraseToAnyPublisher()
    }

    /// A publisher emitting any attributed text changes to this text field.
    var attributedTextPublisher: AnyPublisher<NSAttributedString?, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.attributedText)
                  .eraseToAnyPublisher()
    }

    /// A publisher that emits whenever the user taps the return button and ends the editing on the text field.
    var returnPublisher: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .editingDidEndOnExit)
    }

    /// A publisher that emits whenever the user taps the text fields and begin the editing.
    var didBeginEditingPublisher: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .editingDidBegin)
    }
}
#endif
