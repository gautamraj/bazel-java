load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# bazel-deps
load("//3rdparty:workspace.bzl", "maven_dependencies")

maven_dependencies()

load("//3rdparty:target_file.bzl", "build_external_workspace")

build_external_workspace(name = "third_party")
