import NIO

extension RESTRequest {
    static func netInfo(id: Int, params: NetInfoParameters) -> RESTRequest<NetInfoParameters> {
        .init(id: id, method: .netInfo, params: params)
    }
}

extension RESTClient {
    func netInfo(id: Int, params: NetInfoParameters) throws -> EventLoopFuture<RESTResponse<NetInfoResponse>> {
        let restRequest = RESTRequest<NetInfoParameters>.netInfo(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct NetInfoParameters: Codable { }

public struct NetInfoResponse: Codable {
    
}
