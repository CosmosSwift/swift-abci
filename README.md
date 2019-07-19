<table><thead><tr align="center"><th width="9999">
The <a href="https://github.com/ratranqu/swift-abci" rel="nofollow noreferrer noopener" target="_blank">GitHub repository</a> is a <b>read-only</b> mirror of the GitLab repository. For issues and merge requests, <a href="https://gitlab.com/ratranqu/swift-abci" rel="nofollow noreferrer noopener" target="_blank">please visit GitLab</a>.
</th></tr></thead></table>

# ABCISwift
![Swift5.0+](https://img.shields.io/badge/Swift-5.0+-blue.svg)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20linux-lightgrey.svg)

Build blockchain applications in Swift on top of the Tendermint consensus.

It uses [SwiftNIO](https://github.com/apple/swift-nio) as its server core.

Swift version: 5.0.x
SwiftNIO version: 2.0.x
ABCI version: 0.32.0 (tendermint 0.32.0-747f99fd)

Installation
------------
Requires Swift 5.0.x, on MacOS or a variant of Linux with the Swift 5.0.x toolchain installed.

`git clone https://gitlab.com/ratranqu/swift-abci.git`
`cd swift-abci`
`swift build`
In your `Package.swift` file, add the repository as a dependency as such:
``` swift
import PackageDescription

let package = Package(
    name: "ABCISwiftApp",
    products: [
        .executable(name: "ABCISwiftApp", targets: ["ABCISwiftApp"]),
    ],
    dependencies: [
        .package(url: "https://gitlab.com/ratranqu/swift-abci.git", from: "1.0.0"),
        .package(url: "https://gitlab.com/katalysis/dataconvertible.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "ABCISwiftApp", dependencies: ["ABCISwift", "ABCINIOSwift", "DataConvertible"]),
    ]
)
```

Getting Started
---------------
0. `import ABCISwift`
1. Define a class complying to the following protocol:
``` swift
public protocol ABCIApplication {

    func initChain(_ time: Date, _ chainId: String, _ consensusParams: ConsensusParams, _ updates: [ValidatorUpdate], _ appStateBytes: Data) -> ResponseInitChain
    func info(_ version: String, _ blockVersion: UInt64, _ p2pVersion: UInt64) -> ResponseInfo
    func echo(_ message: String) -> ResponseEcho
    func flush()
    func setOption(_ key: String, _ value: String) -> ResponseSetOption
    func deliverTx(_ tx: Data) -> ResponseDeliverTx
    func checkTx(_ tx: Data) -> ResponseCheckTx
    func query(_ q: Query) -> ResponseQuery
    func beginBlock(_ hash: Data, _ header: Header, _ lastCommitInfo: LastCommitInfo, _ byzantineValidators: [Evidence]) -> ResponseBeginBlock
    func endBlock(_ height: Int64) -> ResponseEndBlock
    func commit() -> ResponseCommit
}
```
2. Implement the relevant Tendermint ABCI callbacks - see https://github.com/tendermint/abci
3. Inititialize an ABCIServer with it:
`let server = NIOABCIServer(CounterApp())`
4. Run it
`try server.start()`


See the example app `ABCICounter` application under the directory of the same name in `./Sources`.
here: `https://github.com/ratranqu/swiftabci/blob/master/Sources/ABCICounter/main.swift`


Development
---------------
Pre requisites: `protoc` with the swift generation plugin is installed on your system (`https://github.com/apple/swift-protobuf`).

For protoc swift plugin information: `https://github.com/apple/swift-protobuf/blob/master/Documentation/PLUGIN.md`

Update the `types.pb.swift` file:
1. update the proto file (and possibly its import dependencies) from  `https://github.com/tendermint/tendermint/abci` and put it in `./protobuf/...`
2. From the project root: `protoc --swift_opt=FileNaming=PathToUnderscores --swift_out=./Sources/ABCISwift/ -I=./protobuf/ $(find protobuf/github.com/tendermint -iname "*.proto")`
3. [Optional]: `swift package generate-xcodeproj`

Compile:
1. run `swift build`

