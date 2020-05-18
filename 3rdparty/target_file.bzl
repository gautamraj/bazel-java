# Do not edit. bazel-deps autogenerates this file from.
_JAVA_LIBRARY_TEMPLATE = """
java_library(
  name = "{name}",
  exports = [
      {exports}
  ],
  runtime_deps = [
    {runtime_deps}
  ],
  visibility = [
      "{visibility}"
  ]
)\n"""

_SCALA_IMPORT_TEMPLATE = """
scala_import(
    name = "{name}",
    exports = [
        {exports}
    ],
    jars = [
        {jars}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ]
)
"""

_SCALA_LIBRARY_TEMPLATE = """
scala_library(
    name = "{name}",
    exports = [
        {exports}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ]
)
"""

def _build_external_workspace_from_opts_impl(ctx):
    build_header = ctx.attr.build_header
    separator = ctx.attr.separator
    target_configs = ctx.attr.target_configs

    result_dict = {}
    for key, cfg in target_configs.items():
        build_file_to_target_name = key.split(":")
        build_file = build_file_to_target_name[0]
        target_name = build_file_to_target_name[1]
        if build_file not in result_dict:
            result_dict[build_file] = []
        result_dict[build_file].append(cfg)

    for key, file_entries in result_dict.items():
        build_file_contents = build_header + "\n\n"
        for build_target in file_entries:
            entry_map = {}
            for entry in build_target:
                elements = entry.split(separator)
                build_entry_key = elements[0]
                if elements[1] == "L":
                    entry_map[build_entry_key] = [e for e in elements[2::] if len(e) > 0]
                elif elements[1] == "B":
                    entry_map[build_entry_key] = (elements[2] == "true" or elements[2] == "True")
                else:
                    entry_map[build_entry_key] = elements[2]

            exports_str = ""
            for e in entry_map.get("exports", []):
                exports_str += "\"" + e + "\",\n"

            jars_str = ""
            for e in entry_map.get("jars", []):
                jars_str += "\"" + e + "\",\n"

            runtime_deps_str = ""
            for e in entry_map.get("runtimeDeps", []):
                runtime_deps_str += "\"" + e + "\",\n"

            name = entry_map["name"].split(":")[1]
            if entry_map["lang"] == "java":
                build_file_contents += _JAVA_LIBRARY_TEMPLATE.format(name = name, exports = exports_str, runtime_deps = runtime_deps_str, visibility = entry_map["visibility"])
            elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "import":
                build_file_contents += _SCALA_IMPORT_TEMPLATE.format(name = name, exports = exports_str, jars = jars_str, runtime_deps = runtime_deps_str, visibility = entry_map["visibility"])
            elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "library":
                build_file_contents += _SCALA_LIBRARY_TEMPLATE.format(name = name, exports = exports_str, runtime_deps = runtime_deps_str, visibility = entry_map["visibility"])
            else:
                print(entry_map)

        ctx.file(ctx.path(key + "/BUILD"), build_file_contents, False)
    return None

build_external_workspace_from_opts = repository_rule(
    attrs = {
        "target_configs": attr.string_list_dict(mandatory = True),
        "separator": attr.string(mandatory = True),
        "build_header": attr.string(mandatory = True),
    },
    implementation = _build_external_workspace_from_opts_impl,
)

def build_header():
    return """"""

def list_target_data_separator():
    return "|||"

