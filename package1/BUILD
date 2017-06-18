java_library(
    name = "package1",
    srcs = glob(["src/main/java/**/*.java"]),
    deps = [
        "//package2:package2",
        "//third_party:com_google_guava_guava",
    ],
    visibility = [ "//visibility:public" ],
)


java_binary(
    name = "package1_Main",
    runtime_deps = [
        ":package1",
    ],
    main_class = "com.gautam.package1.Main",
    visibility = [ "//visibility:public" ],
)
