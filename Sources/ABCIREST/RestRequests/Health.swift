import NIO

extension RESTRequest {
    static func health(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .health, params: EmptyParameters())
    }
}

extension RESTClient {
    public func health(id: Int) throws -> EventLoopFuture<RESTResponse<HealthResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.health(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct HealthResponse: Codable {

}
