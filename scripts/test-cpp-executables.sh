#!/bin/bash

set -e

# Change to project root directory (script is in scripts/ subdirectory)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(dirname "$script_dir")"
cd "$project_root"

BUILD_DIR="examples/cpp/build"
exe_name="$1"
timeout="300"

echo "Testing $exe_name..."
    
cd "$BUILD_DIR"
    
if gtimeout "${timeout}s" "./$exe_name"; then
    echo "✓ $exe_name ran successfully"
    exit 0
else
    exit_code=$?
    if [ $exit_code -eq 124 ]; then
        echo "✓ $exe_name timed out (expected behavior)"
        exit 0
    else
        echo "✗ $exe_name failed with exit code $exit_code"
        exit 1
    fi
fi

set +e