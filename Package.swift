// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ABCI",
    products: [
        .executable(name: "Counter", targets: ["ABCICounter"]),
        .library(name: "ABCI", targets: ["ABCI"]),
        .library(name: "ABCINIO", targets: ["ABCINIO"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-nio", from: "2.3.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "ABCICounter", dependencies: ["ABCI", "ABCINIO"]),
        .target(name: "ABCI", dependencies: ["SwiftProtobuf", "Logging"]),
        .target(name: "ABCINIO", dependencies: ["NIO", "Logging", "ABCI"]),
        .testTarget(name: "ABCITests", dependencies: ["ABCI"]),
    ]
)
