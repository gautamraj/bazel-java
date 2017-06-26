package(default_visibility = ["//visibility:public"])

java_library(
    name = "package2_test",
    srcs = glob(["*.java"]),
    deps = [
        "//module2/src/main/java/com/gautam/package2",
        "//third_party:guava",
        "//third_party:junit",
    ],
)

java_test(
    name = "FooTest",
    size = "small",
    runtime_deps = [
        ":package2_test",
    ],
)
