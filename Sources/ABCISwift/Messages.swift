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

import Foundation
import SwiftProtobuf

public struct Validator {
    public let address: Data
    public let power: Int64
}

extension Validator {
    init(protobuf: Types_Validator) {
        self.power = protobuf.power
        self.address = protobuf.address
    }
}

extension Types_Validator {
    init(_ r: Validator) {
        self.power = r.power
        self.address = r.address
    }
}

public struct ValidatorUpdate {
    public let pubKey: PubKey
    public let power: Int64
}

extension ValidatorUpdate {
    init(protobuf: Types_ValidatorUpdate) {
        self.power = protobuf.power
        self.pubKey = PubKey(type: protobuf.pubKey.type, data: protobuf.pubKey.data)
    }
}

extension Types_ValidatorUpdate {
    init(_ r: ValidatorUpdate) {
        self.power = r.power
        self.pubKey = Types_PubKey(r.pubKey)
    }
}

public struct PartSetHeader {
    public let total: Int32
    public let hash: Data
}

extension PartSetHeader {
    init(protobuf: Types_PartSetHeader) {
        self.total = protobuf.total
        self.hash = protobuf.hash
    }
}

public struct BlockID {
    public let hash: Data
    public let parts: PartSetHeader
}

extension BlockID {
    init (protobuf: Types_BlockID) {
        self.hash = protobuf.hash
        self.parts = PartSetHeader(protobuf: protobuf.partsHeader)
    }
}

public struct Version {
    let block : UInt64
    let app: UInt64
}

extension Types_Version {
    init(_ v: Version) {
        self.block  = v.block
        self.app = v.app
    }
}

public struct Header {
    public let version: Version
    public let chainID: String
    public let height: Int64
    public let time: Date
    public let numTxs: Int64
    public let totalTxs: Int64
    public let lastBlockID: BlockID
    public let lastCommitHash: Data
    public let dataHash: Data
    public let validatorHash: Data
    public let nextValidatorsHash: Data
    public let consensusHash: Data
    public let appHash: Data
    public let lastResultsHash: Data
    public let evidenceHash: Data
    public let proposerAddress: Data
}

extension Header {
    init(protobuf: Types_Header) {
        self.version = Version(block: protobuf.version.block, app: protobuf.version.app)
        self.chainID = protobuf.chainID
        self.height = protobuf.height
        self.time = protobuf.time.date
        self.numTxs = protobuf.numTxs
        self.totalTxs = protobuf.totalTxs
        self.lastBlockID = BlockID(protobuf: protobuf.lastBlockID)

        self.lastCommitHash = protobuf.lastCommitHash
        self.dataHash = protobuf.dataHash
        self.validatorHash = protobuf.validatorsHash
        self.nextValidatorsHash = protobuf.nextValidatorsHash
        self.consensusHash = protobuf.consensusHash
        self.appHash = protobuf.appHash
        self.lastResultsHash = protobuf.lastResultsHash
        self.evidenceHash = protobuf.evidenceHash
        self.proposerAddress = protobuf.proposerAddress
    }
}

public struct BlockParams {
    public let maxBytes: Int64
    public let maxGas: Int64
    
    public init(maxBytes: Int64, maxGas: Int64) {
        self.maxBytes = maxBytes
        self.maxGas = maxGas
    }
}

extension Types_BlockParams {
    init(_ b: BlockParams) {
        self.maxBytes = b.maxBytes
        self.maxGas = b.maxGas
    }
}

public struct Evidence {
    let type: String
    let validator: Validator
    let height: Int64
    let time: Date
    let totalVotingPower: Int64
    
    public init(type: String, validator: Validator, height: Int64, time: Date, totalVotingPower: Int64) {
        self.type = type
        self.validator = validator
        self.height = height
        self.time = time
        self.totalVotingPower = totalVotingPower
    }
}

extension Evidence {
    init(protobuf: Types_Evidence) {
        self.type = protobuf.type
        self.validator = Validator(protobuf: protobuf.validator)
        self.height = protobuf.height
        self.time = protobuf.time.date
        self.totalVotingPower = protobuf.totalVotingPower
    }
}

