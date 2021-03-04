import NIO

extension RESTRequest {
    static func validators(id: Int, params: ValidatorsParameters) -> RESTRequest<ValidatorsParameters> {
        .init(id: id, method: .validators, params: params)
    }
}

extension RESTClient {
    public func validators(id: Int, params: ValidatorsParameters) throws -> EventLoopFuture<RESTResponse<ValidatorsResponse>> {
        let restRequest = RESTRequest<ValidatorsParameters>.validators(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct ValidatorsParameters: Codable {    
    let page: Never
    let perPage: Never
}

public struct ValidatorsResponse: Codable {
    
}
