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
        .library(name: "pdf_inspectorFFI", targets: ["pdf_inspector"]),
    ],
    targets: [
        // Common
        .target(
            name: "PDFInspector",
            dependencies: [
                "pdf_inspector"
            ],
            path: "swift/"
        ),

        // PDF Inspector Package
        .binaryTarget(
            name: "pdf_inspector",
            path: "swift/pdf_inspector.artifactbundle"
        ),
    ]
)
