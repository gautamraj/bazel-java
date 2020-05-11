package com.gautam.package1;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/**
 * @author Gautam Raj (gautamraj@gmail.com)
 */
@RunWith(JUnit4.class)
public class MyITCase {

  @Test
  public void testEverything() throws Exception {
    Main.main(MyLibrary.TEST_DATA);
  }
}
