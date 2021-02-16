public enum RESTRequestError: Swift.Error {
    case badPayload
    case badStringForUInt
    case wrongJSONRPCVersion
    case badRequest
    case badResponse
    case unknown
}
