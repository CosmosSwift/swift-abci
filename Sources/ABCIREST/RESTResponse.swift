public struct RESTResponse<Payload: Codable>: Codable {
    public let id: Int // Can be -1 in the response
    public let result: Result<Payload, ErrorWrapper>
    
    enum CodingKeys: CodingKey {
        case jsonrpc
        case id
        case result
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let jsonrpc = try? container.decode(String.self, forKey: .jsonrpc), jsonrpc == ABCI_REST.jsonRpcVersion else {
            throw RESTRequestError.wrongJSONRPCVersion
        }
        self.id = try container.decode(Int.self, forKey: .id)
        self.result = try container.decode(Result<Payload, ErrorWrapper>.self, forKey: .result)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ABCI_REST.jsonRpcVersion, forKey: .jsonrpc)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.result, forKey: .result)
    }
}

extension Result: Codable where Success: Codable, Failure == ErrorWrapper {
    enum CodingKeys: CodingKey {
        case success
        case failure
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let success = try? container.decode(Success.self, forKey: .success) {
            self = .success(success)
            return
        }
        if let failure = try? container.decode(Failure.self, forKey: .failure) {
            self = .failure(failure)
            return
        }
        throw RESTRequestError.badPayload
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .success(success):
            try container.encode(success, forKey: .success)
        case let .failure(failure):
            try container.encode(failure, forKey: .failure)
        }
    }
}
