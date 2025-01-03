package com.example.leak;

import com.google.common.util.concurrent.RateLimiter;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import org.apache.commons.lang3.RandomStringUtils;
import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Fork;
import org.openjdk.jmh.annotations.Measurement;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.Threads;
import org.openjdk.jmh.annotations.Warmup;

/**
 * Simple example benchmark. Run with:
 *
 * <pre>
 * bazel run //src/test/java/com/example/bench:ExampleBenchmark
 * </pre>
 *
 * <p>To generate profiles, download async-profiler and run:
 *
 * <pre>
 * bazel run //src/test/java/com/example/bench:ExampleBenchmark -- -prof async:libPath=/path/to/async-profiler/build/libasyncProfiler.so
 * </pre>
 */
@Fork(
    value = 1,
    jvmArgsAppend = {"-XX:StartFlightRecording:memory-leaks=gc-roots,maxsize=1G,filename=/tmp/"})
@Threads(value = 4)
@Warmup(iterations = 0)
@Measurement(iterations = 1, time = 60)
@BenchmarkMode(Mode.Throughput)
@OutputTimeUnit(TimeUnit.SECONDS)
@State(Scope.Benchmark)
public class LeakyFunctionBenchmark {

  private LeakyFunction leakyFunction;
  private RateLimiter rateLimiter;

  @Setup
  public void setup() {
    leakyFunction = new LeakyFunction();
    rateLimiter = RateLimiter.create(50000);
  }

  @Benchmark
  public String benchLeak() {
    rateLimiter.acquire();
    String actionId = UUID.randomUUID().toString();
    String input = RandomStringUtils.randomAlphanumeric(16);
    return leakyFunction.call(actionId, input);
  }
}
