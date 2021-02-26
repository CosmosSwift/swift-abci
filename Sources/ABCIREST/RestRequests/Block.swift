extension RESTRequest {
    static func block(id: Int, params: BlockParameters) -> RESTRequest<BlockParameters> {
        .init(id: id, method: .block, params: params)
    }
}

public struct BlockParameters: RequestParameters {
    public typealias ResponsePayload = BlockResponse
    
    let height: Never
}

public struct BlockResponse: Codable {
    
}
