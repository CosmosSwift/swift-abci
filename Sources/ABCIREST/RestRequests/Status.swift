import NIO

extension RESTRequest {
    static func status(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .status, params: EmptyParameters())
    }
}

extension RESTClient {
    public func status(id: Int) throws -> EventLoopFuture<RESTResponse<StatusResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.status(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct StatusResponse: Codable {
    
}
