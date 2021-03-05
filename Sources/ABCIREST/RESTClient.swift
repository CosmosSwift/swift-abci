//
//  File.swift
//  
//
//  Created by Jaap Wijnen on 01/03/2021.
//

import Foundation
import AsyncHTTPClient
import NIO
import NIOHTTP1

public struct RESTClient {
    let url: String
    let client: HTTPClient
    
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    public init(url: String, httpClient: HTTPClient) {
        self.url = url
        self.client = httpClient
    }
}

extension RESTClient {
    public func abciInfo(id: Int) -> EventLoopFuture<RESTResponse<ABCIInfoResponse>> {
        struct ABCIInfoParameters: Codable { }
        let payload = RESTRequest(id: id, method: .abciInfo, params: ABCIInfoParameters())
        return self.sendRequest(payload: payload)
    }
    
    public func abciQuery<RequestPayload: Codable, ResponsePayload: Codable>(id: Int, parameters: ABCIQueryParameters<RequestPayload>) -> EventLoopFuture<RESTResponse<ABCIQueryResponse<ResponsePayload>>> {
        let payload = RESTRequest(id: id, method: .abciQuery, params: parameters)
        return self.sendRequest(payload: payload)
    }
    
    public func block(id: Int, params: BlockParameters) -> EventLoopFuture<RESTResponse<BlockResponse>> {
        let payload = RESTRequest(id: id, method: .block, params: params)
        return self.sendRequest(payload: payload)
    }

    public func blockByHash(id: Int, params: BlockByHashParameters) -> EventLoopFuture<RESTResponse<BlockByHashResponse>> {
        let payload = RESTRequest(id: id, method: .blockByHash, params: params)
        return self.sendRequest(payload: payload)
    }

    public func blockchain(id: Int, params: BlockchainParameters) -> EventLoopFuture<RESTResponse<BlockchainResponse>> {
        let payload = RESTRequest(id: id, method: .blockchain, params: params)
        return self.sendRequest(payload: payload)
    }

    public func blockResults(id: Int, params: BlockResultsParameters) -> EventLoopFuture<RESTResponse<BlockResultsResponse>> {
        let payload = RESTRequest(id: id, method: .blockResults, params: params)
        return self.sendRequest(payload: payload)
    }

    public func broadcastEvidence(id: Int, params: BroadcastEvidenceParameters) -> EventLoopFuture<RESTResponse<BroadcastEvidenceResponse>> {
        let payload = RESTRequest(id: id, method: .broadcastEvidence, params: params)
        return self.sendRequest(payload: payload)
    }

    public func broadcastTransactionAsync(id: Int, params: BroadcastTransactionAsyncParameters) -> EventLoopFuture<RESTResponse<BroadcastTransactionAsyncResponse>> {
        let payload = RESTRequest(id: id, method: .broadcastTransactionAsync, params: params)
        return self.sendRequest(payload: payload)
    }

    public func broadcastTransactionCommit(id: Int, params: BroadcastTransactionCommitParameters) -> EventLoopFuture<RESTResponse<BroadcastTransactionCommitResponse>> {
        let payload = RESTRequest(id: id, method: .broadcastTransactionCommit, params: params)
        return self.sendRequest(payload: payload)
    }

    public func broadcastTransactionSync(id: Int, params: BroadcastTransactionSyncParameters) -> EventLoopFuture<RESTResponse<BroadcastTransactionSyncResponse>> {
        let payload = RESTRequest(id: id, method: .broadcastTransactionSync, params: params)
        return self.sendRequest(payload: payload)
    }

    public func checkTransaction(id: Int, params: CheckTransactionParameters) -> EventLoopFuture<RESTResponse<CheckTransactionResponse>> {
        let payload = RESTRequest(id: id, method: .checkTransaction, params: params)
        return self.sendRequest(payload: payload)
    }

    public func commit(id: Int, params: CommitParameters) -> EventLoopFuture<RESTResponse<CommitResponse>> {
        let payload = RESTRequest(id: id, method: .commit, params: params)
        return self.sendRequest(payload: payload)
    }

    public func consensusParameters(id: Int, params: ConsensusParametersParameters) -> EventLoopFuture<RESTResponse<ConsensusParametersResponse>> {
        let payload = RESTRequest(id: id, method: .consensusParameters, params: params)
        return self.sendRequest(payload: payload)
    }

    public func consensusState(id: Int) -> EventLoopFuture<RESTResponse<ConsensusStateResponse>> {
        struct ConsensusStateParameters: Codable { }
        let payload = RESTRequest(id: id, method: .consensusState, params: ConsensusStateParameters())
        return self.sendRequest(payload: payload)
    }

    public func dumpConsensusState(id: Int) -> EventLoopFuture<RESTResponse<DumpConsensusStateResponse>> {
        struct DumpConsensusStateParameters: Codable { }
        let payload = RESTRequest(id: id, method: .dumpConsensusState, params: DumpConsensusStateParameters())
        return self.sendRequest(payload: payload)
    }

