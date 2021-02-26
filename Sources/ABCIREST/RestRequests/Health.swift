extension RESTRequest {
    static func health(id: Int, params: HealthParameters) -> RESTRequest<HealthParameters> {
        .init(id: id, method: .health, params: params)
    }
}

public struct HealthParameters: RequestParameters {
    public typealias ResponsePayload = HealthResponse
}

public struct HealthResponse: Codable {
    
}
