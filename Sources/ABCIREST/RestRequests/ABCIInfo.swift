import NIO

extension RESTRequest {
    static func abciInfo(id: Int, params: ABCIInfoParameters) -> RESTRequest<ABCIInfoParameters> {
        .init(id: id, method: .abciInfo, params: params)
    }
}

extension RESTClient {
    func abciInfo(id: Int, params: ABCIInfoParameters) throws -> EventLoopFuture<RESTResponse<ABCIInfoResponse>> {
        let restRequest = RESTRequest<ABCIInfoParameters>.abciInfo(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct ABCIInfoParameters: Codable { }
public struct ABCIInfoResponse: Codable { }
