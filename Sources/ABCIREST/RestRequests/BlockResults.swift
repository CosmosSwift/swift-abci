extension RESTRequest {
    static func blockResults(id: Int, params: BlockResultsParameters) -> RESTRequest<BlockResultsParameters> {
        .init(id: id, method: .blockResults, params: params)
    }
}

public struct BlockResultsParameters: RequestParameters {
    public typealias ResponsePayload = BlockResultsResponse
    
    let height: Never
}

public struct BlockResultsResponse: Codable {
    
}
