import NIO

extension RESTRequest {
    static func dumpConsensusState(id: Int, params: DumpConsensusStateParameters) -> RESTRequest<DumpConsensusStateParameters> {
        .init(id: id, method: .dumpConsensusState, params: params)
    }
}

extension RESTClient {
    func dumpConsensusState(id: Int, params: DumpConsensusStateParameters) throws -> EventLoopFuture<RESTResponse<DumpConsensusStateResponse>> {
        let restRequest = RESTRequest<DumpConsensusStateParameters>.dumpConsensusState(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct DumpConsensusStateParameters: Codable { }

public struct DumpConsensusStateResponse: Codable {
    
}
