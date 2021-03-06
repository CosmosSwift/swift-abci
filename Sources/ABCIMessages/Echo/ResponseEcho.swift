// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseEcho.swift last updated 16/07/2020
//
//  Copyright © 2020 Katalysis B.V. and the CosmosSwift project authors.
//  Licensed under Apache License v2.0
//
//  See LICENSE.txt for license information
//  See CONTRIBUTORS.txt for the list of CosmosSwift project authors
//
//  SPDX-License-Identifier: Apache-2.0
//
// ===----------------------------------------------------------------------===

import Foundation

/// Echoes a string to test an abci client/server implementation.
public struct ResponseEcho {
    /// The string sent in the request.
    public let message: String
    
    /// Echoes a string to test an abci client/server implementation.
    /// - Parameter message: The string sent in the request.
    public init(message: String) {
        self.message = message
    }
}
