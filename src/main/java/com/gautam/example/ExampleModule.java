package com.gautam.example;

import com.gautam.package2.Foo;
import dagger.Module;
/** @author Gautam Raj (graj@stripe.com) */
@Module
public class ExampleModule {

  static Foo provideFoo() {
    return new Foo();
  }
}
