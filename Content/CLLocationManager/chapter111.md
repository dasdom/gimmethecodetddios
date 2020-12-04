---
date: 2020-10-16 01:51
description: Test wheather stopUpdatingLocation is called.
tags: CLLocationManager
---

# Stop Updating Location

Test wheather stopUpdatingLocation is called

## Step 1: CLLocationManager Mock

```swift
class LocationManagerMock: CLLocationManager {
  
  var stopUpdateLocationCallCount = 0
  
  override func stopUpdatingLocation() {
    stopUpdateLocationCallCount += 1
  }
}
```

## Step 2: Test

```swift
func test_startUpdatingLocationCallCount() {
  // given
  sut.locationManagerClass = LocationManagerMock.self
  
  // when
  sut.stop()
  
  // then
  let locationManager = sut.locationManager
  XCTAssertEqual(locationManager.stopUpdateLocationCallCount, 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class LocationProvider<LocationManager: CLLocationManager>: NSObject {
  
  lazy var locationManagerClass : LocationManager.Type = LocationManager.self
  lazy var locationManager: LocationManager = LocationManager()
  
  func stop() {
    locationManager.stopUpdatingLocation()
  }
}
```

