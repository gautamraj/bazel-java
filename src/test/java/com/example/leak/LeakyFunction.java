package com.example.leak;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
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

    // (Forget to!) release resources.
    // inflightActions.remove(actionId);

    return result;
  }

  private String doSomeAction(String input) {
    return StringUtils.reverse(input);
  }
}