def list_target_data():
    return {
        "3rdparty/jvm/com/google/code/findbugs:jsr305": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/code/findbugs:jsr305", "visibility||||||//visibility:public", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/code/findbugs/jsr305", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/dagger:dagger": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/dagger:dagger", "visibility||||||//visibility:public", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/dagger/dagger", "runtimeDeps|||L|||//3rdparty/jvm/javax/inject:javax_inject", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/dagger:dagger_compiler": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/dagger:dagger_compiler", "visibility||||||//visibility:public", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/dagger/dagger_compiler", "runtimeDeps|||L|||//3rdparty/jvm/com/google/guava:guava|||//3rdparty/jvm/com/squareup:javapoet|||//3rdparty/jvm/org/checkerframework:checker_compat_qual|||//3rdparty/jvm/com/google/guava:failureaccess|||//3rdparty/jvm/com/google/code/findbugs:jsr305|||//3rdparty/jvm/com/google/googlejavaformat:google_java_format|||//3rdparty/jvm/net/ltgt/gradle/incap:incap|||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib|||//3rdparty/jvm/org/jetbrains/kotlinx:kotlinx_metadata_jvm|||//3rdparty/jvm/com/google/dagger:dagger_spi|||//3rdparty/jvm/com/google/dagger:dagger_producers|||//3rdparty/jvm/javax/inject:javax_inject|||//3rdparty/jvm/javax/annotation:jsr250_api|||//3rdparty/jvm/com/google/dagger:dagger", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/dagger:dagger_producers": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/dagger:dagger_producers", "visibility||||||//visibility:public", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/dagger/dagger_producers", "runtimeDeps|||L|||//3rdparty/jvm/com/google/guava:guava|||//3rdparty/jvm/org/checkerframework:checker_compat_qual|||//3rdparty/jvm/com/google/guava:failureaccess|||//3rdparty/jvm/javax/inject:javax_inject|||//3rdparty/jvm/com/google/dagger:dagger", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/dagger:dagger_spi": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/dagger:dagger_spi", "visibility||||||//visibility:public", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/dagger/dagger_spi", "runtimeDeps|||L|||//3rdparty/jvm/com/google/guava:guava|||//3rdparty/jvm/com/squareup:javapoet|||//3rdparty/jvm/com/google/guava:failureaccess|||//3rdparty/jvm/com/google/code/findbugs:jsr305|||//3rdparty/jvm/com/google/dagger:dagger_producers|||//3rdparty/jvm/javax/inject:javax_inject|||//3rdparty/jvm/com/google/dagger:dagger", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/errorprone:error_prone_annotations": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/errorprone:error_prone_annotations", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/errorprone/error_prone_annotations", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/errorprone:javac_shaded": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/errorprone:javac_shaded", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/errorprone/javac_shaded", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/googlejavaformat:google_java_format": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/googlejavaformat:google_java_format", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/googlejavaformat/google_java_format", "runtimeDeps|||L|||//3rdparty/jvm/com/google/guava:guava|||//3rdparty/jvm/com/google/errorprone:javac_shaded", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/guava:failureaccess": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/guava:failureaccess", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/guava/failureaccess", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/guava:guava": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/guava:guava", "visibility||||||//visibility:public", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/guava/guava", "runtimeDeps|||L|||//3rdparty/jvm/com/google/errorprone:error_prone_annotations|||//3rdparty/jvm/com/google/guava:failureaccess|||//3rdparty/jvm/com/google/code/findbugs:jsr305|||//3rdparty/jvm/com/google/guava:listenablefuture|||//3rdparty/jvm/com/google/j2objc:j2objc_annotations|||//3rdparty/jvm/org/checkerframework:checker_qual", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/guava:listenablefuture": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/guava:listenablefuture", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/guava/listenablefuture", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/google/j2objc:j2objc_annotations": ["lang||||||java", "name||||||//3rdparty/jvm/com/google/j2objc:j2objc_annotations", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/google/j2objc/j2objc_annotations", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/com/squareup:javapoet": ["lang||||||java", "name||||||//3rdparty/jvm/com/squareup:javapoet", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/com/squareup/javapoet", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/javax/annotation:jsr250_api": ["lang||||||java", "name||||||//3rdparty/jvm/javax/annotation:jsr250_api", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/javax/annotation/jsr250_api", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/javax/inject:javax_inject": ["lang||||||java", "name||||||//3rdparty/jvm/javax/inject:javax_inject", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/javax/inject/javax_inject", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/junit:junit": ["lang||||||java", "name||||||//3rdparty/jvm/junit:junit", "visibility||||||//visibility:public", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/junit/junit", "runtimeDeps|||L|||//3rdparty/jvm/org/hamcrest:hamcrest_core", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/net/ltgt/gradle/incap:incap": ["lang||||||java", "name||||||//3rdparty/jvm/net/ltgt/gradle/incap:incap", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/net/ltgt/gradle/incap/incap", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/org/checkerframework:checker_compat_qual": ["lang||||||java", "name||||||//3rdparty/jvm/org/checkerframework:checker_compat_qual", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/org/checkerframework/checker_compat_qual", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/org/checkerframework:checker_qual": ["lang||||||java", "name||||||//3rdparty/jvm/org/checkerframework:checker_qual", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/org/checkerframework/checker_qual", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/org/hamcrest:hamcrest_core": ["lang||||||java", "name||||||//3rdparty/jvm/org/hamcrest:hamcrest_core", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/org/hamcrest/hamcrest_core", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/org/jetbrains:annotations": ["lang||||||java", "name||||||//3rdparty/jvm/org/jetbrains:annotations", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/org/jetbrains/annotations", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib": ["lang||||||java", "name||||||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/org/jetbrains/kotlin/kotlin_stdlib", "runtimeDeps|||L|||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_common|||//3rdparty/jvm/org/jetbrains:annotations", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_common": ["lang||||||java", "name||||||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_common", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/org/jetbrains/kotlin/kotlin_stdlib_common", "runtimeDeps|||L|||", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
        "3rdparty/jvm/org/jetbrains/kotlinx:kotlinx_metadata_jvm": ["lang||||||java", "name||||||//3rdparty/jvm/org/jetbrains/kotlinx:kotlinx_metadata_jvm", "visibility||||||//3rdparty/jvm:__subpackages__", "kind||||||library", "deps|||L|||", "jars|||L|||", "sources|||L|||", "exports|||L|||//external:jar/org/jetbrains/kotlinx/kotlinx_metadata_jvm", "runtimeDeps|||L|||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib", "processorClasses|||L|||", "generatesApi|||B|||false", "licenses|||L|||", "generateNeverlink|||B|||false"],
    }

def build_external_workspace(name):
    return build_external_workspace_from_opts(name = name, target_configs = list_target_data(), separator = list_target_data_separator(), build_header = build_header())
