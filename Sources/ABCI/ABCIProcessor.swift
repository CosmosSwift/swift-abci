// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ABCIProcessor.swift last updated 16/07/2020
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

public struct ABCIProcessor {
    /// Proceses the incoming ABCI messages from Tendermint Core.
    /// - Parameter bytes: the message.
    /// - Parameter application: the ABCI Server processing the messages.
    /// - Parameter logger: Logger.
    /// - Returns: the serialized response from the the ABCI server .
    public static func process(
        bytes: [UInt8],
        application: ABCIApplication,
        logger: Logger
    ) -> [UInt8] {
        var pos = 0
        var result: [UInt8] = []
        var sizeRemainingToProcess: Int?
        
        while pos < bytes.count {
            // iterate over full buffer
            var size = 0
            
            if let s = sizeRemainingToProcess {
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
                    mul *= 128
                } while current >> 7 != 0

                size = zigzagSize >> 1 // sizes are always >0
                sizeRemainingToProcess = size
            }
            
            // if enough bytes remaining, process
            if pos + size <= bytes.count {
                // Add message to requests
                do {
                    let request = try Tendermint_Abci_Types_Request(serializedData: Data([UInt8](bytes[pos ..< pos + size])))
                    var tendermintResponse = Tendermint_Abci_Types_Response()
                    
                    logger.info("\(request)")
                    
                    switch request.value {
                    case let .some(value):
                        switch value {
                        case let .echo(tendermintRequest):
                            let request = RequestEcho(tendermintRequest)
                            let response = application.echo(request: request)
                            tendermintResponse.echo = Tendermint_Abci_Types_ResponseEcho(response)
                        case .flush:
                            application.flush()
                            tendermintResponse.flush = Tendermint_Abci_Types_ResponseFlush()
                        case let .info(tendermintRequest):
                            let request = RequestInfo(tendermintRequest)
                            let response = application.info(request: request)
                            tendermintResponse.info = Tendermint_Abci_Types_ResponseInfo(response)
                        case let .initChain(tendermintRequest):
                            let request = RequestInitChain(tendermintRequest)
                            let response = application.initChain(request: request)
                            tendermintResponse.initChain = Tendermint_Abci_Types_ResponseInitChain(response)
                        case let .query(tendermintRequest):
                            let request = RequestQuery(tendermintRequest)
                            let response = application.query(request: request)
                            tendermintResponse.query = Tendermint_Abci_Types_ResponseQuery(response)
                        case let .beginBlock(tendermintRequest):
                            let request = RequestBeginBlock(tendermintRequest)
                            let response = application.beginBlock(request: request)
                            tendermintResponse.beginBlock = Tendermint_Abci_Types_ResponseBeginBlock(response)
                        case let .checkTx(tendermintRequest):
                            let request = RequestCheckTx(tendermintRequest)
                            let response = application.checkTx(request: request)
                            tendermintResponse.checkTx = Tendermint_Abci_Types_ResponseCheckTx(response)
                        case let .deliverTx(tendermintRequest):
                            let request = RequestDeliverTx(tendermintRequest)
                            let response = application.deliverTx(request: request)
                            tendermintResponse.deliverTx = Tendermint_Abci_Types_ResponseDeliverTx(response)
                        case let .endBlock(tendermintRequest):
                            let request = RequestEndBlock(tendermintRequest)
                            let response = application.endBlock(request: request)
                            tendermintResponse.endBlock = Tendermint_Abci_Types_ResponseEndBlock(response)
                        case .commit:
                            tendermintResponse.commit = Tendermint_Abci_Types_ResponseCommit(application.commit())
                        case .setOption:
                            break
                        }
                    case .none:
                        tendermintResponse.exception = Tendermint_Abci_Types_ResponseException()
                    }
                    
                    logger.info("\(tendermintResponse)")
                    let message = try tendermintResponse.serializedData()
                    var array = [UInt8]()
                    
                    // varint size encoding representation (https://developers.google.com/protocol-buffers/docs/encoding#varints)
                    var toEncode = message.count << 1 // >0 zig-zag representation (https://developers.google.com/protocol-buffers/docs/encoding?csw=1#signed-integers)
                    
                    while toEncode != 0 {
                        var res = toEncode & 127 // 7 least significant bits
                        toEncode = toEncode >> 7 // shift by 7 bits
                        if toEncode != 0 {
                            res += 128
                        }
                        array.append(UInt8(res))
                    }
                    
                    result.append(contentsOf: array)
                    result.append(contentsOf: message)
                } catch {
                    logger.error("\(error)")
                }
                
                sizeRemainingToProcess = nil
                pos += size
            }
        }
        
        return result
    }
}
