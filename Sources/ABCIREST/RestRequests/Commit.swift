import NIO

extension RESTRequest {
    static func commit(id: Int, params: CommitParameters) -> RESTRequest<CommitParameters> {
        .init(id: id, method: .commit, params: params)
    }
}

extension RESTClient {
    func commit(id: Int, params: CommitParameters) throws -> EventLoopFuture<RESTResponse<CommitResponse>> {
        let restRequest = RESTRequest<CommitParameters>.commit(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct CommitParameters: Codable {    
    let height: Never
}

public struct CommitResponse: Codable {
    
}
