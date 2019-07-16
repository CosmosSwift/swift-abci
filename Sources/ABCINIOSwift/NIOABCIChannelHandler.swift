//
//  NIOABCIChannelHandler.swift
//  ABCISwift
//
//  Created by Alex Tran-Qui on 27/06/2019.
//

//import Foundation
import NIO
import Logging
import ABCISwift


public final class NIOABCIChannelHandler: ChannelInboundHandler {
    public typealias InboundIn = ByteBuffer
    public typealias OutboundOut = ByteBuffer
    
    private let application: ABCIApplication
    private let logger: Logger
    
    public init(_ application: ABCIApplication, _ logger: Logger) {
        self.application = application
        self.logger = logger
    }
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        var byteBuffer = self.unwrapInboundIn(data)
        
        if let bytes = byteBuffer.readBytes(length: byteBuffer.readableBytes) {
            let res = ABCIProcessor.process(bytes, application, logger)
            var buffer = context.channel.allocator.buffer(capacity: res.count)
            buffer.writeBytes(res)
            _ = context.channel.writeAndFlush(buffer)
        }
    }
    
    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        logger.error("\(error)")
        
        // As we are not really interested getting notified on success or failure we just pass nil as promise to
        // reduce allocations.
        context.close(promise: nil)
    }
    
    public func channelActive(context: ChannelHandlerContext) {
        logger.info("Client connected to \(context.remoteAddress!)")
    }
}
