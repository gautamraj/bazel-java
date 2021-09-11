load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# https://github.com/bazelbuild/rules_jvm_external
RULES_JVM_EXTERNAL_TAG = "4.0"
RULES_JVM_EXTERNAL_SHA = "31701ad93dbfe544d597dbe62c9a1fdd76d81d8a9150c2bf1ecf928ecdf97169"

http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    sha256 = RULES_JVM_EXTERNAL_SHA,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    artifacts = [
        "com.google.code.findbugs:jsr305:3.0.2",
        "com.google.dagger:dagger-compiler:2.27",
        "com.google.dagger:dagger-producer:2.27",
        "com.google.dagger:dagger-spi:2.27",
        "com.google.dagger:dagger:2.27",
        "com.google.googlejavaformat:google-java-format:1.9",
        "com.google.guava:guava:29.0-jre",
        "javax.inject:javax.inject:1",
        "junit:junit:4.13",
    ],
    repositories = [
        "https://maven.google.com",
        "https://repo1.maven.org/maven2",
    ],
)

## bazel-deps
#load("//3rdparty:workspace.bzl", "maven_dependencies")
#
#maven_dependencies()
#
#load("//3rdparty:target_file.bzl", "build_external_workspace")
#
build_external_workspace(name = "third_party")
