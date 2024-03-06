load("@rules_java//java:defs.bzl", "java_binary", "java_library")

java_library(
    name = "leak",
    srcs = glob(
        ["*.java"],
        exclude = [
            "*Benchmark.java",
        ],
    ),
    deps = [
        "@maven//:com_google_guava_guava",
        "@maven//:org_apache_commons_commons_lang3",
    ],
)

java_binary(
    name = "LeakyFunctionBenchmark",
    srcs = ["LeakyFunctionBenchmark.java"],
    jvm_flags = [
        "-XX:+UseZGC",
        "-Xms256m",
        "-Xmx256m",
    ],
    main_class = "org.openjdk.jmh.Main",
    deps = [
        ":leak",
        "//third_party:jmh",
        "@maven//:com_google_guava_guava",
        "@maven//:org_apache_commons_commons_lang3",
    ],
)
