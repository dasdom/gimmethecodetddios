---
date: 2020-10-16 00:25
description: Set an expectation that a notification is sent.
tags: expectation
---

# XCTNSNotificationExpectation

Set an expectation that a notification is sent

## Step 1: Test

```swift
func test_settingScore_sendsNotification() {
  // Arrage
  expectation(forNotification: notificationName, object: nil, handler: nil)
  
  // when
  sut.score = 5
  
  // then
  waitForExpectations(timeout: 1, handler: nil)
}
```

## Step 2: Example code that makes the test pass

```swift
class User {
  var score: Int {
    didSet {
      NotificationCenter.default.post(name: notificationName, object: self)
    }
  }
  
  init(score: Int) {
    self.score = score
  }
}

let notificationName = NSNotification.Name("DDHScoreDidChange")
```

