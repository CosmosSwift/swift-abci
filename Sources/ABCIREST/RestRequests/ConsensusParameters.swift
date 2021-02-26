extension RESTRequest {
    static func consensusParameters(id: Int, params: ConsensusParametersParameters) -> RESTRequest<ConsensusParametersParameters> {
        .init(id: id, method: .consensusParameters, params: params)
    }
}

public struct ConsensusParametersParameters: RequestParameters {
    public typealias ResponsePayload = ConsensusParametersResponse
    
    let height: Never
}

public struct ConsensusParametersResponse: Codable {
    
}
