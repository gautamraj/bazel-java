package com.example.leak;

import com.google.common.base.CaseFormat;
import com.google.common.base.Strings;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringUtils;

/**
 * Example of a simple memory leak - a structure that grows unbounded.
 */
public class LeakyFunction {

  private final Set<String> inflightActions = ConcurrentHashMap.newKeySet();

  public String call(String actionId, String input) {
    // Record that we're doing something.
    inflightActions.add(actionId);

    String result = doSomeAction(input);

    // BUG: Forget to release resources 30% of the time.
    boolean shouldSkip = RandomUtils.nextDouble(0, 1) < 0.3;
    if (!shouldSkip) {
      inflightActions.remove(actionId);
    }

    return result;
  }

  private String doSomeAction(String input) {
    // Do some pointless string manipulation to create memory pressure.
    return Strings.repeat(StringUtils.reverse(
            CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, input).toUpperCase().toLowerCase()),
        10);
  }
}
