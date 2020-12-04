---
date: 2020-10-16 01:48
description: Test whether the distance filter of the location manager is set.
tags: CLLocationManager
---

# CLLocationManager distanceFilter

Test whether the distance filter of the location manager is set

## Step 1: Test

```swift
func test_locationManagerDistanceFilter_isSet() {
  // when
  sut.setup()
  
  // then
  let distanceFilter: Double = sut.locationManager!.distanceFilter
  XCTAssertEqual(distanceFilter, 50.0, accuracy: 0.1)
}
```

## Step 2: Example code that makes the test pass

```swift
class LocationProvider: NSObject, CLLocationManagerDelegate {
  
  var locationManager: CLLocationManager? = nil
  
  func setup() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager?.distanceFilter = 50
    }
  }
}
```

