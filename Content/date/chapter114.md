---
date: 2020-10-16 01:54
description: Test whether date filtering of events works.
tags: Date
---

# Filter Events

Test whether date filtering of events works

## Step 1: Dummy Data

```swift
func dummyEvents(dateStrings: [String]) -> [Event] {
    
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
  
  return dateStrings.map {
    dateString -> Event in
    
    let date = dateFormatter.date(from: dateString)!
    
    return Event(title: dateString, startDate: date)
    
  }
}
```

## Step 2: Test

```swift
func test_filterFutureEvents() {
  // given
  let dateStrings = ["2019-04-20 11:23",
                     "2019-04-21 14:01",
                     "2019-04-24 10:44"]
  sut.events = dummyEvents(dateStrings: dateStrings)
  
  // when
  let filteredEvents = sut.futureEvents()
  
  // then
  XCTAssertEqual(filteredEvents.count, 2)
  XCTAssertEqual(filteredEvents[0].title, "2019-04-21 14:01")
  XCTAssertEqual(filteredEvents[1].title, "2019-04-24 10:44")
}
```

## Step 3: Example code that makes the test pass

```swift
class EventsProvider {
  var events: [Event] = []
  
  func futureEvents(for date: Date = Date()) -> [Event] {
    return events.filter { event in
      return event.startDate > date
    }
  }
}

struct Event {
  let title: String
  let startDate: Date
}
```

