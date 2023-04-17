package com.example.package2;

import java.util.List;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class FooTest {

  @Test
  public void testFoo() throws Exception {
    Foo foo = new Foo();
    List<String> foos = foo.getFoos();
    Assert.assertTrue(!foos.isEmpty());
  }
}
