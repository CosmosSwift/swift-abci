extension RESTRequest {
    static func netInfo(id: Int, params: NetInfoParameters) -> RESTRequest<NetInfoParameters> {
        .init(id: id, method: .netInfo, params: params)
    }
}

public struct NetInfoParameters: RequestParameters {
    public typealias ResponsePayload = NetInfoResponse
}

public struct NetInfoResponse: Codable {
    
}
