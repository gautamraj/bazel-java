#!/bin/bash

set -e

echo "Formatting..."
# TODO - hopefully remove these terrible jvmopts in a future version :/
find $PWD -type f -name '*.java' | xargs bazel run //scripts:java_formatter_bin \
  --jvmopt="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED" \
  -- \
  -i
bazel run //:buildifier
