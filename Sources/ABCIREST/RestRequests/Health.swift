import NIO

extension RESTRequest {
    static func health(id: Int, params: HealthParameters) -> RESTRequest<HealthParameters> {
        .init(id: id, method: .health, params: params)
    }
}

extension RESTClient {
    func health(id: Int, params: HealthParameters) throws -> EventLoopFuture<RESTResponse<HealthResponse>> {
        let restRequest = RESTRequest<HealthParameters>.health(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct HealthParameters: Codable { }

public struct HealthResponse: Codable {

}
