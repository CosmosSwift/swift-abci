import ABCIMessages

struct RESTRequest<Payload: RequestPayload>: Codable {
    let id: Int // Can be -1 in the response
    var method: Method { self.params.method }
    let params: RequestWrapper
    
    enum CodingKeys: CodingKey {
        case jsonrpc
        case id
        case method
        case params
    }
    
    public init<Request: RequestWrapper>(request: Request, id: Int) {
        self.id = id
        self.params = request
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let jsonrpc = try? container.decode(String.self, forKey: .jsonrpc), jsonrpc == ABCI_REST.jsonRpcVersion else {
            throw RESTRequestError.wrongJSONRPCVersion
        }
        self.id = try container.decode(Int.self, forKey: .id)
        let method = try container.decode(Method.self, forKey: .method)
        switch method {
        case .abci_query:
            self.params = try container.decode(RequestQuery<Payload>.self, forKey: .params)
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ABCI_REST.jsonRpcVersion, forKey: .jsonrpc)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.method, forKey: .method)
        switch self.method {
        case .abci_query:
            try container.encode(self.params as! RequestQuery<Payload>, forKey: .params)
        }
    }
}
