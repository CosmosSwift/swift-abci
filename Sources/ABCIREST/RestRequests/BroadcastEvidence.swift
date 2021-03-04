import NIO

extension RESTRequest {
    static func broadcastEvidence(id: Int, params: BroadcastEvidenceParameters) -> RESTRequest<BroadcastEvidenceParameters> {
        .init(id: id, method: .broadcastEvidence, params: params)
    }
}

extension RESTClient {
    public func broadcastEvidence(id: Int, params: BroadcastEvidenceParameters) throws -> EventLoopFuture<RESTResponse<BroadcastEvidenceResponse>> {
        let restRequest = RESTRequest<BroadcastEvidenceParameters>.broadcastEvidence(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct BroadcastEvidenceParameters: Codable {
    let evidence: Never
}

public struct BroadcastEvidenceResponse: Codable {
    
}
