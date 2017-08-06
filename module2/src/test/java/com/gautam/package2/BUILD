package(default_visibility = ["//visibility:public"])
load("//bazel:test.bzl", "java_test_package")

java_test_package(
    name = "package2",
    package = "com.gautam.package2",
    deps = [
        "//module2/src/main/java/com/gautam/package2",
        "//third_party:guava",
        "//third_party:junit",
    ])
