// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "CombineCocoa",
  products: [
    .library(
      name: "CombineCocoa",
      type: .static,
      targets: ["CombineCocoa"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "CombineCocoa",
      dependencies: [
        .target(name: "CombineCocoaRuntime")
      ]
    ),
    .target(name: "CombineCocoaRuntime"),
  ]
)
