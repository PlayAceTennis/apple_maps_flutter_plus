// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "apple_maps_flutter_plus",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "apple-maps-flutter-plus", targets: ["apple_maps_flutter_plus"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "apple_maps_flutter_plus",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
