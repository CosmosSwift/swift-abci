extension RESTRequest {
    static func unsubscribeAll(id: Int, params: UnsubscribeAllParameters) -> RESTRequest<UnsubscribeAllParameters> {
        .init(id: id, method: .unsubscribeAll, params: params)
    }
}

public struct UnsubscribeAllParameters: RequestParameters {
    public typealias ResponsePayload = UnsubscribeAllResponse
}

public struct UnsubscribeAllResponse: Codable {
    
}
