package com.gautam.example;

/**
 * @author Gautam Raj (graj@stripe.com)
 */
public class ExampleMain {

  public static void main(String[] args) {
    ExampleComponent component = DaggerExampleComponent.create();
    component.getFoo();
  }
}
