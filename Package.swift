// swift-tools-version:5.3
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
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.5.0"),
        .package(name: "swift-nio", url: "https://github.com/apple/swift-nio", from: "2.3.0"),
        .package(name: "swift-log", url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "ABCICounter", dependencies: ["ABCI", "ABCINIO"]),
        .target(
            name: "ABCI",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "SwiftProtobuf"),
                .product(name: "Logging", package: "swift-log"),
             ]
        ),
        .target(
            name: "ABCINIO",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "Logging", package: "swift-log"),
                "ABCI"
            ]
        ),
        .testTarget(name: "ABCITests", dependencies: ["ABCI"]),
    ]
)
