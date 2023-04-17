package com.example.rest;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.javalin.Javalin;
import io.javalin.plugin.json.JavalinJackson;
import java.util.concurrent.TimeUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RestServer {

  private static final Logger log = LoggerFactory.getLogger(RestServer.class);

  private final int port;
  private final Javalin app;

  public RestServer(int port, RestRoutes restRoutes) {
    this.port = port;

    // Configure Jackson here.
    JavalinJackson.configure(new ObjectMapper());

    this.app =
        Javalin.create(
            config -> {
              // Javalin configuration.
              config.asyncRequestTimeout = TimeUnit.SECONDS.toMillis(1);
              config.requestLogger(
                  (ctx, timeMs) -> {
                    if (timeMs >= TimeUnit.MILLISECONDS.toMillis(100)) {
                      log.error("Slow request ({} ms): {}", timeMs, ctx);
                    }
                  });

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
