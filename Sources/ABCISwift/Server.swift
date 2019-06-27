//
//  Server.swift
//  ABCISwift
//

//import Foundation
import Core
import IO
import Venice
import SwiftProtobuf

public final class ABCIServer {
    /// Parser buffer size
    public let parserBufferSize: Int
    
    /// Parse timeout
    public let parseTimeout: Duration
    
    /// Serialization timeout
    public let serializeTimeout: Duration
    
    /// Close connection timeout
    public let closeConnectionTimeout: Duration
    
    private let header: String
    private let group = Coroutine.Group()
    private let application: ABCIApplication
    
    private var connectionId: Int = 0
    
    /// Creates a new ABCI server
    public init(
        header: String = defaultHeader,
        parserBufferSize: Int = 4096,
        parseTimeout: Duration = 1000.seconds,
        serializeTimeout: Duration = 5.minutes,
        closeConnectionTimeout: Duration = 1.minute,
        application: ABCIApplication
        ) {
        self.header = header
        self.parserBufferSize = parserBufferSize
        self.parseTimeout = parseTimeout
        self.serializeTimeout = serializeTimeout
        self.closeConnectionTimeout = closeConnectionTimeout
        self.application = application
    }
    
    deinit {
        group.cancel()
    }
    
    /// Start server
    public func start(
        host: String = "0.0.0.0",
        port: Int = 46658,
        backlog: Int = 2048,
        reusePort: Bool = false,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        column: Int = #column
        ) throws {
        let tcp = try TCPHost(
            host: host,
            port: port,
            backlog: backlog,
            reusePort: reusePort
        )
        
        log(
            host: host,
            port: port,
            locationInfo: Logger.LocationInfo(
                file: file,
                line: line,
                column: column,
                function: function
            )
        )
        
        try start(host: tcp)
    }
    
    /// Start server
    public func start(host: Host) throws {
        while true {
            do {
                try accept(host)
            } catch SystemError.tooManyOpenFiles {
                Logger.info("Too many open files while accepting connections. Retrying in 10 seconds.")
                try Coroutine.wakeUp(10.seconds.fromNow())
                continue
            } catch VeniceError.canceledCoroutine {
                break
            } catch {
                Logger.error("Error while accepting connections.", error: error)
                throw error
            }
        }
    }
    
    /// Stop server
    public func stop() throws {
        Logger.info("Stopping ABCI server.")
        group.cancel()
    }
    
    public static var defaultHeader: String {
        
        let header = """
        \n
          _____         _  __ _   __  __ _       _
         / ____|       (_)/ _| | |  \\/  (_)     | |
        | (_____      ___| |_| |_| \\  / |_ _ __ | |_
         \\___ \\ \\ /\\ / / |  _| __| |\\/| | | '_ \\| __|
         ____) \\ V  V /| | | | |_| |  | | | | | | |_
        |_____/ \\_/\\_/ |_|_|  \\__|_|  |_|_|_| |_|\\__|
        --------------------------------------------------\n
        """
        
        return header
    }
    
    @inline(__always)
    private func log(host: String, port: Int, locationInfo: Logger.LocationInfo) {
        var header = self.header
        header += "Started ABCI server at \(host), listening on port \(port)."
        Logger.info(header, locationInfo: locationInfo)
    }
    
    @inline(__always)
    private func accept(_ host: Host) throws {
        let stream = try host.accept(deadline: .never)
        Logger.debug("ACCEPT: \(self.connectionId)")
        try group.addCoroutine { [unowned self] in
            do {
                let ci = self.connectionId
                self.connectionId += 1
                try self.process(stream, ci)
            } catch SystemError.brokenPipe {
                Logger.error("Broken pipe while processing connection.")
                return
            } catch SystemError.connectionResetByPeer {
                Logger.error("Connection reset by peer while processing connection.")
                return
            } catch VeniceError.canceledCoroutine {
                Logger.error("Cancelled coroutine while processing connection.")
                return
            } catch {
                Logger.error("Error while processing connection.", error: error)
            }
            
            try stream.close(deadline: self.closeConnectionTimeout.fromNow())
        }
    }
    
    @inline(__always)
    private func process(_ stream: DuplexStream, _ connectionId: Int) throws {
        let parser = RequestParser(stream: stream, bufferSize: parserBufferSize)
        let serializer = ResponseSerializer(stream: stream)
        
        var continueLoop = true
        while continueLoop {
            let request = try parser.parse(deadline: parseTimeout.fromNow())
            var response: Types_Response! = Types_Response()
            Logger.debug("[\(connectionId)]:\(request)")
            switch request.value {
            case let .some(v):
                switch v {
                case let .echo(r):
                    response.echo = Types_ResponseEcho(application.echo(r.message))
                 case .flush:
                    application.flush()
                    response.flush = Types_ResponseFlush()
                case let .info(r):
                    response.info = Types_ResponseInfo(application.info(r.version))
                case let .beginBlock(r):
                    let bV = r.byzantineValidators.map({ (evidence) -> Evidence in
                        return Evidence(protobuf: evidence)
                    })
                    application.beginBlock(r.hash,  Header(protobuf: r.header), r.absentValidators, bV)
                    response.beginBlock = Types_ResponseBeginBlock()
                case let .endBlock(r):
                    response.endBlock = Types_ResponseEndBlock(application.endBlock(r.height))
                case let .deliverTx(r):
                    response.deliverTx = Types_ResponseDeliverTx(application.deliverTx(r.tx))
                case let .checkTx(r):
                    response.checkTx = Types_ResponseCheckTx(application.checkTx(r.tx))
                case .commit:
                    response.commit = Types_ResponseCommit(application.commit())
                case let .setOption(r):
                    response.setOption = Types_ResponseSetOption(application.setOption(r.key, r.value))
                case let .query(r):
                    response.query = Types_ResponseQuery(application.query(Query(data: r.data, path: r.path, height: r.height, prove: r.prove)))
                case let .initChain(r):
                    application.initChain(r.validators.map({ (v) -> Validator in
                        return Validator(protobuf: v)
                    }))
                    response.initChain = Types_ResponseInitChain()
                }
            case .none:
                response.exception = Types_ResponseException()
                break
            }
            Logger.debug("[\(connectionId)]:\(response)")
            try serializer.serialize(response, deadline: serializeTimeout.fromNow())
            
            // TODO: trap SIGQUIT, SIGTERM, SIGINT and adjust continueLoop?
            continueLoop = true
        }
    }
}
