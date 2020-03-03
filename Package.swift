// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ABCI",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "Counter", targets: ["ABCICounter"]),
        .library(name: "ABCI", targets: ["ABCI"]),
        .library(name: "ABCINIO", targets: ["ABCINIO"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://gitlab.com/katalysis/DataConvertible.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-nio", from: "2.3.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "ABCICounter", dependencies: ["ABCI", "ABCINIO", "DataConvertible"]),
        .target(name: "ABCI", dependencies: ["SwiftProtobuf", "Logging"]),
        .target(name: "ABCINIO", dependencies: ["NIO", "Logging", "ABCI"]),
        .testTarget(name: "ABCITests", dependencies: ["ABCI"]),
    ]
)
