package com.example.bench;

import com.example.rest.RestRoutes;
import com.example.rest.RestServer;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandler;
import java.net.http.HttpResponse.BodySubscriber;
import java.net.http.HttpResponse.BodySubscribers;
import java.net.http.HttpResponse.ResponseInfo;
import java.nio.charset.Charset;
import java.util.UUID;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Fork;
import org.openjdk.jmh.annotations.Measurement;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.TearDown;
import org.openjdk.jmh.annotations.Threads;
import org.openjdk.jmh.annotations.Warmup;

@Fork(value = 1)
@Threads(value = 1)
@Warmup(iterations = 1, time = 5)
@Measurement(iterations = 3, time = 5)
@BenchmarkMode(Mode.Throughput)
@OutputTimeUnit(TimeUnit.SECONDS)
@State(Scope.Benchmark)
public class ExampleBenchmark {

  private RestServer server;
  private HttpClient httpClient;

  @Setup
  public void setup() {
    server = new RestServer(8080, new RestRoutes());
    server.start();
    httpClient = HttpClient.newHttpClient();
  }

  @TearDown
  public void tearDown() {
    server.stop();
  }

  // Benchmark the HTTP server
  @Benchmark
  public HttpResponse<String> benchServer() throws ExecutionException, InterruptedException {
    // Use the HTTP client to make a request to the server.
    Future<HttpResponse<String>> future = httpClient.sendAsync(
        HttpRequest.newBuilder().GET().uri(URI.create(
            String.format("http://localhost:8080?name=%s", UUID.randomUUID()))).build(),
        new StringHandler());
    return future.get();
  }

  static class StringHandler implements BodyHandler<String> {

    @Override
    public BodySubscriber<String> apply(ResponseInfo responseInfo) {
      return BodySubscribers.ofString(Charset.defaultCharset());
    }
  }
}
