// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  NIOABCIChannelHandler.swift last updated 02/06/2020
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

import ABCI
import Logging
import NIO

public final class NIOABCIChannelHandler: ChannelInboundHandler {
    public typealias InboundIn = ByteBuffer
    public typealias OutboundOut = ByteBuffer

    private let application: ABCIApplication
    private let logger: Logger

    public init(application: ABCIApplication, logger: Logger) {
        self.application = application
        self.logger = logger
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        var byteBuffer = unwrapInboundIn(data)

        guard let bytes = byteBuffer.readBytes(length: byteBuffer.readableBytes) else {
            return
        }
        
        let response = ABCIProcessor.process(bytes: bytes, application: application, logger: logger)
        var buffer = context.channel.allocator.buffer(capacity: response.count)
        buffer.writeBytes(response)
        _ = context.channel.writeAndFlush(buffer)
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
