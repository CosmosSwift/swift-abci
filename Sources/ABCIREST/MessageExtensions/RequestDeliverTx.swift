import Foundation
import ABCIMessages


extension RequestDeliverTx: Codable, RequestWrapper where Payload: RequestPayload {
    
    enum CodingKeys: CodingKey {
        case tx
    }
    
    public var method: Method { .tx }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let string = try container.decode(String.self, forKey: .tx)
        #warning("This hex decoding should be factored out")
        guard let data = string.toData(), let payload =
                try? JSONDecoder().decode(Payload.self, from: data) else {
            throw RESTRequestError.badPayload
        }
        
        self.init(payload: payload)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        #warning("This hex encoding should be factored out")
        let data = (try? JSONEncoder().encode(self.payload)) ?? Data()
        try container.encode(data.hexEncodedString(options: [.upperCase]), forKey: .tx) // Assumes default encoding for Data type is hex string
    }
}
