import NIO

extension RESTRequest where Parameters == BlockResultsParameters {
    static func blockResults(id: Int, params: BlockResultsParameters) -> RESTRequest<BlockResultsParameters> {
        .init(id: id, method: .blockResults, params: params)
    }
}

extension RESTClient {
    func blockResults(id: Int, params: BlockResultsParameters) throws -> EventLoopFuture<RESTResponse<BlockResultsResponse>> {
        let restRequest = RESTRequest<BlockResultsParameters>.blockResults(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct BlockResultsParameters: Codable {
    let height: Never
}

public struct BlockResultsResponse: Codable {
    
}
