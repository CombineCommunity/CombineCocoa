// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "CombineCocoa",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "CombineCocoa", targets: ["CombineCocoa"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "CombineCocoa", dependencies: ["Runtime"]),
        .target(name: "Runtime", dependencies: [])
    ]
)
