package com.gautam.package2;

import com.google.common.collect.ImmutableList;

import java.util.List;

/**
 * The Foo class
 */
public class Foo {

  public List<String> getFoos() {
    return ImmutableList.of("foo1", "foo2", "foo3");
  }
}
