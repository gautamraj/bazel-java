package(default_visibility = ["//visibility:public"])

java_library(
    name = "package1",
    srcs = glob(["*.java"]),
    deps = [
        "//module2/src/main/java/com/gautam/package2:package2",
        "//third_party:guava",
    ],
)

java_binary(
    name = "package1_Main",
    runtime_deps = [
        ":package1",
    ],
    main_class = "com.gautam.package1.Main",
)
