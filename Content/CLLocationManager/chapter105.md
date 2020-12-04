---
date: 2020-10-16 01:45
description: Test whether the NSLocationWhenInUseUsageDescription is added to the Info.plist.
tags: CLLocationManager
---

# NSLocationWhenInUseUsageDescription

Test whether the NSLocationWhenInUseUsageDescription is added to the Info.plist

## Step 1: Test

```swift
class LocationWhenInUseUsageDescriptionTests: XCTestCase {
  
  func test_WhenInUseUsageDescription() {
    // then
    let key = "NSLocationWhenInUseUsageDescription"
    let description = Bundle.main.infoDictionary![key] as! String
    XCTAssertGreaterThan(description.count, 10)
  }
}
```

