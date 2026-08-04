// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pdf-inspector",
    platforms: [
        .macOS(.v15),
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "PDFInspector", targets: ["PDFInspector"]),
    ],
    dependencies: [

    ],
    targets: [
        // Common
        .target(
            name: "PDFInspector",
            path: "swift/",
            dependencies: [
                "pdf_inspector"
            ]
        ),

        // PDF Inspector Package
        .binaryTarget(
            name: "pdf_inspector",
            path: "pdf_inspector.xcframework"
        ),
    ]
)
