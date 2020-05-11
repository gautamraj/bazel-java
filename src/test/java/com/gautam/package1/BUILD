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
        "//src/main/java/com/gautam/package1",
        "@third_party//3rdparty/jvm/com/google/guava",
        "@third_party//3rdparty/jvm/junit",
    ],
)

junit4_test_suite(
    name = "AllTests",
    size = "small",
    #srcs = glob(["*Test.java", "*ITCase.java"]),
    srcs = glob(["*Test.java"]),
    deps = [
        ":package1",
        "//src/main/java/com/gautam/package1",
    ],
)
