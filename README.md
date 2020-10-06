# CosmosSwift/swift-abci
![Swift5.3+](https://img.shields.io/badge/Swift-5.3+-blue.svg)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20linux-orange.svg)

Build blockchain applications in Swift on top of the Tendermint consensus. `swift-abci` uses [SwiftNIO](https://github.com/apple/swift-nio) as its server core.

- Swift version: 5.3.x
- SwiftNIO version: 2.0.x
- ABCI version: 0.33.8 (tendermint 0.33.8-1a8e42d)


## Installation

Requires macOS or a variant of Linux with the Swift 5.3.x toolchain installed.

In your `Package.swift` file, add the repository as a dependency as such:

``` swift
import PackageDescription

let package = Package(
    name: "swift-abci-app",
    products: [
        .executable(name: "swift-abci-app", targets: ["swift-abci-app"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cosmosswift/swift-abci.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
	    name: "swift-abci-app", 
	    dependencies: [
	        .product(name: "ABCI", package: "ABCI"), 
		.product(name: "ABCINIO", package: "ABCI"),
	    ]
	),
    ]
)
```

## Getting Started

1. Import ABCI and ABCINIO

```swift
import ABCI
import ABCINIO
```

2. Define a class complying to the [`ABCIApplication`](/Sources/ABCI/ABCIApplication.swift) protocol:

``` swift
final class Application : ABCIApplication {
    func initChain(_ time: Date, _ chainId: String, _ consensusParams: ConsensusParams, _ updates: [ValidatorUpdate], _ appStateBytes: Data) -> ResponseInitChain {
        ... 
    }
    
    func info(_ version: String, _ blockVersion: UInt64, _ p2pVersion: UInt64) -> ResponseInfo {
        ... 
    }
    
    public func echo(_ message: String) -> ResponseEcho {
        ... 
    }
    
    func setOption(_ key: String, _ value: String) -> ResponseSetOption {
        ...
    }
    
    func deliverTx(_ tx: Data) -> ResponseDeliverTx {
        ...
    }
    
    func checkTx(_ tx: Data) -> ResponseCheckTx {
        ...
    }

    func query(_ q: Query) -> ResponseQuery {
        ...
    }
    
    func beginBlock(_: Data, _: Header, _: LastCommitInfo, _: [Evidence]) -> ResponseBeginBlock {
        ...
    }
    
    public func endBlock(_: Int64) -> ResponseEndBlock {
        ...
    }
    
    func commit() -> ResponseCommit {
        ...
    }
}
```

3. Implement the relevant Tendermint ABCI callbacks

See the example app [`ABCICounter`](/Sources/ABCICounter/main.swift). Check https://github.com/tendermint/abci for more details.

4. Inititialize `NIOABCIServer`, with the application:

```swift
let server = NIOABCIServer(Application())
```

5. Start the server

```swift
try server.start()
```

6. Compile and run

```bash
swift run swift-abci-app
```

7. Run Tendermint

Initialise and run Tendermint (for instance in Docker):

```bash
# initialise tendermint
docker run -it --rm -v "/tmp:/tendermint" tendermint/tendermint:v0.33.8 init

# update the default config to allow tendermint to listen on 26657 from the localhost
sed 's/127.0.0.1:26657/0.0.0.0:26657/' /tmp/config/config.toml > /tmp/delme
rm /tmp/config/config.toml
mv /tmp/delme /tmp/config/config.toml

# run a single tendermint node
docker run -it --rm -v "/tmp:/tendermint" -p "26656-26657:26656-26657"  tendermint/tendermint:v0.33.8 node --proxy_app="tcp://host.docker.internal:26658"
```

## Development

Pre requisites: `protoc` with the swift generation plugin is installed on your system (`https://github.com/apple/swift-protobuf`).

For protoc swift plugin information: `https://github.com/apple/swift-protobuf/blob/master/Documentation/PLUGIN.md`

Update the `types.pb.swift` file:

1. update the proto file (and possibly its import dependencies) from  `https://github.com/tendermint/tendermint/abci` and put it in `./protobuf/...`

2. From the project root: `protoc --swift_opt=FileNaming=PathToUnderscores --swift_out=./Sources/ABCI/ -I=./protobuf/ $(find protobuf/tendermint/ -iname "*.proto")`

Compile:

1. run `swift build`

## Documentation

The docs for the latest tagged release are always available at [https://github.com/cosmosswift/swift-abci/]https://github.com/cosmosswift/swift-abci/).

## Questions

For bugs or feature requests, file a new [issue](https://github.com/cosmosswift/swift-abci/issues).

For all other support requests, please email [opensource@katalysis.io](mailto:opensource@katalysis.io).

## Changelog

[SemVer](https://semver.org/) changes are documented for each release on the [releases page](https://github.com/cosmosswift/swift-abci/-/releases).

## Contributing

Check out [CONTRIBUTING.md](https://github.com/cosmosswift/swift-abci/blob/master/CONTRIBUTING.md) for more information on how to help with **swift-abci**.

## Contributors

Check out [CONTRIBUTORS.txt](https://github.com/cosmosswift/swift-abci/blob/master/CONTRIBUTORS.txt) to see the full list. This list is updated for each release.
