java_plugin(
    name = "dagger_compiler_plugin",
    generates_api = True,
    processor_class = "dagger.internal.codegen.ComponentProcessor",
    deps = ["@maven//:com_google_dagger_dagger_compiler"],
)

java_library(
    name = "dagger_with_compiler",
    exported_plugins = [":dagger_compiler_plugin"],
    visibility = ["//visibility:public"],
    exports = ["@maven//:com_google_dagger_dagger"],
)
