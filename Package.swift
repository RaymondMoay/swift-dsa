// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDSA",
    products: [
        .library(
            name: "SwiftDSA",
            targets: ["SwiftDSA"])
    ],
    targets: [
        .target(name: "SwiftDSA"),
        .testTarget(name: "SwiftDSATests",
                    dependencies: ["SwiftDSA"])
    ]
)
