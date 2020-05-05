// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUI.WebView",
    platforms: [
      .iOS(.v13), .watchOS(.v6), .tvOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SwiftUI.WebView",
            targets: ["SwiftUI.WebView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUI.WebView",
            dependencies: []),
        .testTarget(
            name: "SwiftUI.WebViewTests",
            dependencies: ["SwiftUI.WebView"]),
    ]
)
