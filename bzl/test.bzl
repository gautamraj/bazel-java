"""
Test macros
"""

def junit4_test_suite(name, srcs, deps, runtime_deps = [], size = "small", resources = [], jvm_flags = [], tags = [], data = []):
    # Assume each .java file contains a single Test class.
    for src in srcs:
        test_name = src.split("/")[-1].replace(".java", "")

        # Compile the test suite + AllTests
        native.java_test(
            name = test_name,
            srcs = [src],
            deps = deps,
            runtime_deps = runtime_deps,
            size = size,
            resources = resources,
            jvm_flags = jvm_flags,
            tags = tags,
            data = data,
        )
