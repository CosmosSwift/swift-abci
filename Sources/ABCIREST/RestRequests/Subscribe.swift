import NIO

extension RESTRequest {
    static func subscribe(id: Int, params: SubscribeParameters) -> RESTRequest<SubscribeParameters> {
        .init(id: id, method: .subscribe, params: params)
    }
}

extension RESTClient {
    public func subscribe(id: Int, params: SubscribeParameters) throws -> EventLoopFuture<RESTResponse<SubscribeResponse>> {
        let restRequest = RESTRequest<SubscribeParameters>.subscribe(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct SubscribeParameters: Codable {    
    let query: Never
}

public struct SubscribeResponse: Codable {
    
}
