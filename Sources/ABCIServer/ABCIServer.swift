// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ABCIServer.swift last updated 02/06/2020
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
import Logging

public protocol ABCIServer {
    init(application: ABCIApplication, logger: Logger)
    func start(host: String, port: Int) throws
    func stop() throws
}

extension ABCIServer {
    public init(application: ABCIApplication) {
        self.init(application: application, logger: Logger(label: "ABCIServer"))
    }

    public func start() throws {
        try start(host: "127.0.0.1", port: 26658)
    }

    public func start(host: String = "127.0.0.1") throws {
        try start(host: host, port: 26658)
    }

    public func start(port: Int) throws {
        try start(host: "127.0.0.1", port: port)
    }
}
