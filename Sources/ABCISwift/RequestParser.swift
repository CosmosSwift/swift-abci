//
//  RequestParser.swift
//  ABCISwift
//

import Core
import Foundation
import Venice

internal final class RequestParser : Parser {
    private var requests: [Types_Request] = []
    
    public override init(stream: Readable, bufferSize: Int = 2048) {
        super.init(stream: stream, bufferSize: bufferSize)
    }
    
    public func parse(deadline: Deadline) throws -> Types_Request {
        while true {
            guard requests.isEmpty else {
                return requests.removeFirst()
            }
            try read(deadline: deadline)
        }
    }

    override func processMessage(_ bytes: [UInt8]) {
        // Add message to requests
        do {
            let request = try Types_Request(serializedData: Data(bytes: bytes))
            requests.append(request)
        } catch let error {
            Logger.error(error)
        }
    }
}

