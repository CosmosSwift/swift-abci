//
//  Server.swift
//  ABCISwift
//

//import Foundation
//import Core
//import IO
//import Venice
import SwiftProtobuf
import NIO

public final class ABCIServer {

    //private let application: ABCIApplication
    private let group: EventLoopGroup
    private let bootstrap: ServerBootstrap
    
    /// Creates a new ABCI server
    public init( _ application: ABCIApplication) {
        let abciHandler = ABCITCPHandler(application)
        
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
            
        }
    }
    
    /// Start server
    public func start(_ host: String = "::1", _ port: Int = 46658) throws {
        let channel = try bootstrap.bind(host: host, port: port).wait()
        
        guard let localAddress = channel.localAddress else {
            fatalError("Address was unable to bind. Please check that the socket was not closed or that the address family was understood.")
        }
        print("Server started and listening on \(localAddress)")
        
        // This will never unblock as we don't close the ServerChannel.
        try channel.closeFuture.wait()
        
        print("ABCIServer closed")
    }
    
    /// Stop server
    public func stop() throws {
        logger.info("Stopping ABCI server.")
        try! group.syncShutdownGracefully()
    }
}
