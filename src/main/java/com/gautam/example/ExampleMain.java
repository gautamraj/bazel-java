package com.gautam.example;

/** Entrypoint into the example project */
public class ExampleMain {

  public static void main(String[] args) {
    ExampleComponent component = DaggerExampleComponent.create();
    component.getFoo();
  }
}
