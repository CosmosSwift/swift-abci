import NIO

extension RESTRequest {
    static func dumpConsensusState(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .dumpConsensusState, params: EmptyParameters())
    }
}

extension RESTClient {
    public func dumpConsensusState(id: Int) throws -> EventLoopFuture<RESTResponse<DumpConsensusStateResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.dumpConsensusState(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct DumpConsensusStateResponse: Codable {
    
}