extension Types_Evidence {
    init(_ e: Evidence) {
        self.type = e.type
        self.validator = Types_Validator(e.validator)
        self.height = e.height
        self.time = Google_Protobuf_Timestamp(date: e.time)
        self.totalVotingPower = e.totalVotingPower
    }
}

public struct EvidenceParams {
    public let maxAge: Int64
    
    public init(maxAge: Int64) {
        self.maxAge = maxAge
    }
}

extension Types_EvidenceParams {
    init(_ e: EvidenceParams) {
        self.maxAge = e.maxAge
    }
}

public struct ValidatorParams {
    public let pubKeyTypes: [String]
    
    public init(pubKeyTypes: [String]) {
        self.pubKeyTypes = pubKeyTypes
    }
}

extension Types_ValidatorParams {
    init(_ v: ValidatorParams) {
        self.pubKeyTypes = v.pubKeyTypes
    }
}
public struct ConsensusParams {
    public let block: BlockParams
    public let evidence: EvidenceParams
    public let validator: ValidatorParams
    
    public init(block: BlockParams, evidence: EvidenceParams, validator: ValidatorParams) {
        self.block = block
        self.evidence = evidence
        self.validator = validator
    }
}

extension ConsensusParams {
    init(protobuf: Types_ConsensusParams) {
        self.block = BlockParams(maxBytes: protobuf.block.maxBytes, maxGas: protobuf.block.maxGas)
        self.evidence = EvidenceParams(maxAge: protobuf.evidence.maxAge)
        self.validator = ValidatorParams(pubKeyTypes: protobuf.validator.pubKeyTypes)
    }
}

extension Types_ConsensusParams {
    init(_ r: ConsensusParams) {
        self.block = Types_BlockParams(r.block)
        self.evidence = Types_EvidenceParams(r.evidence)
        self.validator = Types_ValidatorParams(r.validator)
    }
}

public struct VoteInfo {
    let validator: Validator
    let signedLastBlock: Bool
}

extension VoteInfo {
    init(protobuf: Types_VoteInfo) {
        self.validator = Validator(protobuf: protobuf.validator)
        self.signedLastBlock = protobuf.signedLastBlock
    }
}

extension Types_VoteInfo {
    init(_ v: VoteInfo) {
        self.validator = Types_Validator(v.validator)
        self.signedLastBlock = v.signedLastBlock
    }
}

public struct PubKey {
    let type: String
    let data: Data
}

extension Types_PubKey {
    init(_ p: PubKey) {
        self.type = p.type
        self.data = p.data
    }
}

public struct LastCommitInfo {
    let round: Int32
    let votes: [VoteInfo]
}

extension LastCommitInfo {
    init(protobuf: Types_LastCommitInfo) {
        self.round = protobuf.round
        self.votes = protobuf.votes.map{ VoteInfo(protobuf: $0) }
    }
}

extension Types_LastCommitInfo {
    init(_ l: LastCommitInfo) {
        self.round = l.round
        self.votes = l.votes.map{ Types_VoteInfo($0) }
    }
}

public struct Query {
    public let data: Data
    public let path: String
    public let height: Int64
    public let prove: Bool
}

public class Result {
    let code: UInt32
    let data: Data
    let log: String
    
    
    init(_ code: UInt32, _ data: Data, _ log: String) {
        self.code = code
        self.data = data
        self.log = log
    }
}

extension Result: CustomStringConvertible {
    public var description: String {
        get {
            return "ABCI[code:\(code), data:\(data), log:\(log)]"
        }
    }
}

public struct ResponseException {
    public let error: String
}

extension Types_ResponseException {
    init(_ r: ResponseException) {
        self.error = r.error
    }
}

public struct ResponseEcho {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}

extension Types_ResponseEcho {
    init(_ r: ResponseEcho) {
        self.message = r.message
    }
}

public struct ResponseInfo {
    public let data: String
    public let version: String
    public let appVersion: UInt64
    public let lastBlockHeight: Int64
    public let lastBlockAppHash: Data
    
