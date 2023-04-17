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
        "//third_party:dagger_with_compiler",
        "@maven//:com_fasterxml_jackson_core_jackson_annotations",
        "@maven//:com_fasterxml_jackson_core_jackson_core",
        "@maven//:com_fasterxml_jackson_core_jackson_databind",
        "@maven//:com_google_guava_guava",
        "@maven//:io_javalin_javalin",
        "@maven//:javax_inject_javax_inject",
        "@maven//:org_slf4j_slf4j_api",
    ],
)

java_binary(
    name = "RestServerMain",
    runtime_deps = [":rest"],
)
