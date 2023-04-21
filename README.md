# Simple java+bazel example project
This is a simple java example project that tries to follow [best practices](https://bazel.build/versions/master/docs/best-practices.html).

Features:
- Flat project layout, one BUILD file per directory.
- Works well with IntelliJ
- Uses [bazelisk](https://github.com/bazelbuild/bazelisk) to pin the version of bazel
  - See .bazelversion
- Uses `rules_jvm_external` for external maven dependencies (guava, junit, dagger)
  - This supports transitive deps
  - Downloads 3rd party source code (e.g. for IntelliJ)
- Run junit tests with a simple glob (technically not a best practice, but
  more ergonomic)
- BUILD/Java formatter
- log4j2
- REST

TODO (WIP):
- Java 20 / Loom preview
- Protobuf / gRPC examples
