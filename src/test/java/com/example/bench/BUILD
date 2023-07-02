java_binary(
    name = "ExampleBenchmark",
    srcs = ["ExampleBenchmark.java"],
    jvm_flags = [
        "-XX:+UseZGC",
        "-Xms256m",
        "-Xmx256m",
    ],
    main_class = "org.openjdk.jmh.Main",
    deps = [
        "//src/main/java/com/example/rest",
        "//third_party:jmh",
        "@maven//:com_google_guava_guava",
        "@maven//:org_apache_commons_commons_lang3",
    ],
)

java_binary(
    name = "SanitizeBenchmark",
    srcs = ["SanitizeBenchmark.java"],
    jvm_flags = [
        "-XX:+UseZGC",
        "-Xms64m",
        "-Xmx64m",
    ],
    main_class = "org.openjdk.jmh.Main",
    deps = [
        "//third_party:jmh",
        "@maven//:com_google_guava_guava",
        "@maven//:org_apache_commons_commons_lang3",
    ],
)
