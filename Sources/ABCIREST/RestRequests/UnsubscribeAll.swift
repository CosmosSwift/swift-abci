import NIO

extension RESTRequest {
    static func unsubscribeAll(id: Int, params: UnsubscribeAllParameters) -> RESTRequest<UnsubscribeAllParameters> {
        .init(id: id, method: .unsubscribeAll, params: params)
    }
}

extension RESTClient {
    func unsubscribeAll(id: Int, params: UnsubscribeAllParameters) throws -> EventLoopFuture<RESTResponse<UnsubscribeAllResponse>> {
        let restRequest = RESTRequest<UnsubscribeAllParameters>.unsubscribeAll(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct UnsubscribeAllParameters: Codable { }

public struct UnsubscribeAllResponse: Codable {
    
}
