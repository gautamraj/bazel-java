java_library(
    name = "example",
    srcs = glob(["*.java"]),
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/java/com/gautam/package2",
        "//third_party:dagger_with_compiler",
        "@third_party//3rdparty/jvm/com/google/guava",
        "@third_party//3rdparty/jvm/javax/inject:javax_inject",
    ],
)

java_binary(
    name = "ExampleMain",
    runtime_deps = [":example"],
)
