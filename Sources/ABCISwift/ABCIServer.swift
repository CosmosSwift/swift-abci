//
//  ABCIServer.swift
//  ABCISwift
//
//  Created by Alex Tran-Qui on 03/07/2019.
//

import Foundation
import Logging

public protocol ABCIServer {
    init( application: ABCIApplication, logger: Logger)
    func start(host: String, port: Int) throws
    func stop() throws
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

}
