extension RESTRequest {
    static func transactionSearch(id: Int, params: TransactionSearchParameters) -> RESTRequest<TransactionSearchParameters> {
        .init(id: id, method: .transactionSearch, params: params)
    }
}

public struct TransactionSearchParameters: RequestParameters {
    public typealias ResponsePayload = TransactionSearchResponse
    
    let query: Never
    let prove: Never
    let page: Never
    let perPage: Never
    let orderBy: Never
}

public struct TransactionSearchResponse: Codable {
    
}
