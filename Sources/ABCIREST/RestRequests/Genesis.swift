import NIO

extension RESTRequest {
    static func genesis(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .genesis, params: EmptyParameters())
    }
}

extension RESTClient {
    func genesis(id: Int) throws -> EventLoopFuture<RESTResponse<GenesisResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.genesis(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct GenesisResponse: Codable {
    
}
