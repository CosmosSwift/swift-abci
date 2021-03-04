import NIO

extension RESTRequest {
    static func unsubscribe(id: Int, params: UnsubscribeParameters) -> RESTRequest<UnsubscribeParameters> {
        .init(id: id, method: .unsubscribe, params: params)
    }
}

extension RESTClient {
    public func unsubscribe(id: Int, params: UnsubscribeParameters) throws -> EventLoopFuture<RESTResponse<UnsubscribeResponse>> {
        let restRequest = RESTRequest<UnsubscribeParameters>.unsubscribe(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct UnsubscribeParameters: Codable {
    let query: Never
}

public struct UnsubscribeResponse: Codable {
    
}
