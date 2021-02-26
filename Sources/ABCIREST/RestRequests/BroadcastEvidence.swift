extension RESTRequest {
    static func broadcastEvidence(id: Int, params: BroadcastEvidenceParameters) -> RESTRequest<BroadcastEvidenceParameters> {
        .init(id: id, method: .broadcastEvidence, params: params)
    }
}

public struct BroadcastEvidenceParameters: RequestParameters {
    public typealias ResponsePayload = BroadcastEvidenceResponse
    
    let evidence: Never
}

public struct BroadcastEvidenceResponse: Codable {
    
}
