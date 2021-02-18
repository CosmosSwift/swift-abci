import Foundation
import ABCIMessages

extension ResponseDeliverTx: Codable, ResponseWrapper where Payload: Codable {
    
    enum CodingKeys: CodingKey {
        case code
        case log
        case info
        case data
        case gasWanted
        case gasUsed
        case events
        case codespace
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code = try container.decode(UInt32.self, forKey: .code)
        let log = try container.decode(String.self, forKey: .log)
        let info = try container.decode(String.self, forKey: .info)
        let gasWantedStr = try container.decode(String.self, forKey: .gasWanted)
        guard let gasWanted = Int64(gasWantedStr) else {
            throw RESTRequestError.badStringForUInt
        }
        let gasUsedStr = try container.decode(String.self, forKey: .gasUsed)
        guard let gasUsed = Int64(gasUsedStr) else {
            throw RESTRequestError.badStringForUInt
        }
        let events = try container.decode([Event].self, forKey: .events)
        
        let dataStr = (try? container.decode(String.self, forKey: .data)) ?? ""
        #warning("This base64 decoding should be factored out")
        let data = Data(base64Encoded: dataStr) ?? Data()
        
        let payload = try? JSONDecoder().decode(Payload.self, from: data)
        
        let codespace = try container.decode(String.self, forKey: .codespace)
        
        self.init(code: code, data: payload, log: log, info: info, gasWanted: gasWanted, gasUsed: gasUsed, events: events, codespace: codespace)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.code, forKey: .code)
        try container.encode(self.log, forKey: .log)
        try container.encode(self.info, forKey: .info)
        try container.encode("\(self.gasWanted)", forKey: .gasWanted)
        try container.encode("\(self.gasUsed)", forKey: .gasUsed)

        #warning("This base64 encoding should be factored out")
        let string = try Data(JSONEncoder().encode(self.payload)).base64EncodedString()
        
        try container.encode(string, forKey: .data)
        
        try container.encode(self.events, forKey: .events)

        try container.encode(self.codespace, forKey: .codespace)

    }
}
