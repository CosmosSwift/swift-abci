extension RESTRequest {
    static func checkTransaction(id: Int, params: CheckTransactionParameters) -> RESTRequest<CheckTransactionParameters> {
        .init(id: id, method: .checkTransaction, params: params)
    }
}

public struct CheckTransactionParameters: RequestParameters {
    public typealias ResponsePayload = CheckTransactionResponse
    
    let transaction: Never
}

public struct CheckTransactionResponse: Codable {
    
}
