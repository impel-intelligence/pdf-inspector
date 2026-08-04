// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// The released Rust artifact bundle. Both values are updated by hand after each
// `pdf-inspector-rust-<version>` release — the publish workflow prints the
// checksum in its job summary. The release must exist BEFORE the semver tag
// that ships this manifest, so clients never resolve a tag whose checksum
// points at nothing.
let artifactBundleVersion = "0.1.7"
let artifactBundleURL =
    "https://github.com/impel-intelligence/pdf-inspector/releases/download/pdf-inspector-rust-\(artifactBundleVersion)/pdf_inspector.artifactbundle.zip"
let artifactBundleChecksum = "0000000000000000000000000000000000000000000000000000000000000000"

// Set PDF_INSPECTOR_LOCAL_ARTIFACTBUNDLE to a locally built
// swift/pdf_inspector.artifactbundle to test Rust changes before releasing.
let rustBinaryTarget: Target =
    if let localArtifactBundle = Context.environment["PDF_INSPECTOR_LOCAL_ARTIFACTBUNDLE"] {
        .binaryTarget(name: "pdf_inspector", path: localArtifactBundle)
    } else {
        .binaryTarget(
            name: "pdf_inspector",
            url: artifactBundleURL,
            checksum: artifactBundleChecksum
        )
    }

let package = Package(
    name: "pdf-inspector",
    // Must stay in sync with the *_DEPLOYMENT_TARGET env vars in
    // .github/workflows/publish-xcframework.yml, which set the deployment
    // target baked into each slice of the artifact bundle.
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .macCatalyst(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
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
        rustBinaryTarget,
    ]
)
