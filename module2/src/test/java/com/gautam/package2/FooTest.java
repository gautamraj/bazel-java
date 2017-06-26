package com.gautam.package2;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import java.util.List;

@RunWith(JUnit4.class)
public class FooTest {

  @Test
  public void testFoo() throws Exception {
    Foo foo = new Foo();
    List<String> foos = foo.getFoos();
    Assert.assertTrue(!foos.isEmpty());
  }
}
