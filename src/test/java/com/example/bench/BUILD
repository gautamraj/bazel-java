java_binary(
    name = "ExampleBenchmark",
    srcs = ["ExampleBenchmark.java"],
    jvm_flags = [
        "-XX:+UseZGC",
    ],
    main_class = "org.openjdk.jmh.Main",
    deps = [
        "//src/main/java/com/example/rest",
        "//third_party:jmh",
        "@maven//:com_google_guava_guava",
    ],
)
