extension RESTRequest {
    static func transaction(id: Int, params: TransactionParameters) -> RESTRequest<TransactionParameters> {
        .init(id: id, method: .transaction, params: params)
    }
}

public struct TransactionParameters: RequestParameters {
    public typealias ResponsePayload = TransactionResponse
    
    let hash: Never
    let prove: Never
}

public struct TransactionResponse: Codable {
    
}
