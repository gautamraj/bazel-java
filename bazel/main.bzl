def java_package(name, package, deps = []):
    srcs = native.glob(["*.java"])
    main_srcs = native.glob(["*Main.java"])

    main_classes = []
    for src in main_srcs:
        # Strip off .java
        main_classes += [package + "." + src[:-5]]

    native.java_library(
        name = name,
        srcs = srcs,
        deps = deps,
    )

    for main_class in main_classes:
        native.java_binary(
            name = main_class.split('.')[-1],
            runtime_deps = [ name ],
            main_class = main_class,
        )
