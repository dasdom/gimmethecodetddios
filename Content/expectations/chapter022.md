---
date: 2020-10-16 00:22
description: Set an expectation and wait unitl it's fulfilled.
tags: expectation
---

# XCTestExpectation

Set an expectation and wait unitl it's fulfilled

## Step 1: Test

Wait for a list of expectations.

```swift
  func test_asynTask_waitForList() {
    // given
    let asyncExpectation = expectation(description: "async")
    
    // when
    var result: Bool? = nil
    sut.asyncTask { success in
      result = success
      asyncExpectation.fulfill()
    }
    
    // then
    wait(for: [asyncExpectation], timeout: 1)
    XCTAssertTrue(result ?? false)
  }
```

Wait for all set expectations.

```swift
  func test_asynTask_waitForAll() {
    // given
    let asyncExpectation = expectation(description: "async")
    
    // when
    var result: Bool? = nil
    sut.asyncTask { success in
      result = success
      asyncExpectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 1) { error in
      // completion handler is called on
      // timeout (error != nil or fulfillment
      // (error == nil).
    }
    XCTAssertTrue(result ?? false)
  }
```

## Step 2: Example code that makes the test green

```swift
struct Worker {
  
  func asyncTask(completion: @escaping (Bool) -> Void) {
    
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
      completion(true)
    }
  }
}
```

