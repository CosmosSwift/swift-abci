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

public struct RequestEcho {
    /// A string to echo back in the response.
    public let message: String
}

extension RequestEcho {
    init(_ tendermintRequest: Tendermint_Abci_RequestEcho) {
        self.message = tendermintRequest.message
    }
}
