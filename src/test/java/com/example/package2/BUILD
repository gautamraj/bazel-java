load("//bzl:test.bzl", "junit4_test_suite")

junit4_test_suite(
    name = "AllTests",
    size = "small",
    srcs = glob([
        "*Test.java",
        "*ITCase.java",
    ]),
    deps = [
        "//src/main/java/com/example/package2",
        "@maven//:com_google_guava_guava",
        "@maven//:org_assertj_assertj_core",
    ],
)
