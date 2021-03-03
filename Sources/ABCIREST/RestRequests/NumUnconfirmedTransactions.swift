import NIO

extension RESTRequest {
    static func numUnconfirmedTransactions(id: Int, params: NumUnconfirmedTransactionsParameters) -> RESTRequest<NumUnconfirmedTransactionsParameters> {
        .init(id: id, method: .numUnconfirmedTransactions, params: params)
    }
}

extension RESTClient {
    func numUnconfirmedTransactions(id: Int, params: NumUnconfirmedTransactionsParameters) throws -> EventLoopFuture<RESTResponse<NumUnconfirmedTransactionsResponse>> {
        let restRequest = RESTRequest<NumUnconfirmedTransactionsParameters>.numUnconfirmedTransactions(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct NumUnconfirmedTransactionsParameters: Codable { }

public struct NumUnconfirmedTransactionsResponse: Codable {
    
}
