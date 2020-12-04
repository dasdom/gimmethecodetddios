---
date: 2020-10-16 01:44
description: Test wheather location services is enabled.
tags: CLLocationManager
---

# Location Services Enabled

Test wheather location services is enabled

## Step 1: CLLocationManager Mock

```swift
class LocationManagerMock: CLLocationManager {
  
  static var locationServicesEnabledCallCount = 0
  
  override class func locationServicesEnabled() -> Bool {
    locationServicesEnabledCallCount += 1
    return true
  }
}
```

## Step 2: Test

```swift
func test_locationServicesEnabledCallCount() {
  // given
  sut.locationManagerClass = LocationManagerMock.self
  
  // when
  sut.setup()
  
  // then
  XCTAssertEqual(LocationManagerMock.locationServicesEnabledCallCount, 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class LocationProvider<LocationManager: CLLocationManager>: NSObject {
  
  lazy var locationManagerClass: LocationManager.Type = LocationManager.self
  
  func setup() {
    LocationManager.locationServicesEnabled()
  }
}
```

> In the same way you can test the calls of `deferredLocationUpdatesAvailable()`, `significantLocationChangeMonitoringAvailable()`, `headingAvailable()`, `isMonitoringAvailable(for:)`, `isRangingAvailable()`.
