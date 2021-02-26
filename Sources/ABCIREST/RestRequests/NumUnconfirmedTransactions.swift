extension RESTRequest {
    static func numUnconfirmedTransactions(id: Int, params: NumUnconfirmedTransactionsParameters) -> RESTRequest<NumUnconfirmedTransactionsParameters> {
        .init(id: id, method: .numUnconfirmedTransactions, params: params)
    }
}

public struct NumUnconfirmedTransactionsParameters: RequestParameters {
    public typealias ResponsePayload = NumUnconfirmedTransactionsResponse
}

public struct NumUnconfirmedTransactionsResponse: Codable {
    
}