    public func genesis(id: Int) -> EventLoopFuture<RESTResponse<GenesisResponse>> {
        struct GenesisParameters: Codable { }
        let payload = RESTRequest(id: id, method: .genesis, params: GenesisParameters())
        return self.sendRequest(payload: payload)
    }

    public func health(id: Int) -> EventLoopFuture<RESTResponse<HealthResponse>> {
        struct HealthParameters: Codable { }
        let payload = RESTRequest(id: id, method: .health, params: HealthParameters())
        return self.sendRequest(payload: payload)
    }

    public func netInfo(id: Int) -> EventLoopFuture<RESTResponse<NetInfoResponse>> {
        struct NetInfoParameters: Codable { }
        let payload = RESTRequest(id: id, method: .netInfo, params: NetInfoParameters())
        return self.sendRequest(payload: payload)
    }

    public func numUnconfirmedTransactions(id: Int) -> EventLoopFuture<RESTResponse<NumUnconfirmedTransactionsResponse>> {
        struct NumUnconfirmedTransactionsParameters: Codable { }
        let payload = RESTRequest(id: id, method: .numUnconfirmedTransactions, params: NumUnconfirmedTransactionsParameters())
        return self.sendRequest(payload: payload)
    }

    public func status(id: Int) -> EventLoopFuture<RESTResponse<StatusResponse>> {
        struct StatusParameters: Codable { }
        let payload = RESTRequest(id: id, method: .status, params: StatusParameters())
        return self.sendRequest(payload: payload)
    }

    public func subscribe(id: Int, params: SubscribeParameters) -> EventLoopFuture<RESTResponse<SubscribeResponse>> {
        let payload = RESTRequest(id: id, method: .subscribe, params: params)
        return self.sendRequest(payload: payload)
    }

    public func transaction(id: Int, params: TransactionParameters) -> EventLoopFuture<RESTResponse<TransactionResponse>> {
        let payload = RESTRequest(id: id, method: .transaction, params: params)
        return self.sendRequest(payload: payload)
    }

    public func transactionSearch(id: Int, params: TransactionSearchParameters) -> EventLoopFuture<RESTResponse<TransactionSearchResponse>> {
        let payload = RESTRequest(id: id, method: .transactionSearch, params: params)
        return self.sendRequest(payload: payload)
    }

    public func unconfirmedTransactions(id: Int, params: UnconfirmedTransactionsParameters) -> EventLoopFuture<RESTResponse<UnconfirmedTransactionsResponse>> {
        let payload = RESTRequest(id: id, method: .unconfirmedTransactions, params: params)
        return self.sendRequest(payload: payload)
    }
    
    public func unsubscribe(id: Int, params: UnsubscribeParameters) -> EventLoopFuture<RESTResponse<UnsubscribeResponse>> {
        let payload = RESTRequest(id: id, method: .unsubscribe, params: params)
        return self.sendRequest(payload: payload)
    }

    public func unsubscribeAll(id: Int) -> EventLoopFuture<RESTResponse<UnsubscribeAllResponse>> {
        struct UnsubscribeAllParameters: Codable { }
        let payload = RESTRequest(id: id, method: .unsubscribeAll, params: UnsubscribeAllParameters())
        return self.sendRequest(payload: payload)
    }

    public func validators(id: Int, params: ValidatorsParameters) -> EventLoopFuture<RESTResponse<ValidatorsResponse>> {
        let payload = RESTRequest(id: id, method: .validators, params: params)
        return self.sendRequest(payload: payload)
    }
}

extension RESTClient {
    func sendRequest<RequestPayload: Codable, ResponsePayload: Codable>(payload: RESTRequest<RequestPayload>) -> EventLoopFuture<RESTResponse<ResponsePayload>> {
        
        var headers: HTTPHeaders = [
            "User-Agent": ABCI_REST.httpClientType,
            "Content-Type": "text/json"
        ]
        headers.forEach { headers.replaceOrAdd(name: $0.name, value: $0.value) }
        
        do {
            guard let data = try? jsonEncoder.encode(payload) else {
                throw RESTRequestError.badRequest
            }
            
            let bodyString = String(data: data, encoding: .utf8) ?? ""
            
            let request = try HTTPClient.Request(url: url, method: .POST, headers: headers, body: .string(bodyString))
            
            return client.execute(request: request).flatMap { response in
                do {
                    guard let byteBuffer = response.body else {
                        throw RESTRequestError.badResponse
                    }
                    let responseData = Data(byteBuffer.readableBytesView)
                    
                    guard response.status == .ok else {
                        // decode some error for now throw error
                        //return self.client.eventLoopGroup.next().makeFailedFuture(jsonDecoder.decode(errorType, from: responseData))
                        throw RESTRequestError.badRequest
                    }
                    return client.eventLoopGroup.next().makeSucceededFuture(try jsonDecoder.decode(RESTResponse<ResponsePayload>.self, from: responseData))
                } catch {
                    return client.eventLoopGroup.next().makeFailedFuture(error)
                }
            }
        } catch {
            return client.eventLoopGroup.next().makeFailedFuture(error)
        }
    }
}
