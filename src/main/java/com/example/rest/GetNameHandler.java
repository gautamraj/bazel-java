package com.example.rest;

import com.google.common.util.concurrent.AtomicLongMap;
import io.javalin.http.Context;
import io.javalin.http.Handler;

/**
 * {@link GetNameHandler} takes a name from the path and returns a JSON response with a greeting and
 * a visit count.
 */
class GetNameHandler implements Handler {

  private final AtomicLongMap<String> visitCounter = AtomicLongMap.create();

  @Override
  public void handle(Context ctx) {
    String name = ctx.pathParam("name");

    // Validate the request.
    if (name.isEmpty()) {
      ctx.status(400);
      return;
    }

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
