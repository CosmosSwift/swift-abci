extension RESTRequest {
    static func dumpConsensusState(id: Int, params: DumpConsensusStateParameters) -> RESTRequest<DumpConsensusStateParameters> {
        .init(id: id, method: .dumpConsensusState, params: params)
    }
}

public struct DumpConsensusStateParameters: RequestParameters {
    public typealias ResponsePayload = DumpConsensusStateResponse
}

public struct DumpConsensusStateResponse: Codable {
    
}
