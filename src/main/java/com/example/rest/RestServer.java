package com.example.rest;

import com.fasterxml.jackson.core.util.DefaultPrettyPrinter;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import io.javalin.Javalin;
import io.javalin.plugin.json.JavalinJackson;
import java.util.concurrent.TimeUnit;

public class RestServer {

  private final int port;
  private final Javalin app;

  public RestServer(int port, RestRoutes restRoutes) {
    this.port = port;

    // Configure Jackson here.
    ObjectMapper objectMapper = new ObjectMapper();
    // Support JDK8 types like Optional and Instant.
    objectMapper.registerModule(new Jdk8Module());
    objectMapper.registerModule(new JavaTimeModule());
    // Enable jackson pretty printer
    objectMapper.setDefaultPrettyPrinter(new DefaultPrettyPrinter());
    objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
    JavalinJackson.configure(objectMapper);

    this.app =
        Javalin.create(
            config -> {
              // Javalin configuration.
              config.asyncRequestTimeout = TimeUnit.SECONDS.toMillis(1);
              config.showJavalinBanner = false;
              config.requestLogger((ctx, timeMs) -> {});

              // Configure Jetty here.
              // config.server(...);
            });
    restRoutes.setRoutes(app);
  }

  public void start() {
    app.start(port);
  }

  public void stop() {
    app.stop();
  }
}
