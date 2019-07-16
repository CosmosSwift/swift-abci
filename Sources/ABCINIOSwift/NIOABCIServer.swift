/*
 Copyright 2019 Alex Tran Qui (alex.tranqui@asymtech.eu)
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import NIO
import Logging
import ABCISwift

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
    
    /// Start server
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
