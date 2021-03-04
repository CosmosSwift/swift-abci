import NIO

extension RESTRequest {
    static func consensusState(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .consensusState, params: EmptyParameters())
    }
}

extension RESTClient {
    func consensusState(id: Int) throws -> EventLoopFuture<RESTResponse<ConsensusStateResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.consensusState(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct ConsensusStateResponse: Codable {
    
}
