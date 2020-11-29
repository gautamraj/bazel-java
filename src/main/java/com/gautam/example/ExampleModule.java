package com.gautam.example;

import com.gautam.package2.Foo;
import dagger.Module;
import dagger.Provides;
import javax.inject.Singleton;

/** The primary {@link Module} for the example application. */
@Module
public class ExampleModule {

  @Provides
  @Singleton
  static Foo provideFoo() {
    return new Foo();
  }
}