    public init(_ data: String = "", _ version: String = "", _ appVersion: UInt64 = 0, _ lastBlockHeight: Int64 = 0, _ lastBlockAppHash: Data = Data()) {
        self.data = data
        self.version = version
        self.appVersion = appVersion
        self.lastBlockHeight = lastBlockHeight
        self.lastBlockAppHash = lastBlockAppHash
    }
}

extension Types_ResponseInfo {
    init(_ r: ResponseInfo) {
        self.data = r.data
        self.version = r.version
        self.appVersion = r.appVersion
        self.lastBlockHeight = r.lastBlockHeight
        self.lastBlockAppHash = r.lastBlockAppHash
    }
}

public struct ResponseSetOption {
    //    public let code: UInt32
    public let log: String
    //    public let info: String
    
    public init(/*_ code: UInt32 = 0, */_ log: String = ""/*, _ info: String = ""*/) {
        //        self.code = code
        self.log = log
        //        self.info = info
    }
}

extension Types_ResponseSetOption {
    init(_ r: ResponseSetOption) {
        //        self.code = r.code
        self.log = r.log
        //        self.info = r.info
    }
}

public struct ResponseInitChain {
    let consensusParams: ConsensusParams
    let validators: [ValidatorUpdate]
    
    public init(_ consensusParams: ConsensusParams, _ validators: [ValidatorUpdate]) {
        self.consensusParams = consensusParams
        self.validators = validators
    }
}

extension Types_ResponseInitChain {
    init(_ r: ResponseInitChain) {
        self.consensusParams = Types_ConsensusParams(r.consensusParams)
        self.validators = r.validators.map{ Types_ValidatorUpdate($0) }
    }
}

extension Common_KVPair {
    init(key: Data, value: Data) {
        self.key = key
        self.value = value
    }
}

public struct Event {
    let type: String
    let attributes: [Data: Data]
}

extension Types_Event {
    init(_ e: Event) {
        self.type = e.type
        self.attributes = e.attributes.map({ (arg: (key: Data, value: Data)) -> Common_KVPair in
            let (k, v) = arg
            return Common_KVPair(key: k, value: v)
        })
    }
}

public struct ResponseBeginBlock {
    let events: [Event]
    
    public init(_ events: [Event]) {
        self.events = events
    }
}

extension Types_ResponseBeginBlock {
    init(_ r: ResponseBeginBlock) {
        self.events = r.events.map{ Types_Event($0) }
    }
}

public class ResponseDeliverTx: Result {
    let gasWanted: Int64
    let gasUsed: Int64
    let events: [Event]
    let codespace: String
    
    private init(_ code: UInt32, _ data: Data, _ log: String, _ gasWanted: Int64, _ gasUsed: Int64, _ events: [Event], _ codespace: String) {
        self.gasWanted = gasWanted
        self.gasUsed = gasUsed
        self.events = events
        self.codespace = codespace
        super.init(code, data, log)
    }
    
    public static func ok(gasWanted: Int64 = 0, gasUsed: Int64 = 0, events: [Event] = [], codespace: String = "", data: Data = Data(), log: String = "") -> ResponseDeliverTx {
        return ResponseDeliverTx(0, data, log, gasWanted, gasUsed, events, codespace)
    }
    
    public static func error(_ errno: Int, gasWanted: Int64 = 0, gasUsed: Int64 = 0, events: [Event] = [], codespace: String = "", data: Data = Data(), log: String = "") -> ResponseDeliverTx {
        assert( errno > 0)
        return ResponseDeliverTx(UInt32(errno), data, log, gasWanted, gasUsed, events, codespace)
    }
}

public class ResponseCommit: Result {
    
    public static func ok(data: Data = Data(), log: String = "") -> ResponseCommit {
        return ResponseCommit(0, data, log)
    }
    
    public static func error(_ errno: Int, data: Data = Data(), log: String = "") -> ResponseCommit {
        assert( errno > 0)
        return ResponseCommit(UInt32(errno), data, log)
    }
}

extension Types_ResponseDeliverTx {
    init(_ r: ResponseDeliverTx) {
        // TODO: properly init
        self.code = r.code
        self.data = r.data
        self.log = r.log
    }
}

extension Types_ResponseCheckTx {
    init(_ r: ResponseCheckTx) {
        // TODO: properly init
        self.code = r.code
        self.data = r.data
        self.log = r.log
    }
}

