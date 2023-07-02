package com.example.bench;

import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;
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
 * Benchmark some sanitize functions.
 *
 * <pre>
 * bazel run //src/test/java/com/example/bench:SanitizeBenchmark
 * </pre>
 *
 * <p>To generate profiles, download async-profiler and run:
 *
 * <pre>
 * bazel run //src/test/java/com/example/bench:SanitizeBenchmark -- -prof async:libPath=/path/to/async-profiler/build/libasyncProfiler.so
 * </pre>
 */
@Fork(value = 1)
@Threads(value = 4)
@Warmup(iterations = 2, time = 5)
@Measurement(iterations = 3, time = 20)
@BenchmarkMode(Mode.Throughput)
@OutputTimeUnit(TimeUnit.SECONDS)
@State(Scope.Benchmark)
public class SanitizeBenchmark {

  private Pattern pattern;

  @Setup
  public void setup() {
    pattern = Pattern.compile("[^a-zA-Z0-9]");
  }

  @Benchmark
  public String sanitizeStringReplaceAll() {
    String input = RandomStringUtils.random(20);
    return input.replaceAll("[^a-zA-Z0-9]", "");
  }

  @Benchmark
  public String sanitizeStringPattern() {
    String input = RandomStringUtils.random(20);
    return pattern.matcher(input).replaceAll("");
  }

  @Benchmark
  public String sanitizeStringForLoop() {
    String input = RandomStringUtils.random(20);
    char[] chars = new char[input.length()];
    int j = 0;
    for (int i = 0; i < input.length(); i++) {
      if (!Character.isLetterOrDigit(input.charAt(i))) {
        // Keep these chars.
        chars[j++] = input.charAt(i);
      }
    }
    if (j == 0) {
      // Keep everything.
      return input;
    }
    return new String(Arrays.copyOf(chars, j));
  }
}
