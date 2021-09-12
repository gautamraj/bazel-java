# This is a work in progress!

# Simple java+bazel example project
This is a simple java example project that tries to follow [best practices](https://bazel.build/versions/master/docs/best-practices.html).

Features
- Flat project layout, one BUILD file per directory
- Mostly works well with IntelliJ
- Uses bazelisk to pin the version of bazel (see .bazelversion)
- Uses rules_jvm_external for external maven dependencies (guava, junit, dagger)
  - This supports transitive deps
  - Downloads 3rd party source code (e.g. for IntelliJ)
- Run junit tests with a simple glob
  - (not actually a best practice)
- BUILD/Java formatter
- log4j2
- REST

TODO
- Protobuf
- gRPC
