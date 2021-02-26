extension RESTRequest {
    static func subscribe(id: Int, params: SubscribeParameters) -> RESTRequest<SubscribeParameters> {
        .init(id: id, method: .subscribe, params: params)
    }
}

public struct SubscribeParameters: RequestParameters {
    public typealias ResponsePayload = SubscribeResponse
    
    let query: Never
}

public struct SubscribeResponse: Codable {
    
}
