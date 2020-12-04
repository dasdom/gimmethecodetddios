---
date: 2020-10-16 01:49
description: Test whether the desiredAccuracy of the location manager is set.
tags: CLLocationManager
---

# CLLocationManager desiredAccuracy

Test whether the desiredAccuracy of the location manager is set

## Step 1: Test

```swift
func test_locationManagerDistanceFilter_isSet() {
  // when
  sut.setup()
  
  // then
  let desiredAccuracy: Double = sut.locationManager!.desiredAccuracy
  XCTAssertEqual(desiredAccuracy, 5.0, accuracy: 0.1)
}
```

## Step 2: Example code that makes the test pass

```swift
class LocationProvider: NSObject, CLLocationManagerDelegate {
  
  var locationManager: CLLocationManager? = nil
  
  func setup() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager?.desiredAccuracy = 5
    }
  }
}
```

