load("@rules_java//java:defs.bzl", "java_library")

java_library(
    name = "counter",
    srcs = ["VisitorRecords.java"],
    visibility = ["//:__subpackages__"],
    deps = [
        "@maven//:com_google_code_findbugs_jsr305",
        "@maven//:com_google_guava_guava",
    ],
)
