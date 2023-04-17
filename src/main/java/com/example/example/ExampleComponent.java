package com.example.example;

import com.example.package2.Foo;
import dagger.Component;
import javax.inject.Singleton;

@Singleton
@Component(
    modules = {
      ExampleModule.class,
    })
public interface ExampleComponent {
  Foo getFoo();
}
