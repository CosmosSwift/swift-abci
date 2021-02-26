extension RESTRequest {
    static func genesis(id: Int, params: GenesisParameters) -> RESTRequest<GenesisParameters> {
        .init(id: id, method: .genesis, params: params)
    }
}

public struct GenesisParameters: RequestParameters {
    public typealias ResponsePayload = GenesisResponse
}

public struct GenesisResponse: Codable {
    
}
