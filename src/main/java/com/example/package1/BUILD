load("@rules_java//java:defs.bzl", "java_binary", "java_library")

java_library(
    name = "package1",
    srcs = ["Main.java"],
    visibility = ["//:__subpackages__"],
    deps = [
        "//src/main/java/com/example/package2",
        "@maven//:com_google_guava_guava",
    ],
)

java_binary(
    name = "Main",
    main_class = "com.example.package1.Main",
    visibility = ["//visibility:public"],
    runtime_deps = [":package1"],
)
