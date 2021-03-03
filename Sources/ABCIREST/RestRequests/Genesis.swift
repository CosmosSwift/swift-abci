import NIO

extension RESTRequest {
    static func genesis(id: Int, params: GenesisParameters) -> RESTRequest<GenesisParameters> {
        .init(id: id, method: .genesis, params: params)
    }
}

extension RESTClient {
    func genesis(id: Int, params: GenesisParameters) throws -> EventLoopFuture<RESTResponse<GenesisResponse>> {
        let restRequest = RESTRequest<GenesisParameters>.genesis(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct GenesisParameters: Codable { }

public struct GenesisResponse: Codable {
    
}
