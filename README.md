<table><thead><tr align="center"><th width="9999">
The <a href="https://github.com/katalysis.io/cosmoswift/abci" rel="nofollow noreferrer noopener" target="_blank">GitHub repository</a> is a <b>read-only</b> mirror of the GitLab repository. For issues and merge requests, <a href="https://gitlab.com/katalysis/open-source/cosmosswift/abci" rel="nofollow noreferrer noopener" target="_blank">please visit GitLab</a>.
</th></tr></thead></table>

# CosmsosSwift/ABCI
![Swift5.0+](https://img.shields.io/badge/Swift-5.0+-blue.svg)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20linux-orange.svg)

Build blockchain applications in Swift on top of the Tendermint consensus.

It uses [SwiftNIO](https://github.com/apple/swift-nio) as its server core.

Swift version: 5.0.x
SwiftNIO version: 2.0.x
ABCI version: 0.32.0 (tendermint 0.32.0-747f99fd)


## Installation

Requires Swift 5.0.x, on MacOS or a variant of Linux with the Swift 5.0.x toolchain installed.

``` bash 
git clone https://gitlab.com/katalysis/open-source/cosmosswift/abci.git
cd swift-abci
swift build
```

In your `Package.swift` file, add the repository as a dependency as such:
``` swift
import PackageDescription

let package = Package(
    name: "ABCISwiftApp",
    products: [
        .executable(name: "ABCISwiftApp", targets: ["ABCISwiftApp"]),
    ],
    dependencies: [
        .package(url: "https://gitlab.com/katalysis/open-source/cosmosswift/abci.git", from: "1.0.0"),
        .package(url: "https://gitlab.com/katalysis/dataconvertible.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "ABCISwiftApp", dependencies: ["ABCI", "ABCINIO", "DataConvertible"]),
    ]
)
```

## Prerequisites

Initialise and run Tendermint (for instance in Docker): 
```bash
# initialise tendermint
docker run -it --rm -v "/tmp:/tendermint" tendermint/tendermint init

# run a single tendermint node
docker run -it --rm -v "/tmp:/tendermint" -p "26656-26657:26656-26657"  tendermint/tendermint node --proxy_app="tcp://host.docker.internal:26658"
```

## Getting Started

0. `import ABCI`
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
here: `https://gitlab.com/katalysis/open-source/cosmosswift/abci/blob/master/Sources/ABCICounter/main.swift`

6. Compile and run

## Development

Pre requisites: `protoc` with the swift generation plugin is installed on your system (`https://github.com/apple/swift-protobuf`).

For protoc swift plugin information: `https://github.com/apple/swift-protobuf/blob/master/Documentation/PLUGIN.md`

Update the `types.pb.swift` file:
1. update the proto file (and possibly its import dependencies) from  `https://github.com/tendermint/tendermint/abci` and put it in `./protobuf/...`
2. From the project root: `protoc --swift_opt=FileNaming=PathToUnderscores --swift_out=./Sources/ABCI/ -I=./protobuf/ $(find protobuf/github.com/tendermint -iname "*.proto")`
3. [Optional]: `swift package generate-xcodeproj`

Compile:
1. run `swift build`

## Documentation

The docs for the latest tagged release are always available at [https://gitlab.com/katalysis/open-source/cosmosswift/abci/](https://gitlab.com/katalysis/open-source/cosmosswift/abci/).

## Questions

For bugs or feature requests, file a new [issue](https://gitlab.com/katalysis/open-source/cosmosswift/abci/issues).

For all other support requests, please email [opensource@katalysis.io](mailto:opensource@katalysis.io).

## Changelog

[SemVer](https://semver.org/) changes are documented for each release on the [releases page](https://gitlab.com/katalysis/open-source/cosmosswift/abci/-/releases).

## Contributing

Check out [CONTRIBUTING.md](https://gitlab.com/katalysis/open-source/cosmosswift/abci/blob/master/CONTRIBUTING.md) for more information on how to help with **ABCISwift**.

## Contributors

Check out [CONTRIBUTORS.txt](https://gitlab.com/katalysis/open-source/cosmosswift/abci/blob/master/CONTRIBUTORS.txt) to see the full list. This list is updated for each release.


## Notice

The structure for this repository has been greatly inspired by [RediStack](https://gitlab.com/Mordil/swift-redi-stack).
