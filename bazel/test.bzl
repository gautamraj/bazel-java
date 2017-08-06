"""
Functions to be used by all test packages
"""

def java_test_package(name, package, deps, size="small", resources=[],
                      jvm_flags=[], tags=[], data=[]):
    """
    The test package consists of:
    - Library sources (optional)
    - Unit tests (*Test.java) (optional)
    - Integration tests (*ITCase.java) (optional)
    """

    library_srcs = native.glob(["*.java"], exclude=["*Test.java", "*ITCase.java"])
    unit_test_srcs = native.glob(["*Test.java"])
    itcase_srcs = native.glob(["*ITCase.java"])

    if library_srcs:
        native.java_library(
            name = name,
            package = package,
            srcs = library_srcs,
            deps = deps)
        # Add this library as a dependency for unit/itcases
        deps += [ name ]

    # Unit tests
    if unit_test_srcs:
        junit4_suite_test(
            name = "unit",
            package = package,
            srcs = unit_test_srcs,
            deps = deps)

    # ITCases
    if itcase_srcs:
        junit4_suite_test(
            name = "itcase",
            package = package,
            srcs = unit_test_srcs,
            deps = deps)


def junit4_suite_test(name, package, srcs, deps, size="small", resources=[],
                      jvm_flags=[], tags=[], data=[]):
    """
    Build a suite of tests to run. All tests are run under the same JVM, which
    allows tests to share the cost of setup (speeding up overall execution).

    Based on
    https://groups.google.com/d/msg/bazel-discuss/4tlbmW1XWx4/-CG4PgxKAgAJ
    """

    # Assume each .java file contains a single Test class.
    tests = []
    for src in srcs:
        if src.endswith(".java"):
            tests += [src.replace(".java", ".class")]

    # Generate the AllTests.java test suite
    alltests_name = name + "_AllTests"
    native.genrule(
        name = alltests_name,
        outs = ["AllTests.java"],
        cmd = """
cat <<EOF >> $@
package %s;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({%s})
public class AllTests {}
EOF
""" % (package, ",".join(tests))
    )

    # Compile the test suite + AllTests
    native.java_test(
        name = name,
        srcs = srcs + [alltests_name],
        test_class = package + ".AllTests",
        resources = resources,
        data = data,
        size = size,
        tags = tags,
        jvm_flags = jvm_flags,
        # Junit is required by AllTests
        deps = set(deps + [
            "//third_party:junit",
        ]),
    )
