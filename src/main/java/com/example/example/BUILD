load("@rules_java//java:defs.bzl", "java_binary", "java_library")

java_library(
    name = "example",
    srcs = glob(["*.java"]),
    visibility = ["//visibility:public"],
    exports = ["//src/main/java/com/example/package2"],
    deps = [
        "//src/main/java/com/example/package2",
        "//third_party:dagger",
        "@maven//:javax_inject_javax_inject",
    ],
)

java_binary(
    name = "ExampleMain",
    main_class = "com.example.example.ExampleMain",
    visibility = ["//visibility:public"],
    runtime_deps = [":example"],
)
