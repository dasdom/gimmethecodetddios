---
date: 2020-10-16 01:47
description: Test whether requestWhenInUseAuthorization is called.
tags: CLLocationManager
---

# CLLocationManager Delegate

Test whether the delegate of the location manager is set

## Step 1: Test

```swift
func test_locationManagerDelegate_isSet() {
  // when
  sut.setup()
  
  // then
  XCTAssertEqual(sut.locationManager!.delegate as? LocationProvider, sut)
}
```

## Step 2: Example code that makes the test pass

```swift
class LocationProvider: NSObject, CLLocationManagerDelegate {
  
  var locationManager: CLLocationManager? = nil
  
  func setup() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager?.delegate = self
    }
  }
}
```

