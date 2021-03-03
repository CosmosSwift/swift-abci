import NIO

extension RESTRequest {
    static func consensusState(id: Int, params: ConsensusStateParameters) -> RESTRequest<ConsensusStateParameters> {
        .init(id: id, method: .consensusState, params: params)
    }
}

extension RESTClient {
    func consensusState(id: Int, params: ConsensusStateParameters) throws -> EventLoopFuture<RESTResponse<ConsensusStateResponse>> {
        let restRequest = RESTRequest<ConsensusStateParameters>.consensusState(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct ConsensusStateParameters: Codable { }

public struct ConsensusStateResponse: Codable {
    
}
