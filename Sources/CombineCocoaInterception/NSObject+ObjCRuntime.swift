//
//  NSObject+ObjCRuntime.swift
//  CombineCocoa
//
//  Created by Maxim Krouk on 22.06.21.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Foundation

extension NSObject {
  /// The class of the instance reported by the ObjC `-class:` message.
  ///
  /// - note: `type(of:)` might return the runtime subclass, while this property
  ///         always returns the original class.
  @nonobjc internal var objcClass: AnyClass {
    return (self as AnyObject).objcClass
  }
}
