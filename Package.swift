// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TextDiffing",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "TextDiffing", targets: [
            "TextDiffing"
        ])
    ],
    targets: [
        .target(name: "TextDiffing", resources: [
            .process("Assets.xcassets")
        ])
    ]
)
