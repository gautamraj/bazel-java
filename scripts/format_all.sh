#!/bin/bash

set -e

echo "Formatting..."
find $PWD -type f -name '*.java' | xargs bazel run //scripts:java_formatter_bin -- -i
