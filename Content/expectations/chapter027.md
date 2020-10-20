---
date: 2020-10-16 00:27
tags: expectation
---

# Waiting For Expectations

## Waiting For A List Of Expectations

```swift
wait(for: [asyncExpectation], timeout: 1)
```

## Waiting For A List Of Expectations Enforcing The Order

```swift
wait(for: [expectation1, expectation2], timeout: 1, enforceOrder: true)
```

## Wait For All Expectations

```swift
waitForExpectations(timeout: 1) { error in
  // completion handler is called on
  // timeout (error != nil or fulfillment
  // (error == nil).
}
```

