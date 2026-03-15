// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "projectx",
  platforms: [.macOS(.v10_15)],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
    .package(url: "https://github.com/nerdishbynature/octokit.swift", from: "0.11.0"),
    .package(url: "https://github.com/JohnSundell/CollectionConcurrencyKit.git", from: "0.1.0"),
    .package(url: "https://github.com/apple/swift-system", from: "1.6.1"),
    .package(url: "https://github.com/tsolomko/SWCompression.git", from: "4.8.0"),
    .package(url: "https://github.com/apple/swift-log", from: "1.6.0"),
    // cant really use swiftlint on linux atm because of these issues:
    // https://github.com/realm/SwiftLint/issues/6541
    // https://github.com/realm/SwiftLint/issues/6080#issuecomment-4062328742
    // .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.63.2"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .executableTarget(
      name: "projectx",
      dependencies: [
        .product(name: "SystemPackage", package: "swift-system"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "OctoKit", package: "octokit.swift"),
        "CollectionConcurrencyKit",
        "SWCompression",
        .product(name: "Logging", package: "swift-log"),
      ],
      swiftSettings: [.treatAllWarnings(as: .error)],
      // https://github.com/realm/SwiftLint/issues/6080#issuecomment-4062328742
      // plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
    )
  ],
)
