// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "DataStructures",
    products: [
        .library(
            name: "DataStructures",
            targets: ["DataStructures"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DataStructures",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "DataStructuresTests",
            dependencies: ["DataStructures"]
        ),
    ]
)
