package com.example.rest;

import com.example.rest.counter.VisitorRecords;
import io.javalin.Javalin;

/** Route definitions for the REST server. */
public class RestRoutes {

  public void setRoutes(Javalin app) {
    // Define all our routes -> handlers here.
    app.get("/:name", new GetNameHandler(new VisitorRecords()));
  }
}
