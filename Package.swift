// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ABCISwift",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "Counter", targets: ["ABCICounter"]),
        .library(name: "ABCISwift", targets: ["ABCISwift"]),
        .library(name: "ABCINIOSwift", targets: ["ABCINIOSwift"]),
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
        .target(name: "ABCICounter", dependencies: ["ABCISwift", "ABCINIOSwift", "DataConvertible"]),
        .target(name: "ABCISwift", dependencies: ["SwiftProtobuf", "Logging"]),
        .target(name: "ABCINIOSwift", dependencies: ["NIO", "Logging", "ABCISwift"]),
        .testTarget(name: "ABCISwiftTests", dependencies: ["ABCISwift"]),
    ]
)
