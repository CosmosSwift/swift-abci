import NIO

extension RESTRequest {
    static func abciInfo(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .abciInfo, params: EmptyParameters())
    }
}

extension RESTClient {
    public func abciInfo(id: Int) throws -> EventLoopFuture<RESTResponse<ABCIInfoResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.abciInfo(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct ABCIInfoParameters: Codable { }
public struct ABCIInfoResponse: Codable { }
