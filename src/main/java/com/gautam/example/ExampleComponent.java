package com.gautam.example;

import com.gautam.package2.Foo;
import dagger.Component;

/**
 * @author Gautam Raj (graj@stripe.com)
 */
@Component
public interface ExampleComponent {
  Foo getFoo();
}
