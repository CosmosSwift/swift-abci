import NIO

extension RESTRequest {
    static func block(id: Int, params: BlockParameters) -> RESTRequest<BlockParameters> {
        .init(id: id, method: .block, params: params)
    }
}

extension RESTClient {
    func block(id: Int, params: BlockParameters) throws -> EventLoopFuture<RESTResponse<BlockResponse>> {
        let restRequest = RESTRequest<BlockParameters>.block(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct BlockParameters: Codable {
    let height: Never
}

public struct BlockResponse: Codable { }
