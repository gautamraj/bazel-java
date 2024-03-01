load("@rules_java//java:defs.bzl", "java_binary", "java_library")

java_library(
    name = "rest",
    srcs = glob(["*.java"]),
    resources = [
        "//src/main/resources:log4j2_xml",
    ],
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@maven//:org_apache_logging_log4j_log4j_core",
        "@maven//:org_apache_logging_log4j_log4j_slf4j2_impl",
    ],
    deps = [
        "//src/main/java/com/example/rest/counter",
        "@maven//:com_fasterxml_jackson_core_jackson_core",
        "@maven//:com_fasterxml_jackson_core_jackson_databind",
        "@maven//:com_fasterxml_jackson_datatype_jackson_datatype_jdk8",
        "@maven//:com_fasterxml_jackson_datatype_jackson_datatype_jsr310",
        "@maven//:com_google_code_findbugs_jsr305",
        "@maven//:io_javalin_javalin",
        "@maven//:org_apache_logging_log4j_log4j_api",
    ],
)

java_binary(
    name = "RestServerMain",
    jvm_flags = [
        "-XX:+UseZGC",
    ],
    main_class = "com.example.rest.RestServerMain",
    visibility = ["//visibility:public"],
    runtime_deps = [
        ":rest",
    ],
)
