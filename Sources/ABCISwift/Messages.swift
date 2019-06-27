//
//  Messages.swift
//  ABCISwift
//

import Foundation


public struct Validator {
    public let pubKey: Data
    public let power: Int64
}

extension Validator {
    init(protobuf: Types_Validator) {
        self.power = protobuf.power
        self.pubKey = protobuf.pubKey
    }
}

extension Types_Validator {
    init(_ r: Validator) {
        self.power = r.power
        self.pubKey = r.pubKey
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
    public let hasParts: Bool
}

extension BlockID {
    init (protobuf: Types_BlockID) {
        self.hash = protobuf.hash
        self.parts = PartSetHeader(protobuf: protobuf.parts)
        self.hasParts = protobuf.hasParts
    }
}

public struct Header {
    public let chainID: String
    public let height: Int64
    public let time: Int64
    public let numTxs: Int32
    public let lastBlockID: BlockID
    public let hasLastBlockID: Bool
    public let lastCommitHash: Data
    public let dataHash: Data
    public let validatorHash: Data
    public let appHash: Data
}

extension Header {
    init(protobuf: Types_Header) {
        self.chainID = protobuf.chainID
        self.height = protobuf.height
        self.time = protobuf.time
        self.numTxs = protobuf.numTxs
        self.lastBlockID = BlockID(protobuf: protobuf.lastBlockID)
        self.hasLastBlockID = protobuf.hasLastBlockID
        self.lastCommitHash = protobuf.lastCommitHash
        self.dataHash = protobuf.dataHash
        self.validatorHash = protobuf.validatorsHash
        self.appHash = protobuf.appHash
    }
}

public struct Evidence {
    public let pubKey: Data
    public let height: Int64
}

extension Evidence {
    init(protobuf: Types_Evidence) {
        self.pubKey = protobuf.pubKey
        self.height = protobuf.height
    }
}

public struct BlockGossip {
    public let blockPartSizeBytes: Int32 // should NOT be null
}

extension BlockGossip {
    init(protobuf: Types_BlockGossip) {
        self.blockPartSizeBytes = protobuf.blockPartSizeBytes
    }
}

extension Types_BlockGossip {
    init(_ r: BlockGossip) {
        self.blockPartSizeBytes = r.blockPartSizeBytes
    }
}

public struct BlockSize {
    public let maxBytes: Int32
    public let maxTxs: Int32
    public let maxGas: Int64
}

extension BlockSize {
    init(protobuf: Types_BlockSize) {
        self.maxBytes = protobuf.maxBytes
        self.maxTxs = protobuf.maxTxs
        self.maxGas = protobuf.maxGas
    }
}

extension Types_BlockSize {
    init(_ r: BlockSize) {
        self.maxBytes = r.maxBytes
        self.maxTxs = r.maxTxs
        self.maxGas = r.maxGas
    }
}

public struct TxSize {
    public let maxBytes: Int32
    public let maxGas: Int64
}

extension TxSize {
    init(protobuf: Types_TxSize) {
        self.maxBytes = protobuf.maxBytes
        self.maxGas = protobuf.maxGas
    }
}

extension Types_TxSize {
    init(_ r: TxSize) {
        self.maxBytes = r.maxBytes
        self.maxGas = r.maxGas
    }
}


public struct ConsensusParams {
    public let blockSize: BlockSize
    public let txSize: TxSize
    public let blockGossip: BlockGossip
}

extension ConsensusParams {
    init(protobuf: Types_ConsensusParams) {
        self.blockSize = BlockSize(protobuf:protobuf.blockSize)
        self.txSize = TxSize(protobuf: protobuf.txSize)
        self.blockGossip = BlockGossip(protobuf: protobuf.blockGossip)
    }
}

extension Types_ConsensusParams {
    init(_ r: ConsensusParams) {
        self.blockSize = Types_BlockSize(r.blockSize)
        self.txSize = Types_TxSize(r.txSize)
        self.blockGossip = Types_BlockGossip(r.blockGossip)
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

extension Result {
    public static func ok(data: Data = Data(), log: String = "") -> Result {
        return Result(0, data, log)
    }
    
    public static func error(_ errno: Int, data: Data = Data(), log: String = "") -> Result {
        assert( errno != 0)
        return Result(UInt32(errno), data, log)
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
}

extension Types_ResponseEcho {
    init(_ r: ResponseEcho) {
        self.message = r.message
    }
}

public struct ResponseInfo {
    public let data: String
    public let version: String
    public let lastBlockHeight: Int64
    public let lastBlockAppHash: Data
    
    public init(data: String = "", version: String = "", lastBlockHeight: Int64 = 0, lastBlockAppHash: Data = Data()) {
        self.data = data
        self.version = version
        self.lastBlockHeight = lastBlockHeight
        self.lastBlockAppHash = lastBlockAppHash
    }
}

extension Types_ResponseInfo {
    init(_ r: ResponseInfo) {
        self.data = r.data
        self.version = r.version
        self.lastBlockHeight = r.lastBlockHeight
        self.lastBlockAppHash = r.lastBlockAppHash
    }
}

public struct ResponseSetOption {
    public let log: String
    
    public init(_ log: String = "") {
        self.log = log
    }
}

extension Types_ResponseSetOption {
    init(_ r: ResponseSetOption) {
        self.log = r.log
    }
}

public enum StringOrInt: Hashable, Equatable, CustomStringConvertible {
    
    case string(String)
    case int(Int64)
    
    public var hashValue: Int {
        get {
            switch self {
            case .string(let s):
                return s.hashValue
            case .int(let i):
                return i.hashValue
            }
        }
    }
    
    public static func ==(lhs: StringOrInt, rhs: StringOrInt) -> Bool {
        switch lhs {
        case .string(let sl):
            switch rhs {
            case .string(let sr):
                return sl == sr
            case .int:
                return false
            }
        case .int(let il):
            switch lhs {
            case .string:
                return false
            case .int(let ir):
             return il == ir
            }
        }
    }
    
    public var description: String {
        switch self {
        case .string(let s):
            return s.description
        case .int(let i):
            return i.description
        }
    }
}

public class ResponseDeliverTx: Result {
    let tags: [String: StringOrInt]
    
    private init(_ code: UInt32, _ data: Data, _ log: String, _ tags: [String: StringOrInt]) {
        self.tags = tags
        super.init(code, data, log)
    }
    
    public static func ok(tags: [String: StringOrInt] = [String: StringOrInt](), data: Data = Data(), log: String = "") -> ResponseDeliverTx {
        return ResponseDeliverTx(0, data, log, tags)
    }
    
    public static func error(_ errno: Int, tags: [String: StringOrInt] = [String: StringOrInt](), data: Data = Data(), log: String = "") -> ResponseDeliverTx {
        assert( errno > 0)
        return ResponseDeliverTx(UInt32(errno), data, log, tags)
    }
}


public class ResponseCommit: Result {}

extension Types_ResponseDeliverTx {
    init(_ r: Result) {
        self.code = r.code
        self.data = r.data
        self.log = r.log
    }
}

extension Types_ResponseCheckTx {
    init(_ r: Result) {
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
    public let updates: [Validator]
    public let consensusUpdates: ConsensusParams
}

extension Types_ResponseEndBlock {
    init(_ r: ResponseEndBlock) {
        var validators: [Types_Validator] = []
        for v in r.updates {
            validators.append(Types_Validator(v))
        }
        self.validatorUpdates = validators
        self.consensusParamUpdates = Types_ConsensusParams(r.consensusUpdates)
    }
}


public class ResponseCheckTx: Result {
    let gas: Int64
    let fee: Int64
    
    private init(_ code: UInt32, _ data: Data, _ log: String, _ gas: Int64, _ fee: Int64) {
        self.gas = gas
        self.fee = fee
        super.init(code, data, log)
    }
    
    public static func ok(gas: Int64 = 0, fee: Int64 = 0, data: Data = Data(), log: String = "") -> ResponseCheckTx {
        return ResponseCheckTx(0, data, log, gas, fee)
    }
    
    public static func error(_ errno: Int, gas: Int64 = 0, fee: Int64 = 0, data: Data = Data(), log: String = "") -> ResponseCheckTx {
        assert( errno > 0)
        return ResponseCheckTx(UInt32(errno), data, log, gas, fee)
    }
}

public class ResponseQuery: Result {
    public let index: Int64
    public var key: Data {
        get {
            return data
        }
    }
    
    public let value: Data
    public let proof: Data
    public let height: Int64
    
    private init(_ code: UInt32, _ index: Int64, _ key: Data,_ value: Data, _ proof: Data, _ height: Int64, _ log: String) {
        self.index = index
        self.value = value
        self.proof = proof
        self.height = height
        super.init(code, key, log)
    }
    
    public static func ok(index: Int64 = 0, key: Data = Data(), value: Data = Data(), proof: Data = Data(), height: Int64 = 0, log: String = "") -> ResponseQuery {
        return ResponseQuery(0, index, key, value, proof, height, log)
    }
    
    public static func error(_ errno: Int, index: Int64 = 0, key: Data = Data(), value: Data = Data(), proof: Data = Data(), height: Int64 = 0, log: String = "") -> ResponseQuery {
        assert( errno > 0)
        return ResponseQuery(UInt32(errno), index, key, value, proof, height, log)
    }
}


extension Types_ResponseQuery {
    init(_ r: ResponseQuery) {
        self.code = r.code
        self.key = r.key
        self.value = r.value
        self.proof = r.proof
        self.index = r.index
        self.height = r.height
        self.log = r.log
    }
}
