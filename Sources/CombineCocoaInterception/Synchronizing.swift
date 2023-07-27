//
//  Synchronizing.swift
//  CombineCocoa
//
//  Created by Maxim Krouk on 22.06.21.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Foundation

internal func synchronized<Result>(_ token: AnyObject, execute: () throws -> Result) rethrows
  -> Result
{
  objc_sync_enter(token)
  defer { objc_sync_exit(token) }
  return try execute()
}
