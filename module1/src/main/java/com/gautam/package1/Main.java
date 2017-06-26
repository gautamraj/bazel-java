package com.gautam.package1;

import com.google.common.base.Joiner;

import com.gautam.package2.Foo;

/**
 * Main class
 */
public class Main {

  public static void main(String[] args) {
    System.out.println("Hello world!");
    System.out.println(Joiner.on(" ").join(new Foo().getFoos()));
  }
}
