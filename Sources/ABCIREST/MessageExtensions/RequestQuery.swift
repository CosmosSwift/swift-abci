import Foundation
import ABCIMessages


extension RequestQuery: Codable, RequestWrapper where Payload: RequestPayload {
    
    enum CodingKeys: CodingKey {
        case data
        case height
        case path
        case prove
    }
    
    public var method: Method { .abci_query }
    
    public init(payload: Payload, height:Int64, prove: Bool) {
        self.init(payload: payload, path: payload.path, height: height, prove: prove)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let string = try container.decode(String.self, forKey: .data)
        #warning("This hex decoding should be factored out")
        guard let data = string.toData(), let payload = Payload.init(data: data) else {
            throw RESTRequestError.badPayload
        }
        
        let heightStr = try container.decode(String.self, forKey: .height)
        guard let height = Int64(heightStr) else {
            throw RESTRequestError.badStringForUInt
        }
        let prove = try container.decode(Bool.self, forKey: .prove)
        
        self.init(payload: payload, height: height, prove: prove)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        #warning("This hex encoding should be factored out")
        try container.encode(self.payload.data.hexEncodedString(), forKey: .data) // Assumes default encoding for Data type is hex string
        try container.encode("\(self.height)", forKey: .height)
        try container.encode(self.path, forKey: .path)
        try container.encode(self.prove, forKey: .prove)
    }
}
