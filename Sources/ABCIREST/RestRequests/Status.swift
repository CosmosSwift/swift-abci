extension RESTRequest {
    static func status(id: Int, params: StatusParameters) -> RESTRequest<StatusParameters> {
        .init(id: id, method: .status, params: params)
    }
}

public struct StatusParameters: RequestParameters {
    public typealias ResponsePayload = StatusResponse
}

public struct StatusResponse: Codable {
    
}
