extension RESTRequest {
    static func consensusState(id: Int, params: ConsensusStateParameters) -> RESTRequest<ConsensusStateParameters> {
        .init(id: id, method: .consensusState, params: params)
    }
}

public struct ConsensusStateParameters: RequestParameters {
    public typealias ResponsePayload = ConsensusStateResponse
}

public struct ConsensusStateResponse: Codable {
    
}