extension Types_ResponseCommit {
    init(_ r: Result) {
        self.data = r.data
    }
}

public struct ResponseEndBlock {
    public let updates: [ValidatorUpdate]
    public let consensusUpdates: ConsensusParams
    public let events: [Event]
    
    public init(updates: [ValidatorUpdate], consensusUpdates: ConsensusParams, events: [Event]) {
        self.updates = updates
        self.consensusUpdates = consensusUpdates
        self.events = events
    }
}

extension Types_ResponseEndBlock {
    init(_ r: ResponseEndBlock) {
        self.validatorUpdates = r.updates.map{Types_ValidatorUpdate($0)}
        self.consensusParamUpdates = Types_ConsensusParams(r.consensusUpdates)
        self.events = r.events.map{ Types_Event($0) }
    }
}

public class ResponseCheckTx: Result {
    let gasWanted: Int64
    let gasUsed: Int64
    let events: [Event]
    let codespace: String
    
    private init(_ code: UInt32, _ data: Data, _ log: String, _ gasWanted: Int64, _ gasUsed: Int64, _ events: [Event], _ codespace: String) {
        self.gasWanted = gasWanted
        self.gasUsed = gasUsed
        self.events = events
        self.codespace = codespace
        super.init(code, data, log)
    }
    
    public static func ok(gasWanted: Int64 = 0, gasUsed: Int64 = 0, events: [Event] = [], codespace: String = "", data: Data = Data(), log: String = "") -> ResponseCheckTx {
        return ResponseCheckTx(0, data, log, gasWanted, gasUsed, events, codespace)
    }
    
    public static func error(_ errno: Int, gasWanted: Int64 = 0, gasUsed: Int64 = 0, events: [Event] = [], codespace: String = "", data: Data = Data(), log: String = "") -> ResponseCheckTx {
        assert( errno > 0)
        return ResponseCheckTx(UInt32(errno), data, log, gasWanted, gasUsed, events, codespace)
    }
}

public struct ProofOp {
    public let type: String
    public let key: Data
    public let data: Data
    
    public init(type: String, key: Data , data: Data) {
        self.type = type
        self.key = key
        self.data = data
    }
}

extension Merkle_ProofOp{
    init(_ p: ProofOp) {
        self.type = p.type
        self.key = p.key
        self.data = p.data
    }
}

public struct Proof {
    public let ops: [ProofOp]
    public init(ops: [ProofOp]) {
        self.ops = ops
    }
}

extension Merkle_Proof {
    init(_ p: Proof) {
        self.ops = p.ops.map{ Merkle_ProofOp($0) }
    }
}

public class ResponseQuery: Result {
    public let index: Int64
    public var key: Data
    public let value: Data
    public let proof: Proof
    public let height: Int64
    public let codespace: String
    
    private init(_ code: UInt32, _ index: Int64, _ key: Data,_ value: Data, _ proof: Proof, _ height: Int64, _ codespace: String, _ log: String) {
        self.index = index
        self.key = key
        self.value = value
        self.proof = proof
        self.height = height
        self.codespace = codespace
        super.init(code, key, log)
    }
    
    public static func ok(proof: Proof, index: Int64 = 0, key: Data = Data(), value: Data = Data(), height: Int64 = 0, codespace: String = "", log: String = "") -> ResponseQuery {
        return ResponseQuery(0, index, key, value, proof, height, codespace, log)
    }
    
    public static func error(_ errno: Int, proof: Proof,  index: Int64 = 0, key: Data = Data(), value: Data = Data(), height: Int64 = 0, codespace: String = "", log: String = "") -> ResponseQuery {
        assert( errno > 0)
        return ResponseQuery(UInt32(errno), index, key, value, proof, height, codespace, log)
    }
}

extension Types_ResponseQuery {
    init(_ r: ResponseQuery) {
        self.code = r.code
        self.key = r.key
        self.value = r.value
        self.proof = Merkle_Proof(r.proof)
        self.index = r.index
        self.height = r.height
        self.codespace = r.codespace
        self.log = r.log
    }
}
