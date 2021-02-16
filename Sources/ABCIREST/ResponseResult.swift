import ABCIMessages

// TODO: replace with Result<Payload.ResponsePayload, ErrorPayload>
enum ResponseResult<Payload: RequestPayload>: Codable {
    case response(_ payload: ResponseWrapper)
    case error(_ error: ErrorWrapper)

    enum CodingKeys: CodingKey {
        case response
        case error
    }
}

extension ResponseResult {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch Payload.method {
        case .abci_query:
            if let response = try? container.decodeIfPresent(ResponseQuery<Payload.ResponsePayload>.self, forKey: .response) {
                self = .response(response)
                return
            }
        }
        
        if let error = try? container.decodeIfPresent(ErrorWrapper.self, forKey: .error) {
            self = .error(error)
        } else {
            throw RESTRequestError.badPayload
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .response(payload):
            switch Payload.method {
            case .abci_query:
                try container.encode(payload as! ResponseQuery<Payload.ResponsePayload>, forKey: .response)
            }
        case let .error(error):
            try container.encode(error, forKey: .error)
        }
    }
    
}
