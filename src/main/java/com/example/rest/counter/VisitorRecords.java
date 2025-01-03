package com.example.rest.counter;

import com.google.common.collect.Maps;
import java.time.Instant;
import java.util.Map;
import edu.umd.cs.findbugs.annotations.Nullable;

public class VisitorRecords {

  public static class VisitorRecord {

    public final Instant visitTime;
    public final int visitCount;

    private VisitorRecord(Instant visitTime, int visitCount) {
      this.visitTime = visitTime;
      this.visitCount = visitCount;
    }
  }

  private final Map<String, VisitorRecord> visitorRecordMap = Maps.newHashMap();

  @Nullable
  public VisitorRecord getAndRecordVisit(String name) {
    @Nullable VisitorRecord prevRecord = visitorRecordMap.get(name);
    final VisitorRecord newRecord;
    if (prevRecord == null) {
      // Create a new record.
      newRecord = new VisitorRecord(Instant.now(), 1);
    } else {
      // Create a new record from the previous one.
      newRecord = new VisitorRecord(Instant.now(), prevRecord.visitCount + 1);
    }
    visitorRecordMap.put(name, newRecord);
    return prevRecord;
  }
}
