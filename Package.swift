// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NnFirestoreHelpers",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [
        .library(
            name: "NnFirestoreHelpers",
            targets: ["NnFirestoreHelpers"]),
    ],
    dependencies: [
        .package(
            name: "Firebase",
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            .upToNextMajor(from: "8.10.0")
          ),
    ],
    targets: [
        .target(
            name: "NnFirestoreHelpers",
            dependencies: [
                .product(name: "FirebaseAuth", package: "Firebase"),
                .product(name: "FirebaseFirestore", package: "Firebase"),
                .product(name: "FirebaseFirestoreSwift-Beta", package: "Firebase"),
                .product(name: "FirebaseAppCheck", package: "Firebase")
            ]),
        .testTarget(
            name: "NnFirestoreHelpersTests",
            dependencies: ["NnFirestoreHelpers"]),
    ]
)
