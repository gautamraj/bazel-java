# Do not edit. bazel-deps autogenerates this file from maven_dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
# duplicates in com.google.code.findbugs:jsr305 fixed to 3.0.2
# - com.google.dagger:dagger-compiler:2.27 wanted version 3.0.1
# - com.google.dagger:dagger-spi:2.27 wanted version 3.0.1
# - com.google.guava:guava:29.0-jre wanted version 3.0.2
    {"artifact": "com.google.code.findbugs:jsr305:3.0.2", "lang": "java", "sha1": "25ea2e8b0c338a877313bd4672d3fe056ea78f0d", "sha256": "766ad2a0783f2687962c8ad74ceecc38a28b9f72a2d085ee438b7813e928d0c7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar", "source": {"sha1": "b19b5927c2c25b6c70f093767041e641ae0b1b35", "sha256": "1c9e85e272d0708c6a591dc74828c71603053b48cc75ae83cce56912a2aa063b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2-sources.jar"} , "name": "com_google_code_findbugs_jsr305", "actual": "@com_google_code_findbugs_jsr305//jar", "bind": "jar/com/google/code/findbugs/jsr305"},
    {"artifact": "com.google.dagger:dagger-compiler:2.27", "lang": "java", "sha1": "437cb0485718e56eb94229fe419cae2ba5d8b0b4", "sha256": "9b231603ea69f2420d285e560d44925c823fc7e5bb8f2a34ccf0a1f0f5ae1570", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-compiler/2.27/dagger-compiler-2.27.jar", "source": {"sha1": "5871303f9f56d23090a2be9930600abb57383c0a", "sha256": "f3539335bace7dbaedcd1ce1e53ee5f89d09a2091d10b94b0f67a72b433f8de2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-compiler/2.27/dagger-compiler-2.27-sources.jar"} , "name": "com_google_dagger_dagger_compiler", "actual": "@com_google_dagger_dagger_compiler//jar", "bind": "jar/com/google/dagger/dagger_compiler"},
    {"artifact": "com.google.dagger:dagger-producers:2.27", "lang": "java", "sha1": "78a9e506995eb8b283456d31a1809482c0594b39", "sha256": "d8ad811013eab15b065dacb926a5498f445173c701b5801ee5dd322fc6a414a3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-producers/2.27/dagger-producers-2.27.jar", "source": {"sha1": "f365d128c238586a12d7386101a4e63d984e4819", "sha256": "9e0783d4198073ab590a4bb4e11205899d7132b2cda26e0ce6a3a099c70ff7cb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-producers/2.27/dagger-producers-2.27-sources.jar"} , "name": "com_google_dagger_dagger_producers", "actual": "@com_google_dagger_dagger_producers//jar", "bind": "jar/com/google/dagger/dagger_producers"},
    {"artifact": "com.google.dagger:dagger-spi:2.27", "lang": "java", "sha1": "d719a523e5b4040f6522a8316eff018148442b42", "sha256": "7cfd0c0dea881141d2ac78107af4555b4e9b7446c91e05d03d5f1b09f8ef2776", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-spi/2.27/dagger-spi-2.27.jar", "source": {"sha1": "b54bba08e237a3357d74dd98bb4c60e87cd3e8a2", "sha256": "e0f4b15b9e7cd0f73b3c91431a323f43c9b2f37ca9a0b3eca1e3cb95bbe2faf6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-spi/2.27/dagger-spi-2.27-sources.jar"} , "name": "com_google_dagger_dagger_spi", "actual": "@com_google_dagger_dagger_spi//jar", "bind": "jar/com/google/dagger/dagger_spi"},
    {"artifact": "com.google.dagger:dagger:2.27", "lang": "java", "sha1": "7bee2792b10523e298a7de508635c6eed0c309be", "sha256": "8856f8c39b7f41cb4e570a8cb7476936811a5daec82a4a7f6369bea0af587917", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger/2.27/dagger-2.27.jar", "source": {"sha1": "a325dd366f838606298ddb85735883dfbdd7b6b8", "sha256": "6078d68ea26da9b313b7e9e4554e1ed92a11b72ff157cdf233e7bdf478ff9426", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger/2.27/dagger-2.27-sources.jar"} , "name": "com_google_dagger_dagger", "actual": "@com_google_dagger_dagger//jar", "bind": "jar/com/google/dagger/dagger"},
    {"artifact": "com.google.errorprone:error_prone_annotations:2.3.4", "lang": "java", "sha1": "dac170e4594de319655ffb62f41cbd6dbb5e601e", "sha256": "baf7d6ea97ce606c53e11b6854ba5f2ce7ef5c24dddf0afa18d1260bd25b002c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.jar", "source": {"sha1": "950adf6dcd7361e3d1e544a6e13b818587f95d14", "sha256": "0b1011d1e2ea2eab35a545cffd1cff3877f131134c8020885e8eaf60a7d72f91", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4-sources.jar"} , "name": "com_google_errorprone_error_prone_annotations", "actual": "@com_google_errorprone_error_prone_annotations//jar", "bind": "jar/com/google/errorprone/error_prone_annotations"},
    {"artifact": "com.google.googlejavaformat:google-java-format:1.9", "lang": "java", "sha1": "60b4daa3d05aa856eeea83e2ec3c374446961692", "sha256": "5a2a03d4225805b1666a742c746e7826057e247bc86b45920e4a891b56cc65fe", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/googlejavaformat/google-java-format/1.9/google-java-format-1.9.jar", "source": {"sha1": "b8e9b5dbc6c9020506669d8181e0be23d920b420", "sha256": "ab34eb16a4203ec9e31e9a7bf953ad68761283696ca79a361790f0e0da006585", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/googlejavaformat/google-java-format/1.9/google-java-format-1.9-sources.jar"} , "name": "com_google_googlejavaformat_google_java_format", "actual": "@com_google_googlejavaformat_google_java_format//jar", "bind": "jar/com/google/googlejavaformat/google_java_format"},
    {"artifact": "com.google.guava:failureaccess:1.0.1", "lang": "java", "sha1": "1dcf1de382a0bf95a3d8b0849546c88bac1292c9", "sha256": "a171ee4c734dd2da837e4b16be9df4661afab72a41adaf31eb84dfdaf936ca26", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar", "source": {"sha1": "1d064e61aad6c51cc77f9b59dc2cccc78e792f5a", "sha256": "092346eebbb1657b51aa7485a246bf602bb464cc0b0e2e1c7e7201fadce1e98f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1-sources.jar"} , "name": "com_google_guava_failureaccess", "actual": "@com_google_guava_failureaccess//jar", "bind": "jar/com/google/guava/failureaccess"},
# duplicates in com.google.guava:guava fixed to 29.0-jre
# - com.google.dagger:dagger-compiler:2.27 wanted version 27.1-jre
# - com.google.dagger:dagger-producers:2.27 wanted version 27.1-jre
# - com.google.dagger:dagger-spi:2.27 wanted version 27.1-jre
# - com.google.googlejavaformat:google-java-format:1.9 wanted version 28.1-jre
    {"artifact": "com.google.guava:guava:29.0-jre", "lang": "java", "sha1": "801142b4c3d0f0770dd29abea50906cacfddd447", "sha256": "b22c5fb66d61e7b9522531d04b2f915b5158e80aa0b40ee7282c8bfb07b0da25", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/29.0-jre/guava-29.0-jre.jar", "source": {"sha1": "33e6868bc0fcb9b4b493123eeec78d1352934e87", "sha256": "cfcbe29dd5125f5b360370b4ecd7f7ef44fba68f4f037e90bce7315682afc0ea", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/29.0-jre/guava-29.0-jre-sources.jar"} , "name": "com_google_guava_guava", "actual": "@com_google_guava_guava//jar", "bind": "jar/com/google/guava/guava"},
    {"artifact": "com.google.guava:listenablefuture:9999.0-empty-to-avoid-conflict-with-guava", "lang": "java", "sha1": "b421526c5f297295adef1c886e5246c39d4ac629", "sha256": "b372a037d4230aa57fbeffdef30fd6123f9c0c2db85d0aced00c91b974f33f99", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar", "name": "com_google_guava_listenablefuture", "actual": "@com_google_guava_listenablefuture//jar", "bind": "jar/com/google/guava/listenablefuture"},
    {"artifact": "com.google.j2objc:j2objc-annotations:1.3", "lang": "java", "sha1": "ba035118bc8bac37d7eff77700720999acd9986d", "sha256": "21af30c92267bd6122c0e0b4d20cccb6641a37eaf956c6540ec471d584e64a7b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar", "source": {"sha1": "d26c56180205cbb50447c3eca98ecb617cf9f58b", "sha256": "ba4df669fec153fa4cd0ef8d02c6d3ef0702b7ac4cabe080facf3b6e490bb972", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3-sources.jar"} , "name": "com_google_j2objc_j2objc_annotations", "actual": "@com_google_j2objc_j2objc_annotations//jar", "bind": "jar/com/google/j2objc/j2objc_annotations"},
    {"artifact": "com.squareup:javapoet:1.11.1", "lang": "java", "sha1": "210e69f58dfa76c5529a303913b4a30c2bfeb76b", "sha256": "9cbf2107be499ec6e95afd36b58e3ca122a24166cdd375732e51267d64058e90", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/squareup/javapoet/1.11.1/javapoet-1.11.1.jar", "source": {"sha1": "8da7f5aaa62c6e22f53d360b2d0e21f6fa35ef32", "sha256": "63d3187d924582b1afe9eb171e725d27a7e15603513890de0f8804a7fc07e9ac", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/squareup/javapoet/1.11.1/javapoet-1.11.1-sources.jar"} , "name": "com_squareup_javapoet", "actual": "@com_squareup_javapoet//jar", "bind": "jar/com/squareup/javapoet"},
    {"artifact": "javax.annotation:jsr250-api:1.0", "lang": "java", "sha1": "5025422767732a1ab45d93abfea846513d742dcf", "sha256": "a1a922d0d9b6d183ed3800dfac01d1e1eb159f0e8c6f94736931c1def54a941f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.jar", "source": {"sha1": "9b1fba77edd118e13c42bda43d3c993dadd52c25", "sha256": "025c47d76c60199381be07012a0c5f9e74661aac5bd67f5aec847741c5b7f838", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0-sources.jar"} , "name": "javax_annotation_jsr250_api", "actual": "@javax_annotation_jsr250_api//jar", "bind": "jar/javax/annotation/jsr250_api"},
    {"artifact": "javax.inject:javax.inject:1", "lang": "java", "sha1": "6975da39a7040257bd51d21a231b76c915872d38", "sha256": "91c77044a50c481636c32d916fd89c9118a72195390452c81065080f957de7ff", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar", "source": {"sha1": "a00123f261762a7c5e0ec916a2c7c8298d29c400", "sha256": "c4b87ee2911c139c3daf498a781967f1eb2e75bc1a8529a2e7b328a15d0e433e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/javax/inject/javax.inject/1/javax.inject-1-sources.jar"} , "name": "javax_inject_javax_inject", "actual": "@javax_inject_javax_inject//jar", "bind": "jar/javax/inject/javax_inject"},
    {"artifact": "junit:junit:4.13", "lang": "java", "sha1": "e49ccba652b735c93bd6e6f59760d8254cf597dd", "sha256": "4b8532f63bdc0e0661507f947eb324a954d1dbac631ad19c8aa9a00feed1d863", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/junit/junit/4.13/junit-4.13.jar", "source": {"sha1": "d10a9c3acc6c07a5700e37697b5a6b4dcfb8abf9", "sha256": "3d5451031736d4904582b211858a09eeefdb26eb08f0633ca8addf04fde3e0fc", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/junit/junit/4.13/junit-4.13-sources.jar"} , "name": "junit_junit", "actual": "@junit_junit//jar", "bind": "jar/junit/junit"},
    {"artifact": "net.ltgt.gradle.incap:incap:0.2", "lang": "java", "sha1": "0c73e3db9bee414d6ee27995d951fcdbee09acad", "sha256": "b625b9806b0f1e4bc7a2e3457119488de3cd57ea20feedd513db070a573a4ffd", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/ltgt/gradle/incap/incap/0.2/incap-0.2.jar", "source": {"sha1": "5cf72f18b924fcfd7fd452025c890e7e7151a840", "sha256": "15c3cd213a214c94ef7ed262e00ab10c75d1680b0b9203b47801e7068de1cf5c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/ltgt/gradle/incap/incap/0.2/incap-0.2-sources.jar"} , "name": "net_ltgt_gradle_incap_incap", "actual": "@net_ltgt_gradle_incap_incap//jar", "bind": "jar/net/ltgt/gradle/incap/incap"},
    {"artifact": "org.checkerframework:checker-compat-qual:2.5.3", "lang": "java", "sha1": "045f92d2e0676d05ae9297269b8268f93a875d4a", "sha256": "d76b9afea61c7c082908023f0cbc1427fab9abd2df915c8b8a3e7a509bccbc6d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-compat-qual/2.5.3/checker-compat-qual-2.5.3.jar", "source": {"sha1": "5853ff40085a6f44b51e6fe2d0ee95792190956d", "sha256": "68011773fd60cfc7772508134086787210ba2a1443e3f9c3f5d4233a226c3346", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-compat-qual/2.5.3/checker-compat-qual-2.5.3-sources.jar"} , "name": "org_checkerframework_checker_compat_qual", "actual": "@org_checkerframework_checker_compat_qual//jar", "bind": "jar/org/checkerframework/checker_compat_qual"},
    {"artifact": "org.checkerframework:checker-qual:2.11.1", "lang": "java", "sha1": "8c43bf8f99b841d23aadda6044329dad9b63c185", "sha256": "015224a4b1dc6de6da053273d4da7d39cfea20e63038169fc45ac0d1dc9c5938", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-qual/2.11.1/checker-qual-2.11.1.jar", "source": {"sha1": "81dbb91c8dc3c53ae7066ce9e70ed7efb0551261", "sha256": "7d3b990687be9b980a9dc7853f4b0f279eb437e28efe3c9903acaf20450f55b5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-qual/2.11.1/checker-qual-2.11.1-sources.jar"} , "name": "org_checkerframework_checker_qual", "actual": "@org_checkerframework_checker_qual//jar", "bind": "jar/org/checkerframework/checker_qual"},
    {"artifact": "org.hamcrest:hamcrest-core:1.3", "lang": "java", "sha1": "42a25dc3219429f0e5d060061f71acb49bf010a0", "sha256": "66fdef91e9739348df7a096aa384a5685f4e875584cce89386a7a47251c4d8e9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar", "source": {"sha1": "1dc37250fbc78e23a65a67fbbaf71d2e9cbc3c0b", "sha256": "e223d2d8fbafd66057a8848cc94222d63c3cedd652cc48eddc0ab5c39c0f84df", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3-sources.jar"} , "name": "org_hamcrest_hamcrest_core", "actual": "@org_hamcrest_hamcrest_core//jar", "bind": "jar/org/hamcrest/hamcrest_core"},
    {"artifact": "org.jetbrains.kotlin:kotlin-stdlib-common:1.3.50", "lang": "java", "sha1": "3d9cd3e1bc7b92e95f43d45be3bfbcf38e36ab87", "sha256": "8ce678e88e4ba018b66dacecf952471e4d7dfee156a8a819760a5a5ff29d323c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-common/1.3.50/kotlin-stdlib-common-1.3.50.jar", "source": {"sha1": "8ac406cf33e942265c4abb33ee0acdee79292dd6", "sha256": "34199658f3ab0b1f50f858e2636371271fa4d783833e6e1b5a0ea3f6d7d3655b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-common/1.3.50/kotlin-stdlib-common-1.3.50-sources.jar"} , "name": "org_jetbrains_kotlin_kotlin_stdlib_common", "actual": "@org_jetbrains_kotlin_kotlin_stdlib_common//jar", "bind": "jar/org/jetbrains/kotlin/kotlin_stdlib_common"},
# duplicates in org.jetbrains.kotlin:kotlin-stdlib promoted to 1.3.50
# - com.google.dagger:dagger-compiler:2.27 wanted version 1.3.50
# - org.jetbrains.kotlinx:kotlinx-metadata-jvm:0.1.0 wanted version 1.3.31
    {"artifact": "org.jetbrains.kotlin:kotlin-stdlib:1.3.50", "lang": "java", "sha1": "b529d1738c7e98bbfa36a4134039528f2ce78ebf", "sha256": "e6f05746ee0366d0b52825a090fac474dcf44082c9083bbb205bd16976488d6c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib/1.3.50/kotlin-stdlib-1.3.50.jar", "source": {"sha1": "bc0c767786c4a3c042a364e69d3f3dd5ff5253a5", "sha256": "8452552d2012686eb20466804c8b54c38673040527756f10d2d13e1db8d17380", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib/1.3.50/kotlin-stdlib-1.3.50-sources.jar"} , "name": "org_jetbrains_kotlin_kotlin_stdlib", "actual": "@org_jetbrains_kotlin_kotlin_stdlib//jar", "bind": "jar/org/jetbrains/kotlin/kotlin_stdlib"},
    {"artifact": "org.jetbrains.kotlinx:kotlinx-metadata-jvm:0.1.0", "lang": "java", "sha1": "505481587ce23e1d8207734e496632df5c4e6f58", "sha256": "9753bb39efef35957c5c15df9a3cb769aabf2cdfa74b47afcb7760e5146be3b5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/kotlinx-metadata-jvm/0.1.0/kotlinx-metadata-jvm-0.1.0.jar", "source": {"sha1": "a6d23e115619dcac43668883578720c2e4cd6d4b", "sha256": "a2cdb2a6a90a199addb8f312e3d5ab12b4626573f22b076176cc1d09999d6e78", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/kotlinx-metadata-jvm/0.1.0/kotlinx-metadata-jvm-0.1.0-sources.jar"} , "name": "org_jetbrains_kotlinx_kotlinx_metadata_jvm", "actual": "@org_jetbrains_kotlinx_kotlinx_metadata_jvm//jar", "bind": "jar/org/jetbrains/kotlinx/kotlinx_metadata_jvm"},
    {"artifact": "org.jetbrains:annotations:13.0", "lang": "java", "sha1": "919f0dfe192fb4e063e7dacadee7f8bb9a2672a9", "sha256": "ace2a10dc8e2d5fd34925ecac03e4988b2c0f851650c94b8cef49ba1bd111478", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jetbrains/annotations/13.0/annotations-13.0.jar", "source": {"sha1": "5991ca87ef1fb5544943d9abc5a9a37583fabe03", "sha256": "42a5e144b8e81d50d6913d1007b695e62e614705268d8cf9f13dbdc478c2c68e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jetbrains/annotations/13.0/annotations-13.0-sources.jar"} , "name": "org_jetbrains_annotations", "actual": "@org_jetbrains_annotations//jar", "bind": "jar/org/jetbrains/annotations"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
