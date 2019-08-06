#!/bin/sh

if ! which carthage > /dev/null; then
    echo 'Error: Carthage is not installed' >&2
    exit 1
fi

if [ ! -f Package.swift ]; then
    echo "Package.swift can't be found, please make sure you run scripts/carthage-archive.sh from the root folder" >&2
    exit 1
fi

if ! which swift > /dev/null; then
    echo 'Swift is not installed' >&2
    exit 1
fi

REQUIRED_SWIFT_TOOLING="5.1.0"
TOOLS_VERSION=`swift package tools-version`

if [ ! "$(printf '%s\n' "$REQUIRED_SWIFT_TOOLING" "$TOOLS_VERSION" | sort -V | head -n1)" = "$REQUIRED_SWIFT_TOOLING" ]; then
    echo 'You must have Swift Package Manager 5.1.0 or later.'
    exit 1
fi

swift package generate-xcodeproj
carthage build --no-skip-current --platform iOS
carthage archive

echo "Upload CombineCocoa.framework.zip to the latest release"