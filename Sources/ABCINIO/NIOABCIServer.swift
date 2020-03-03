//===----------------------------------------------------------------------===//
//
// This source file is part of the CosmsosSwift/ABCI open source project
//
// Copyright (c) 2019 CosmsosSwift/ABCI project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of CosmsosSwift/ABCI project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import NIO
import Logging
import ABCI

public final class NIOABCIServer: ABCIServer {

    private let group: EventLoopGroup
    private let bootstrap: ServerBootstrap    
    private let logger: Logger
    
    /// Creates a new ABCI server
    public init( application: ABCIApplication, logger: Logger) {
        self.logger = logger
        let abciHandler = NIOABCIChannelHandler(application, logger)
        
        group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
        bootstrap = ServerBootstrap(group: group)
            // Specify backlog and enable SO_REUSEADDR for the server itself
            .serverChannelOption(ChannelOptions.backlog, value: 256)
            .serverChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            
            // Set the handlers that are applied to the accepted Channels
            .childChannelInitializer { channel in
                channel.pipeline.addHandler(abciHandler)
            }
            
            // Enable SO_REUSEADDR for the accepted Channels
            .childChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            .childChannelOption(ChannelOptions.maxMessagesPerRead, value: 16)
            .childChannelOption(ChannelOptions.recvAllocator, value: AdaptiveRecvByteBufferAllocator())
    }
    
    deinit {
        do {
            try self.stop()
        } catch {
            logger.error("Shutdown failure.")
        }
    }
    
    /// Starts the server.
    /// - Parameter host: The host as a string. It can be an ip address.
    /// - Parameter port: The port on which the server is listening.
    public func start(host: String, port: Int) throws {
        let channel = try bootstrap.bind(host: host, port: port).wait()
        
        guard let localAddress = channel.localAddress else {
            logger.error("Address was unable to bind. Please check that the socket was not closed or that the address family was understood.")
            fatalError("Address was unable to bind. Please check that the socket was not closed or that the address family was understood.")
        }
        logger.info("Server started and listening on \(localAddress)")
        
        // This will never unblock as we don't close the ServerChannel.
        try channel.closeFuture.wait()
        
        logger.info("ABCIServer closed")
    }
    
    /// Stop server
    public func stop() throws {
        logger.info("Stopping ABCI server.")
        try! group.syncShutdownGracefully()
    }
}
