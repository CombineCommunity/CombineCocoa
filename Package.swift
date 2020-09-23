// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CombineCocoa",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "CombineCocoa", targets: ["CombineCocoa"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "CombineCocoa", dependencies: ["Runtime"]),
        .target(name: "Runtime", dependencies: [])
    ]
)
