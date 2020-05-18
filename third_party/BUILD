java_plugin(
    name = "dagger_compiler_plugin",
    generates_api = True,
    processor_class = "dagger.internal.codegen.ComponentProcessor",
    deps = ["@third_party//3rdparty/jvm/com/google/dagger:dagger_compiler"],
)

java_library(
    name = "dagger_with_compiler",
    exported_plugins = [":dagger_compiler_plugin"],
    visibility = ["//visibility:public"],
    exports = ["@third_party//3rdparty/jvm/com/google/dagger"],
)
