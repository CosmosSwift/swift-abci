extension RESTRequest {
    static func blockchain(id: Int, params: BlockchainParameters) -> RESTRequest<BlockchainParameters> {
        .init(id: id, method: .blockchain, params: params)
    }
}

public struct BlockchainParameters: RequestParameters {
    public typealias ResponsePayload = BlockchainResponse
    
    let minHeight: Never
    let maxHeight: Never
}

public struct BlockchainResponse: Codable {
    
}
