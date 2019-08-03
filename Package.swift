// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CombineCocoa",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CombineCocoa",
            targets: ["CombineCocoa"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CombineCocoa",
            dependencies: [],
            path: "Sources"
        )
    ]
)
