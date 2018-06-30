// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Refined",
    products: [
        .library(
            name: "Refined",
            targets: ["Refined"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Refined",
            dependencies: []),
        .testTarget(
            name: "RefinedTests",
            dependencies: ["Refined"]),
    ]
)
