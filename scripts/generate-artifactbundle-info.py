#!/usr/bin/env python3
"""Generates info.json for the PdfInspectorFFI SE-0482 static-library artifact bundle.

Usage: generate-artifactbundle-info.py <artifact-name> <version> <manifest.tsv> <out/info.json>

manifest.tsv is tab-separated: <bundle-subdir> <lib-filename> <comma-separated-triples>
"""

import json
import sys


def main() -> None:
    artifact_name, version, manifest_path, out_path = sys.argv[1:5]

    variants = []
    with open(manifest_path) as f:
        for line in f:
            subdir, lib_name, triples = line.rstrip("\n").split("\t")
            variants.append(
                {
                    "path": f"{subdir}/{lib_name}",
                    "supportedTriples": triples.split(","),
                    "staticLibraryMetadata": {
                        "headerPaths": ["include"],
                        "moduleMapPath": "include/module.modulemap",
                    },
                }
            )

    manifest = {
        "schemaVersion": "1.0",
        "artifacts": {
            artifact_name: {
                "type": "staticLibrary",
                "version": version,
                "variants": variants,
            }
        },
    }

    with open(out_path, "w") as f:
        json.dump(manifest, f, indent=2)
        f.write("\n")


if __name__ == "__main__":
    main()
