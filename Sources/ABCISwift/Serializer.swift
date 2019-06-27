//
//  Serializer.swift
//  ABCISwift
//

import Core

internal class Serializer {
   
    internal let stream: Writable

    internal init(stream: Writable) {
        self.stream = stream
    }
}
