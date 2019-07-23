//===----------------------------------------------------------------------===//
//
// This source file is part of the ABCISwift open source project
//
// Copyright (c) 2019 ABCISwift project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of ABCISwift project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//


import Foundation
import Logging

public protocol ABCIServer {
    init(application: ABCIApplication, logger: Logger)
    func start(host: String, port: Int) throws
    func stop() throws
    func incomingMessageProcessor(_ bytes: [UInt8], _ application: ABCIApplication, _ logger: Logger) -> [UInt8]
}

extension ABCIServer {
    public init( _ application: ABCIApplication) {
        self.init(application: application, logger: Logger(label: "ABCIServer"))
    }
    public func start() throws {
        try self.start(host: "127.0.0.1", port: 26658)
    }
    
    public func start(host: String = "127.0.0.1") throws {
        try self.start(host: host, port: 26658)
    }
    
    public func start(port: Int) throws {
        try self.start(host: "127.0.0.1", port: port)
    }
    
    public func incomingMessageProcessor(_ bytes: [UInt8], _ application: ABCIApplication, _ logger: Logger) -> [UInt8] {
        return ABCIProcessor.process(bytes, application, logger)
    }

}
