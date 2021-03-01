import ABCIMessages

// TODO: replace with Result<Payload.ResponsePayload, ErrorPayload>
public enum ResponseResult<Parameters: RequestParameters>: Codable {
    case response(_ response: ResponseWrapper)
    case error(_ error: ErrorWrapper)

    enum CodingKeys: CodingKey {
        case response
        case error
    }
}

extension ResponseResult {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let response = try container.decodeIfPresent(ResponseQuery<Parameters.ResponsePayload>.self, forKey: .response) {
            self = .response(response)
            return
        }
        
        if let error = try? container.decodeIfPresent(ErrorWrapper.self, forKey: .error) {
            self = .error(error)
        } else {
            throw RESTRequestError.badPayload
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .response(response):
            try container.encode(response as! ResponseQuery<Parameters.ResponsePayload>, forKey: .response)
        case let .error(error):
            try container.encode(error, forKey: .error)
        }
    }
    
}
