extension RESTRequest {
    static func unconfirmedTransactions(id: Int, params: UnconfirmedTransactionsParameters) -> RESTRequest<UnconfirmedTransactionsParameters> {
        .init(id: id, method: .unconfirmedTransactions, params: params)
    }
}

public struct UnconfirmedTransactionsParameters: RequestParameters {
    public typealias ResponsePayload = UnconfirmedTransactionsResponse
    
    let limit: Never
}

public struct UnconfirmedTransactionsResponse: Codable {
    
}
