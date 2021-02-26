extension RESTRequest {
    static func blockByHash(id: Int, params: BlockByHashParameters) -> RESTRequest<BlockByHashParameters> {
        .init(id: id, method: .blockByHash, params: params)
    }
}

public struct BlockByHashParameters: RequestParameters {
    public typealias ResponsePayload = BlockByHashResponse
    
    let hash: Never
}

public struct BlockByHashResponse: Codable {
    
}
