package com.gautam.rest;

import com.google.common.util.concurrent.AtomicLongMap;
import io.javalin.Javalin;
import io.javalin.http.Context;
import io.javalin.http.Handler;

public class RestRoutes {

  public void setRoutes(Javalin app) {
    // Define all our routes here.
    app.get("/:name", new GetNameHandler());
  }

  private static class GetNameHandler implements Handler {
    private final AtomicLongMap<String> visitCounter = AtomicLongMap.create();

    @Override
    public void handle(Context ctx) {
      String name = ctx.pathParam("name");
      Response response = new Response(name);
      ctx.json(response);
    }

    public class Response {
      public final String message;
      public final long visitCount;

      public Response(String name) {
        this.visitCount = visitCounter.getAndIncrement(name);
        this.message = String.format("Hello %s, this is your %d visit.", name, visitCount);
      }
    }
  }
}
