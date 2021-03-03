import NIO

extension RESTRequest {
    static func status(id: Int, params: StatusParameters) -> RESTRequest<StatusParameters> {
        .init(id: id, method: .status, params: params)
    }
}

extension RESTClient {
    func status(id: Int, params: StatusParameters) throws -> EventLoopFuture<RESTResponse<StatusResponse>> {
        let restRequest = RESTRequest<StatusParameters>.status(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct StatusParameters: Codable { }

public struct StatusResponse: Codable {
    
}
