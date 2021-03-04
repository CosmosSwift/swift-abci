import NIO

extension RESTRequest {
    static func unsubscribeAll(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .unsubscribeAll, params: EmptyParameters())
    }
}

extension RESTClient {
    public func unsubscribeAll(id: Int) throws -> EventLoopFuture<RESTResponse<UnsubscribeAllResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.unsubscribeAll(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct UnsubscribeAllResponse: Codable {
    
}
