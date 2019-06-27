




import ABCISwift
import Foundation
import DataConvertible
import Logging

let logger = Logger(label: "ABCICounter")


class CounterApp: ABCIApplication {
    
/*
    Simple counter app.  It only excepts values sent to it in order.  The
    state maintains the current count. For example if starting at state 0, sending:
    -> 0x01 = ok
    -> 0x03 = fail (expects 2)
    To run it:
    - make a clean new directory for tendermint
    - start this server: .build/debug/ABCICounter
    - start tendermint: tendermint --home "YOUR DIR HERE" node
    - The send transactions to the app:
    curl http://localhost:46657/broadcast_tx_commit?tx=0x01
    curl http://localhost:46657/broadcast_tx_commit?tx=0x02
    ...
    to see the latest count:
    curl http://localhost:46657/abci_query
    The way the app state is structured, you can also see the current state value
    in the tendermint console output.
*/

    var txCount: UInt64 = 0
    var lastBlockheight: Int64 = 0
    var serial: Bool = false
    
    func validate(_ tx: Data) -> Bool {
        var  padded = Data(count: 8 - tx.count)
        padded.append(tx)
        let value = UInt64(data: padded)?.bigEndian ?? 0// the encoding is bigEndian, so have to reverse it
        return value == txCount + 1
    }
    
    func initChain(_ validators: [Validator]) {
        // Sets initial state on first run
        txCount = 0
    }
    
    func info(_ version: String) -> ResponseInfo {
        return ResponseInfo(data: "{\"hashes\":\(lastBlockheight),\"txs\":\(txCount)}", version: version, lastBlockHeight: lastBlockheight)
    }
    
    func deliverTx(_ tx: Data) -> Result {
        // Mutate state if valid Tx
        if serial && !validate(tx) { return ResponseCheckTx.error(3, log:"bad count") }

        self.txCount += 1
        return ResponseDeliverTx.ok()
    }
    
    func checkTx(_ tx: Data) -> Result {
        // Validate the Tx before entry into the mempool
        if serial && !validate(tx) { return ResponseCheckTx.error(3, log:"bad count") }
        
        return ResponseCheckTx.ok(log: "All good")
    }
    
    func query(_ q: Query) -> ResponseQuery {
        // Returns the last Tx count
        logger.debug("\(q)")
        let k = "count".data
        let v = txCount.bigEndian.data
        return ResponseQuery.ok(key: k, value: v)
    }
    
    func commit() -> Result {
        // Return the current encode state value to tendermint
        let h = txCount.bigEndian.data
        return ResponseCommit.ok(data:h)
    }
    
    func beginBlock(_ hash: Data, _ header: Header, _ absentValidators: Int32, _ byzantineValidators: Evidence) {
        lastBlockheight += 1
    }
    
    func setOption(_ key: String, _ value: String) -> ResponseSetOption {
        if key == "serial" {
            serial = value == "on"
        }
        return ResponseSetOption()
    }
}



let server = ABCIServer(CounterApp())

try server.start()
