package com.example.rest;

import com.fasterxml.jackson.core.util.DefaultPrettyPrinter;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import io.javalin.Javalin;
import io.javalin.json.JavalinJackson;
import java.util.concurrent.TimeUnit;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class RestServer {
  private static final Logger log = LogManager.getLogger(RestServer.class);

  private final int port;
  private final Javalin app;

  public RestServer(int port, RestRoutes restRoutes) {
    this.port = port;

    // Configure Jackson here.
    final ObjectMapper objectMapper = new ObjectMapper();
    // Support JDK8 types like Optional and Instant.
    objectMapper.registerModule(new Jdk8Module());
    objectMapper.registerModule(new JavaTimeModule());
    // Enable jackson pretty printer
    objectMapper.setDefaultPrettyPrinter(new DefaultPrettyPrinter());
    objectMapper.enable(SerializationFeature.INDENT_OUTPUT);

    this.app =
        Javalin.create(
            config -> {
              // Javalin configuration.
              config.requestLogger.http(
                  (ctx, timeMs) -> {
                    log.debug("Processed {} in {} ms", ctx.path(), timeMs);
                  });
              config.jsonMapper(new JavalinJackson(objectMapper, true));
              config.useVirtualThreads = true;

              // Configure Jetty here.
              // config.server(...);
            });
    restRoutes.setRoutes(app);
  }

  public void start() {
    app.start("0.0.0.0", port);
  }

  public void stop() {
    app.stop();
  }
}
