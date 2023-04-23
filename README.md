# Simple Java+bazel example project
This is a simple java example project that tries to follow [best practices](https://bazel.build/versions/master/docs/best-practices.html).

## Usage
1. Clone the repo
2. Install [bazelisk](https://github.com/bazelbuild/bazelisk)
3. Build the repo:
    ```
    ./bazel build //...
    ./bazel test //...
    ```
4. Add/remove dependencies in [MODULE.bazel](MODULE.bazel)
    - See instructions in this file for re-generating the pinned dependency file.

## Features
- Flat project layout, one BUILD file per directory.
- Works with IntelliJ plugin
- Uses [bazelisk](https://github.com/bazelbuild/bazelisk) to pin the version of bazel
  - See .bazelversion
- Uses `rules_jvm_external` for external maven dependencies (guava, junit, dagger)
  - This supports transitive deps
  - Downloads 3rd party source code (e.g. for IntelliJ)
- BUILD/Java formatter
- Logging via log4j2
- REST
- JUnit4 + AssertJ tests
    - Run junit tests with a simple glob (technically not a best practice, but more ergonomic)
- [JMH](https://github.com/openjdk/jmh) microbenchmarks

TODO (WIP):
- Protobuf / gRPC examples
- Metrics / Tracing
- Java 20 / Loom preview
