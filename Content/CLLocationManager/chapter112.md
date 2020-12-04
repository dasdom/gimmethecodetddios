---
date: 2020-10-16 01:52
description: Test wheather requestLocation is called.
tags: CLLocationManager
---

# Request Location

Test wheather requestLocation is called

## Step 1: CLLocationManager Mock

```swift
class LocationManagerMock: CLLocationManager {
  
  var requestLocationCallCount = 0
  
  override func requestLocation() {
    requestLocationCallCount += 1
  }
}
```

## Step 2: Test

```swift
func test_requestLocationCallCount() {
  // given
  sut.locationManagerClass = LocationManagerMock.self
  sut.setup()
  
  // when
  sut.fetchLocation()
  
  // then
  let locationManager = sut.locationManager
  XCTAssertEqual(locationManager.requestLocationCallCount, 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class LocationProvider<LocationManager: CLLocationManager>: NSObject {
  
  lazy var locationManagerClass : LocationManager.Type = LocationManager.self
  lazy var locationManager: LocationManager = LocationManager()
  
  func setup() {
    if LocationManager.locationServicesEnabled() {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func fetchLocation() {
    locationManager.requestLocation()
  }
}
```

