# Simple Java+bazel example project
This is a simple java example project that tries to follow [best practices](https://bazel.build/versions/master/docs/best-practices.html).

## Usage
1. Clone the repo
2. Install [bazelisk](https://github.com/bazelbuild/bazelisk)
3. Build the repo:
    ```
    ./bazel build //...
    ./bazel test //...
    ```
4. Add/remove dependencies in [MODULE.bazel](MODULE.bazel)
    - See instructions in this file for re-generating the pinned dependency file.

## Features
- Flat project layout, one BUILD file per directory.
- Works with IntelliJ plugin
- Uses [bazelisk](https://github.com/bazelbuild/bazelisk) to pin the version of bazel
  - See .bazelversion
- Uses `rules_jvm_external` for external maven dependencies (guava, junit, dagger)
  - This supports transitive deps
  - Downloads 3rd party source code (e.g. for IntelliJ)
- BUILD/Java formatter
- Logging via log4j2
- REST
- JUnit4 + AssertJ tests
    - Run junit tests with a simple glob (technically not a best practice, but more ergonomic)
- [JMH](https://github.com/openjdk/jmh) microbenchmarks

TODO (WIP):
- Protobuf / gRPC examples
- Metrics / Tracing
- Java 20 / Loom preview

## Kubernetes Setup
On mac:
```
# Setup podman and minikube
brew install podman minikube

# Initialize a Linux VM w/4 CPUs, 2GB ram, and 50GB disk.
podman machine init --cpus 4 --memory 2048 --disk-size 50
podman machine start

# Launch minikube
minikube start --driver=podman --container-runtime=cri-o

# Now that kubernetes is running, build the containers and launch a kubernetes
deployment:

bazel build //containers:tarball
podman load < $(bazel cquery --output=files //containers:tarball)
minikube image load gautamraj.github.io/example:latest

# Apply the kubernetes config.
kubectl apply -f kubernetes/example-rest.yaml

# Expose to the outside
minikube tunnel
# TODO - seems redundant, use nodePort
kubectl expose deployment example-rest-deployment --type=LoadBalancer --port=8080
curl http://localhost:8080/hello
```
