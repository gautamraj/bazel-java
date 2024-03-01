load("@rules_java//java:defs.bzl", "java_library")

# Import this to get both dagger and the annotation processor.
java_library(
    name = "dagger",
    exported_plugins = [":dagger_compiler_plugin"],
    visibility = ["//visibility:public"],
    exports = ["@maven//:com_google_dagger_dagger"],
)

java_plugin(
    name = "dagger_compiler_plugin",
    generates_api = True,
    processor_class = "dagger.internal.codegen.ComponentProcessor",
    deps = ["@maven//:com_google_dagger_dagger_compiler"],
)

# Import this to get both jmh and the annotation processor.
java_library(
    name = "jmh",
    exported_plugins = [":jmh_plugin"],
    visibility = ["//visibility:public"],
    exports = ["@maven//:org_openjdk_jmh_jmh_core"],
)

java_plugin(
    name = "jmh_plugin",
    generates_api = True,
    processor_class = "org.openjdk.jmh.generators.BenchmarkProcessor",
    deps = ["@maven//:org_openjdk_jmh_jmh_generator_annprocess"],
)
