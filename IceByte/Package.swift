// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IceByte",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(name: "IceByte", targets: ["IceByte"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "IceByte", dependencies: []),
        .testTarget(name: "IceByteTests", dependencies: ["IceByte"]),
    ]
)
