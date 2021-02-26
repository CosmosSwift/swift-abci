public struct RESTResponse<Payload: RequestParameters>: Codable {
    public let id: Int // Can be -1 in the response
    public let result: ResponseResult<Payload>
    
    enum CodingKeys: CodingKey {
        case jsonrpc
        case id
        case result
    }
}

extension RESTResponse {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let jsonrpc = try? container.decode(String.self, forKey: .jsonrpc), jsonrpc == ABCI_REST.jsonRpcVersion else {
            throw RESTRequestError.wrongJSONRPCVersion
        }
        self.id = try container.decode(Int.self, forKey: .id)
        self.result = try container.decode(ResponseResult<Payload>.self, forKey: .result)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ABCI_REST.jsonRpcVersion, forKey: .jsonrpc)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.result, forKey: .result)
    }
    
}
