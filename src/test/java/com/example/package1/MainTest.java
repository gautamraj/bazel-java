package com.example.package1;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class MainTest {

  @Test
  public void testMain1() throws Exception {
    Main.main(MyLibrary.TEST_DATA);
  }
}
