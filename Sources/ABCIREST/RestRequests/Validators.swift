extension RESTRequest {
    static func validators(id: Int, params: ValidatorsParameters) -> RESTRequest<ValidatorsParameters> {
        .init(id: id, method: .validators, params: params)
    }
}

public struct ValidatorsParameters: RequestParameters {
    public typealias ResponsePayload = ValidatorsResponse
    
    let page: Never
    let perPage: Never
}

public struct ValidatorsResponse: Codable {
    
}
