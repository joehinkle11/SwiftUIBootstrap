// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

var deps: [Package.Dependency]?
var targetDeps: [Target.Dependency]?
if ProcessInfo.processInfo.environment["WEB"] == nil {
    // is from xcode
    deps = nil
    targetDeps = nil
} else {
    // is from command line
    // for web version
    deps = [.package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", from: "0.7.0")]
    targetDeps = [.product(name: "TokamakShim", package: "Tokamak", condition: .when(platforms: [.wasi]))]
}

let package = Package(
    name: "SwiftUIBootstrap",
    platforms: [.macOS(.v11),.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftUIBootstrap",
            targets: ["SwiftUIBootstrap"]),
    ],
    dependencies: deps ?? [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftUIBootstrap",
            dependencies: targetDeps ?? []),
    ]
)
