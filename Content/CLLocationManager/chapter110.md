---
date: 2020-10-16 01:50
description: Test wheather startUpdatingLocation is called.
tags: CLLocationManager
---

# Start Updating Location

Test wheather startUpdatingLocation is called

## Step 1: CLLocationManager Mock

```swift
class LocationManagerMock: CLLocationManager {
  
  var startUpdateLocationCallCount = 0
  
  override func startUpdatingLocation() {
    startUpdateLocationCallCount += 1
  }
}
```

## Step 2: Test

```swift
func test_startUpdatingLocationCallCount() {
  // given
  sut.locationManagerClass = LocationManagerMock.self
  
  // when
  sut.start()
  
  // then
  let locationManager = sut.locationManager
  XCTAssertEqual(locationManager.startUpdateLocationCallCount, 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class LocationProvider<LocationManager: CLLocationManager>: NSObject {
  
  lazy var locationManagerClass : LocationManager.Type = LocationManager.self
  lazy var locationManager: LocationManager = LocationManager()
  
  func start() {
    locationManager.startUpdatingLocation()
  }
}
```

