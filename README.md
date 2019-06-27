# ABCISwift

Build blockchain applications in Swift on top of the Tendermint consensus.

It uses Zewo as its Server core. Zewo is a coroutine based Server framework written in Swift.

Swift version: 4.0.x
ABCI version: 0.10.x (tendermint 0.16.0)

Installation
------------
Requires Swift 4.0.x, on MacOS or a variant of Linux with the Swift 4.0.x toolchain installed.

`git clone https://github.com/ratranqu/swiftabci`
`cd swiftabci`
`swift build`
In your `Package.swift` file, add the repository as a dependency as such:
```
import PackageDescription

let package = Package(
    name: "ABCISwiftApp",
    products: [
        .executable(name: "ABCISwiftApp", targets: ["ABCISwiftApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ratranqu/swiftabci.git", from: "0.1.0"),
        .package(url: "https://gitlab.com/katalysis/dataconvertible.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "ABCISwiftApp", dependencies: ["ABCISwift", "DataConvertible"]),
    ]
)
```

Getting Started
---------------
0. `import ABCISwift`
1. Define a class complying to the following protocol:
```
public protocol ABCIApplication {

    func initChain(_ validators: [Validator])
    func info(_ version: String) -> ResponseInfo
    func echo(_ message: String) -> ResponseEcho
    func flush()
    func setOption(_ key: String, _ value: String) -> ResponseSetOption
    func deliverTx(_ tx: Data) -> Result
    func checkTx(_ tx: Data) -> Result
    func query(_ q: Query) -> ResponseQuery
    func beginBlock(_ hash: Data, _ header: Header, _ absentValidators: Int32, _ byzantineValidators: Evidence)
    func endBlock(_ height: UInt64) -> ResponseEndBlock
    func commit() -> Result
}
```
2. Implement the relevant Tendermint ABCI callbacks - see https://github.com/tendermint/abci
3. Inititialize an ABCIServer with it:
`let server = ABCIServer(application: CounterApp())`
4. Run it
`try server.start()`


See the example app `ABCICounter` application under the directory of the same name in `./Sources`.
here: `https://github.com/ratranqu/swiftabci/blob/master/Sources/ABCICounter/main.swift`


Development
---------------

Update the `types.pb.swift` file:
1. get the proto file from  https://github.com/tendermint/abci and put it in `./Sources/ABCISwift/`
2. `cd ./Sources/ABCISwift/`
3.A  (Recommended) Generate the swift code from the proto file using: `docker run --rm -v $(pwd):$(pwd) -w $(pwd) znly/protoc --swift_out=. -I. types.proto`.  (https://github.com/znly/docker-protobuf)
    0. this step requires a working `docker` install (see https://docker.com)
3.B Manually generate the proto file:
    0. there are import in the proto file, so you need to compile them separately before hand (possibly download them locally), see https://github.com/alexeyxo/protobuf-swift/issues/9
    1. get the swift proto generator from https://github.com/apple/swift-protobuf and compile `protoc-gen-swift`
    2. generate the swift protobuf file: `protoc --plugin=$PATH_TO_protoc-gen-swift --swift_out=. types.proto`


Compile:
1. run `swift build`

Donations
------------

If you find this useful and have some cryto currencies to spend, or if you are wondering which is the next ICO you are going to fund, you can always show your appreciation by sending some to:
bitcoin address:
ethereum address:

It will help fund further development of the project.
Thanks!

