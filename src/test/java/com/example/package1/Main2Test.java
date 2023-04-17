package com.example.package1;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class Main2Test {

  @Test
  public void testMain2() throws Exception {
    Main.main(MyLibrary.TEST_DATA);
  }
}
