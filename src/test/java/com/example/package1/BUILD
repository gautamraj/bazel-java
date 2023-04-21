load("//bzl:test.bzl", "junit4_test_suite")

java_library(
    name = "package1",
    srcs = glob(
        ["*.java"],
        exclude = [
            "*ITCase.java",
            "*Test.java",
        ],
    ),
    deps = [
        "//src/main/java/com/example/package1",
        "@maven//:com_google_guava_guava",
        "@maven//:junit_junit",
    ],
)

junit4_test_suite(
    name = "AllTests",
    size = "small",
    srcs = glob([
        "*Test.java",
        "*ITCase.java",
    ]),
    deps = [
        ":package1",
        "//src/main/java/com/example/package1",
        "@maven//:org_assertj_assertj_core",
    ],
)
