import Foundation
import ABCIMessages

extension ResponseQuery: Codable, ResponseWrapper where Payload: Codable {
    
    enum CodingKeys: CodingKey {
        case code
        case log
        case info
        case index
        case key
        case value
        case proofOps
        case height
        case codespace
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code = try container.decode(UInt32.self, forKey: .code)
        let log = try container.decode(String.self, forKey: .log)
        let info = try container.decode(String.self, forKey: .info)
        let indexStr = try container.decode(String.self, forKey: .index)
        guard let index = Int64(indexStr) else {
            throw RESTRequestError.badStringForUInt
        }
        
        let key = try? container.decode(Data.self, forKey: .key)
        
        let valueStr = (try? container.decode(String.self, forKey: .value)) ?? ""
        #warning("This base64 decoding should be factored out")
        let data = Data(base64Encoded: valueStr) ?? Data()
        
        let payload = try? JSONDecoder().decode(Payload.self, from: data)
        
        let proofOps =  try container.decode(ProofOps.self, forKey: .proofOps)

        let heightStr = try container.decode(String.self, forKey: .height)
        guard let height = Int64(heightStr) else {
            throw RESTRequestError.badStringForUInt
        }
        
        let codespace = try container.decode(String.self, forKey: .codespace)
        
        self.init(code: code, log: log, info: info, index: index, key: key, value: payload, proofOps: proofOps, height: height, codespace: codespace)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.code, forKey: .code)
        try container.encode(self.log, forKey: .log)
        try container.encode(self.info, forKey: .info)
        try container.encode("\(self.index)", forKey: .index)

        try container.encode(self.key, forKey: .key)

        #warning("This base64 encoding should be factored out")
        let string = try Data(JSONEncoder().encode(self.payload)).base64EncodedString()
        
        try container.encode(string, forKey: .value)
        
        try container.encode(self.proofOps, forKey: .proofOps)

        try container.encode("\(self.height)", forKey: .height)
        try container.encode(self.codespace, forKey: .codespace)

    }
}
