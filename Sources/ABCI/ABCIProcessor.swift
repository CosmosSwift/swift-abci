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
    public static func process(_ bytes: [UInt8], _ application: ABCIApplication, _ logger: Logger) -> [UInt8] {
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
                    var response: Tendermint_Abci_Types_Response! = Tendermint_Abci_Types_Response()
                    logger.debug("\(request)")
                    switch request.value {
                    case let .some(v):
                        switch v {
                        case let .echo(r):
                            response.echo = Tendermint_Abci_Types_ResponseEcho(application.echo(r.message))
                        case .flush:
                            application.flush()
                            response.flush = Tendermint_Abci_Types_ResponseFlush()
                        case let .info(r):
                            response.info = Tendermint_Abci_Types_ResponseInfo(application.info(r.version, r.blockVersion, r.p2PVersion))
                        case let .beginBlock(r):
                            response.beginBlock = Tendermint_Abci_Types_ResponseBeginBlock(application.beginBlock(r.hash, Header(protobuf: r.header), LastCommitInfo(protobuf: r.lastCommitInfo), r.byzantineValidators.map { Evidence(protobuf: $0) }))
                        case let .endBlock(r):
                            response.endBlock = Tendermint_Abci_Types_ResponseEndBlock(application.endBlock(r.height))
                        case let .deliverTx(r):
                            response.deliverTx = Tendermint_Abci_Types_ResponseDeliverTx(application.deliverTx(r.tx))
                        case let .checkTx(r):
                            response.checkTx = Tendermint_Abci_Types_ResponseCheckTx(application.checkTx(r.tx))
                        case .commit:
                            response.commit = Tendermint_Abci_Types_ResponseCommit(application.commit())
                        case let .setOption(r):
                            response.setOption = Tendermint_Abci_Types_ResponseSetOption(application.setOption(r.key, r.value))
                        case let .query(r):
                            response.query = Tendermint_Abci_Types_ResponseQuery(application.query(Query(r.data, r.path, r.height, r.prove)))
                        case let .initChain(r):
                            response.initChain = Tendermint_Abci_Types_ResponseInitChain(application.initChain(r.time.date, r.chainID, ConsensusParams(protobuf: r.consensusParams), r.validators.map { ValidatorUpdate(protobuf: $0) }, r.appStateBytes))
                        }
                    case .none:
                        response.exception = Tendermint_Abci_Types_ResponseException()
                    }
                    logger.info("\(String(describing: response))")
                    let message = try response.serializedData()
                    var array = [UInt8]()
                    // varint size encoding representation (https://developers.google.com/protocol-buffers/docs/encoding#varints)
                    var toEncode = message.count << 1 // >0 zig-zag representation (https://developers.google.com/protocol-buffers/docs/encoding?csw=1#signed-integers)
                    while toEncode != 0 {
                        var res = toEncode & 127 // 7 least significant bits
                        toEncode = toEncode >> 7 // shift by 7 bits
                        if toEncode != 0 {
                            res += 128
                        }
                        array.insert(UInt8(res), at: 0)
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
