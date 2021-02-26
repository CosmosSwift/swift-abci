extension RESTRequest {
    static func commit(id: Int, params: CommitParameters) -> RESTRequest<CommitParameters> {
        .init(id: id, method: .commit, params: params)
    }
}

public struct CommitParameters: RequestParameters {
    public typealias ResponsePayload = CommitResponse
    
    let height: Never
}

public struct CommitResponse: Codable {
    
}
