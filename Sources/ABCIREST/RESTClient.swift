//
//  File.swift
//  
//
//  Created by Jaap Wijnen on 01/03/2021.
//

import Foundation
import AsyncHTTPClient
import NIO

struct RESTClient {
    let url: String
    let client: HTTPClient
    
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    func sendRequest<Payload: Codable, ResponsePayload: Codable>(payload: RESTRequest<Payload>) throws -> EventLoopFuture<RESTResponse<ResponsePayload>> {
        var request = try HTTPClient.Request(url: url, method: .POST)
        request.headers.add(name: "User-Agent", value: ABCI_REST.httpClientType)
        request.headers.add(name: "Content-Type", value: "text/json")
        
        guard let data = try? jsonEncoder.encode(payload) else {
            throw RESTRequestError.badRequest
        }
        
        let bodyString = String(data: data, encoding: .utf8) ?? ""
        request.body = .string(bodyString)
        
        return client.execute(request: request).flatMapThrowing { response in
            guard let buffer = response.body else {
                throw RESTRequestError.badResponse
            }
            return try jsonDecoder.decode(RESTResponse<ResponsePayload>.self, from: Data(buffer: buffer))
        }
    }
}
