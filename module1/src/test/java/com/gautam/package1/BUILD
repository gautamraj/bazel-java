package(default_visibility = ["//visibility:public"])

java_library(
    name = "package1_test",
    srcs = glob(["*.java"]),
    deps = [
        "//module1/src/main/java/com/gautam/package1:package1",
        "//third_party:guava",
        "//third_party:junit",
    ],
)

java_test(
    name = "MainTest",
    size = "small",
    runtime_deps = [
        ":package1_test",
    ],
)
