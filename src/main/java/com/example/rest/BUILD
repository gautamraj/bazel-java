java_library(
    name = "rest",
    srcs = glob(["*.java"]),
    resources = [
        "//src/main/resources:log4j2_xml",
    ],
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@maven//:org_apache_logging_log4j_log4j_core",
        "@maven//:org_apache_logging_log4j_log4j_slf4j_impl",
    ],
    deps = [
        "//src/main/java/com/example/rest/counter",
        "//third_party:dagger",
        "@maven//:com_fasterxml_jackson_core_jackson_annotations",
        "@maven//:com_fasterxml_jackson_core_jackson_core",
        "@maven//:com_fasterxml_jackson_core_jackson_databind",
        "@maven//:com_fasterxml_jackson_datatype_jackson_datatype_jdk8",
        "@maven//:com_fasterxml_jackson_datatype_jackson_datatype_jsr310",
        "@maven//:com_google_code_findbugs_jsr305",
        "@maven//:com_google_guava_guava",
        "@maven//:io_javalin_javalin",
        "@maven//:javax_inject_javax_inject",
        "@maven//:org_slf4j_slf4j_api",
    ],
)

java_binary(
    name = "RestServerMain",
    jvm_flags = [
        "-XX:+UseZGC",
    ],
    runtime_deps = [":rest"],
)
