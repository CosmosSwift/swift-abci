import NIO

extension RESTRequest {
    static func blockchain(id: Int, params: BlockchainParameters) -> RESTRequest<BlockchainParameters> {
        .init(id: id, method: .blockchain, params: params)
    }
}

extension RESTClient {
    public func blockchain(id: Int, params: BlockchainParameters) throws -> EventLoopFuture<RESTResponse<BlockchainResponse>> {
        let restRequest = RESTRequest<BlockchainParameters>.blockchain(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct BlockchainParameters: Codable {
    let minHeight: Never
    let maxHeight: Never
}

public struct BlockchainResponse: Codable {
    
}
