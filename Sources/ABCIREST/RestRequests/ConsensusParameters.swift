import NIO

extension RESTRequest {
    static func consensusParameters(id: Int, params: ConsensusParametersParameters) -> RESTRequest<ConsensusParametersParameters> {
        .init(id: id, method: .consensusParameters, params: params)
    }
}

extension RESTClient {
    public func consensusParameters(id: Int, params: ConsensusParametersParameters) throws -> EventLoopFuture<RESTResponse<ConsensusParametersResponse>> {
        let restRequest = RESTRequest<BroadcastTransactionAsyncParameters>.consensusParameters(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct ConsensusParametersParameters: Codable {
    let height: Never
}

public struct ConsensusParametersResponse: Codable {
    
}
