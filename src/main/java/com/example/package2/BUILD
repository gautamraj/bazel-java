load("@rules_java//java:defs.bzl", "java_library")

java_library(
    name = "package2",
    srcs = ["Foo.java"],
    visibility = ["//:__subpackages__"],
    deps = ["@maven//:com_google_guava_guava"],
)
