import NIO

extension RESTRequest {
    static func netInfo(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .netInfo, params: EmptyParameters())
    }
}

extension RESTClient {
    func netInfo(id: Int) throws -> EventLoopFuture<RESTResponse<NetInfoResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.netInfo(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct NetInfoResponse: Codable {
    
}
