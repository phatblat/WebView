// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "WebView",
    platforms: [
      .iOS(.v13), .macOS(.v10_15)
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
