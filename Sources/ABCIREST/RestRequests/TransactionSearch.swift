import NIO

extension RESTRequest {
    static func transactionSearch(id: Int, params: TransactionSearchParameters) -> RESTRequest<TransactionSearchParameters> {
        .init(id: id, method: .transactionSearch, params: params)
    }
}

extension RESTClient {
    public func transactionSearch(id: Int, params: TransactionSearchParameters) throws -> EventLoopFuture<RESTResponse<TransactionSearchResponse>> {
        let restRequest = RESTRequest<TransactionSearchParameters>.transactionSearch(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct TransactionSearchParameters: Codable {    
    let query: Never
    let prove: Never
    let page: Never
    let perPage: Never
    let orderBy: Never
}

public struct TransactionSearchResponse: Codable {
    
}
