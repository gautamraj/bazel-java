package com.example.rest;

import com.example.rest.counter.VisitorRecords;
import com.example.rest.counter.VisitorRecords.VisitorRecord;
import io.javalin.http.Context;
import io.javalin.http.Handler;
import java.time.Instant;
import java.util.Optional;
import javax.annotation.Nullable;

/**
 * {@link GetNameHandler} takes a name from the path and returns a JSON response with a greeting and
 * a visit count.
 */
class GetNameHandler implements Handler {

  private final VisitorRecords visitorRecords;

  public GetNameHandler(VisitorRecords visitorRecords) {
    this.visitorRecords = visitorRecords;
  }

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

    public final int visitCount;
    public final Optional<Instant> lastVisited;
    public final String message;

    public Response(String name) {
      @Nullable VisitorRecord record = visitorRecords.getAndRecordVisit(name);
      if (record == null) {
        this.visitCount = 0;
        this.lastVisited = Optional.empty();
        this.message = String.format("Hello %s, this is your first visit.", name);
      } else {
        this.visitCount = record.visitCount + 1;
        this.lastVisited = Optional.of(record.visitTime);
        this.message = String.format("Hello %s, this is visit number %d. You last visited at %s.",
            name, visitCount, lastVisited.get());
      }
    }
  }
}
