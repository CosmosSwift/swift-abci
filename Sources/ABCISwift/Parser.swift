//
//  Parser.swift
//  ABCISwift
//
import Core
import Venice

public enum ParseError: Error {
    case incorrectSizeLength
}

internal class Parser {
    
    private let stream: Readable
    private let bufferSize: Int
    private let buffer: UnsafeMutableRawBufferPointer
    
    private var unprocessed: [UInt8] = []
    private var sizeRemainingToProcess: Int?
    
    public init(stream: Readable, bufferSize: Int = 2048) {
        self.stream = stream
        self.bufferSize = bufferSize
        self.buffer = UnsafeMutableRawBufferPointer.allocate(count: bufferSize)
    }
    
    deinit {
        buffer.deallocate()
    }
    
    func read(deadline: Deadline) throws {
        let read = try stream.read(buffer, deadline: deadline)
        try parse(read)
    }
    
    private func parse(_ buffer: UnsafeRawBufferPointer) throws {
        var bytes: [UInt8] = []
        bytes.append(contentsOf: buffer)
        var pos = 0
        while (pos < bytes.count) {
            // iterate over full buffer
            var size = 0
            if let s = self.sizeRemainingToProcess {
                size = s
            } else {
                // varint size representation (https://developers.google.com/protocol-buffers/docs/encoding#varints)
                var mul = 1
                var zigzagSize = 0
                var current: UInt8
                repeat {
                    current = bytes[pos]
                    zigzagSize += Int(current) & 127 * mul
                    pos += 1
                    mul *= 64
                } while (current >> 7 != 0)

                size = zigzagSize >> 1 // sizes are always >0
                self.sizeRemainingToProcess = size
            }
            // if enough bytes remaining, process
            if (pos + size <= bytes.count) {
                processMessage([UInt8](bytes[pos..<pos+size]))
                self.sizeRemainingToProcess = nil
                pos += size
            } else {
                // put remaining bytes in unprocessed and wait for more data to come in
                self.unprocessed.append(contentsOf:[UInt8](bytes[pos...]))
                self.sizeRemainingToProcess = size - (bytes.count - pos) //
                pos = bytes.count
            }
        }
    }

    func processMessage(_ bytes: [UInt8]) {
        
    }
    
}
