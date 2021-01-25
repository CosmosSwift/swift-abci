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
                    let request = try Tendermint_Abci_Request(serializedData: Data([UInt8](bytes[pos ..< pos + size])))
                    var tendermintResponse = Tendermint_Abci_Response()
                    
                    logger.info("\(request)")
                    
                    switch request.value {
                    case let .some(value):
                        switch value {
                        case .echo(let tendermintRequest):
                            let request = RequestEcho(tendermintRequest)
                            let response = application.echo(request: request)
                            tendermintResponse.echo = Tendermint_Abci_ResponseEcho(response)
                        case .flush:
                            application.flush()
                            tendermintResponse.flush = Tendermint_Abci_ResponseFlush()
                        case .info(let tendermintRequest):
                            let request = RequestInfo(tendermintRequest)
                            let response = application.info(request: request)
                            tendermintResponse.info = Tendermint_Abci_ResponseInfo(response)
                        case .initChain(let tendermintRequest):
                            let request = RequestInitChain(tendermintRequest)
                            let response = application.initChain(request: request)
                            tendermintResponse.initChain = Tendermint_Abci_ResponseInitChain(response)
                        case .query(let tendermintRequest):
                            let request = RequestQuery(tendermintRequest)
                            let response = application.query(request: request)
                            tendermintResponse.query = Tendermint_Abci_ResponseQuery(response)
                        case .beginBlock(let tendermintRequest):
                            let request = RequestBeginBlock(tendermintRequest)
                            let response = application.beginBlock(request: request)
                            tendermintResponse.beginBlock = Tendermint_Abci_ResponseBeginBlock(response)
                        case .checkTx(let tendermintRequest):
                            let request = RequestCheckTx(tendermintRequest)
                            let response = application.checkTx(request: request)
                            tendermintResponse.checkTx = Tendermint_Abci_ResponseCheckTx(response)
                        case .deliverTx(let tendermintRequest):
                            let request = RequestDeliverTx(tendermintRequest)
                            let response = application.deliverTx(request: request)
                            tendermintResponse.deliverTx = Tendermint_Abci_ResponseDeliverTx(response)
                        case .endBlock(let tendermintRequest):
                            let request = RequestEndBlock(tendermintRequest)
                            let response = application.endBlock(request: request)
                            tendermintResponse.endBlock = Tendermint_Abci_ResponseEndBlock(response)
                        case .commit:
                            tendermintResponse.commit = Tendermint_Abci_ResponseCommit(application.commit())
                        case .listSnapshots:
                            let response = application.listSnapshots()
                            tendermintResponse.listSnapshots = Tendermint_Abci_ResponseListSnapshots(response)
                        case .offerSnapshot(let tendermintRequest):
                            let request = RequestOfferSnapshot(tendermintRequest)
                            let response = application.offerSnapshot(request: request)
                            tendermintResponse.offerSnapshot = Tendermint_Abci_ResponseOfferSnapshot(response)
                        case .loadSnapshotChunk(let tendermintRequest):
                            let request = RequestLoadSnapshotChunk(tendermintRequest)
                            let response = application.loadSnapshotChunk(request: request)
                            tendermintResponse.loadSnapshotChunk = Tendermint_Abci_ResponseLoadSnapshotChunk(response)
                        case .applySnapshotChunk(let tendermintRequest):
                            let request = RequestApplySnapshotChunk(tendermintRequest)
                            let response = application.applySnapshotChunk(request: request)
                            tendermintResponse.applySnapshotChunk = Tendermint_Abci_ResponseApplySnapshotChunk(response)
                        case .setOption:
                            break
                        }
                    case .none:
                        tendermintResponse.exception = Tendermint_Abci_ResponseException()
                    }
                    
                    logger.info("\(tendermintResponse)")
                    let message = try tendermintResponse.serializedData()
                    var array = [UInt8]()
                    
                    // varint size encoding representation (https://developers.google.com/protocol-buffers/docs/encoding#varints)
                    var toEncode = message.count << 1  // >0 zig-zag representation (https://developers.google.com/protocol-buffers/docs/encoding?csw=1#signed-integers)
                    
                    while (toEncode != 0) {
                        array.append(UInt8(toEncode % 128)) //
                        toEncode = toEncode >> 7
                    }
                    if (array.count == 0) { array.append(0x0) }
                    for i in 0..<array.count - 1 {
                        array[i] = array[i] ^ (1 << 7)
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
