// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebView",
    platforms: [
      .iOS(.v13), .watchOS(.v6), .tvOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "WebView",
            targets: ["WebView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WebView",
            dependencies: []),
        .testTarget(
            name: "WebViewTests",
            dependencies: ["WebView"]),
    ]
)
