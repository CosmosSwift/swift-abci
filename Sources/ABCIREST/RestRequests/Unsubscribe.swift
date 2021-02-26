extension RESTRequest {
    static func unsubscribe(id: Int, params: UnsubscribeParameters) -> RESTRequest<UnsubscribeParameters> {
        .init(id: id, method: .unsubscribe, params: params)
    }
}

public struct UnsubscribeParameters: RequestParameters {
    public typealias ResponsePayload = UnsubscribeResponse
    
    let query: Never
}

public struct UnsubscribeResponse: Codable {
    
}
