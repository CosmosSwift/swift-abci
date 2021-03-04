import NIO

extension RESTRequest {
    static func blockByHash(id: Int, params: BlockByHashParameters) -> RESTRequest<BlockByHashParameters> {
        .init(id: id, method: .blockByHash, params: params)
    }
}

extension RESTClient {
    public func blockByHash(id: Int, params: BlockByHashParameters) throws -> EventLoopFuture<RESTResponse<BlockByHashResponse>> {
        let restRequest = RESTRequest<BlockByHashParameters>.blockByHash(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct BlockByHashParameters: Codable {
    let hash: Never
}

public struct BlockByHashResponse: Codable { }
