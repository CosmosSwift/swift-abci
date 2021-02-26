extension RESTRequest {
    static func abciInfo(id: Int, params: ABCIInfoParameters) -> RESTRequest<ABCIInfoParameters> {
        .init(id: id, method: .abciInfo, params: params)
    }
}

public struct ABCIInfoParameters: RequestParameters {
    public typealias ResponsePayload = ABCIInfoResponse
}

public struct ABCIInfoResponse: Codable {
    
}
