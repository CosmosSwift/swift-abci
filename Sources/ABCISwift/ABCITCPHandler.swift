//
//  ABCITCPHandler.swift
//  ABCISwift
//
//  Created by Alex Tran-Qui on 27/06/2019.
//

import Foundation
import NIO
import Logging

let logger = Logger(label: "ABCISwift.ABCIConnector")

public final class ABCITCPHandler: ChannelInboundHandler {
    public typealias InboundIn = ByteBuffer
    public typealias OutboundOut = ByteBuffer
    
    internal var application: ABCIApplication
    private var unprocessed: [UInt8] = []
    private var sizeRemainingToProcess: Int?

    
    public init(_ application: ABCIApplication) {
        self.application = application
    }
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        var byteBuffer = self.unwrapInboundIn(data)
        
        if let bytes = byteBuffer.readBytes(length: byteBuffer.readableBytes) {
            var pos = 0
            while (pos < bytes.count) {
                // iterate over full buffer
                var size = 0
                if let s = self.sizeRemainingToProcess {
                    size = s
                } else {
                    // varint size representation (https://developers.google.com/protocol-buffers/docs/encoding#varints)
                    var mul = 1
                    var zigzagSize = 0
                    var current: UInt8
                    repeat {
                        current = bytes[pos]
                        zigzagSize += Int(current) & 127 * mul
                        pos += 1
                        mul *= 64
                    } while (current >> 7 != 0)
                    
                    size = zigzagSize >> 1 // sizes are always >0
                    self.sizeRemainingToProcess = size
                }
                // if enough bytes remaining, process
                if (pos + size <= bytes.count) {
                    // Add message to requests
                    do {
                        let request = try Types_Request(serializedData: Data([UInt8](bytes[pos..<pos+size])))
                        var response: Types_Response! = Types_Response()
                        logger.debug("\(request)")
                        switch request.value {
                        case let .some(v):
                            switch v {
                            case let .echo(r):
                                response.echo = Types_ResponseEcho(application.echo(r.message))
                            case .flush:
                                application.flush()
                                response.flush = Types_ResponseFlush()
                            case let .info(r):
                                response.info = Types_ResponseInfo(application.info(r.version))
                            case let .beginBlock(r):
                                let bV = r.byzantineValidators.map({ (evidence) -> Evidence in
                                    return Evidence(protobuf: evidence)
                                })
                                application.beginBlock(r.hash,  Header(protobuf: r.header), r.absentValidators, bV)
                                response.beginBlock = Types_ResponseBeginBlock()
                            case let .endBlock(r):
                                response.endBlock = Types_ResponseEndBlock(application.endBlock(r.height))
                            case let .deliverTx(r):
                                response.deliverTx = Types_ResponseDeliverTx(application.deliverTx(r.tx))
                            case let .checkTx(r):
                                response.checkTx = Types_ResponseCheckTx(application.checkTx(r.tx))
                            case .commit:
                                response.commit = Types_ResponseCommit(application.commit())
                            case let .setOption(r):
                                response.setOption = Types_ResponseSetOption(application.setOption(r.key, r.value))
                            case let .query(r):
                                response.query = Types_ResponseQuery(application.query(Query(data: r.data, path: r.path, height: r.height, prove: r.prove)))
                            case let .initChain(r):
                                application.initChain(r.validators.map({ (v) -> Validator in
                                    return Validator(protobuf: v)
                                }))
                                response.initChain = Types_ResponseInitChain()
                            }
                        case .none:
                            response.exception = Types_ResponseException()
                            break
                        }
                        logger.debug("\(response)")
                        let message = try response.serializedData()
                        var array = [UInt8]()
                        // varint size encoding representation (https://developers.google.com/protocol-buffers/docs/encoding#varints)
                        var toEncode = message.count << 1 // >0 zig-zag representation (https://developers.google.com/protocol-buffers/docs/encoding?csw=1#signed-integers)
                        while (toEncode != 0) {
                            var res = toEncode & 127 // 7 least significant bits
                            toEncode = toEncode >> 7 // shift by 7 bits
                            if (toEncode != 0) {
                                res += 128
                            }
                            array.insert(UInt8(res), at: 0)
                        }
                        var buffer = context.channel.allocator.buffer(capacity: array.count)
                        buffer.writeBytes(array)
                        context.channel.writeAndFlush(buffer)
                    } catch let error {
                        logger.error("\(error)")
                    }
                    self.sizeRemainingToProcess = nil
                    pos += size
                } else {
                    // put remaining bytes in unprocessed and wait for more data to come in
                    self.unprocessed.append(contentsOf:[UInt8](bytes[pos...]))
                    self.sizeRemainingToProcess = size - (bytes.count - pos) //
                    pos = bytes.count
                }
            }
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
