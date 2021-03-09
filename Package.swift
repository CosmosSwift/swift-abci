// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ABCI",
    products: [
        .executable(name: "key-value-store", targets: ["KeyValueStore"]),
        .library(name: "ABCIServer", targets: ["ABCIServer"]),
        .library(name: "ABCIMessages", targets: ["ABCIMessages"]),
        .library(name: "ABCINIO", targets: ["ABCINIO"]),
        .library(name: "DataConvertible", targets: ["DataConvertible"])
    ],
    dependencies: [
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.14.0"),
        .package(name: "swift-nio", url: "https://github.com/apple/swift-nio", .upToNextMajor(from: "2.26.0")),
        .package(name: "swift-log", url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(name: "KeyValueStore", dependencies: ["ABCIServer", "ABCINIO"]),
        .target(
            name: "ABCIServer",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "SwiftProtobuf"),
                .product(name: "Logging", package: "swift-log"),
                "DataConvertible", "ABCIMessages"
             ]
        ),
        .target(
            name: "ABCINIO",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "Logging", package: "swift-log"),
                "ABCIServer"
            ]
        ),
        .target(
            name: "DataConvertible",
            dependencies: []
        ),
        .target(
            name: "ABCIMessages",
            dependencies: ["DataConvertible"]
        ),
        //.testTarget(name: "ABCITests", dependencies: ["ABCIServer", "ABCIMessages"]),
    ]
)
