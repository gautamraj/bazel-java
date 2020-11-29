package com.gautam.package1;

import com.gautam.package2.Foo;
import com.google.common.base.Joiner;

/** Main class */
public class Main {

  public static void main(String[] args) {
    System.out.println("Hello world!");
    System.out.println(Joiner.on(" ").join(new Foo().getFoos()));
  }
}
