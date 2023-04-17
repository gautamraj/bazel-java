package com.example.rest;

public class RestServerMain {

  public static void main(String[] args) throws Exception {
    RestServer server = new RestServer(8080, new RestRoutes());

    server.start();
    Runtime.getRuntime().addShutdownHook(new Thread(server::stop));

    // Wait here forever for a shutdown signal.
    Thread.currentThread().join();
  }
}
