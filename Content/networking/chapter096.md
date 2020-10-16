---
date: 2020-10-16 10:44
description: Test wheather the method `loadUser` fetches data and calls completion closure.
tags: networking
---

# Mocking and Stubbing with URLProtocol
 
 Test wheather the method `loadUser` fetches data and calls completion closure
 
## Step 0: Prerequisites
 
 Network calls use `URLSession.shared` or it's possible to inject it as a dependency (see **Dependency Injection**)
 
## Step 1: URLProtocol Subclass

```swift
class StubURLProtocol: URLProtocol {
  private static var dataToBeReturned: [URL:Data] = [:]
  private static var errorToBeReturned: Error?
  private static var lastRequest: URLRequest?
  // Test case for expectation management
  private static weak var testCase: XCTestCase?
  // Expectation to wait for asyc call
  private static var expectation: XCTestExpectation?
  
  class func register(for url: URL, with data: Data? = nil, error: Error? = nil, in testCase: XCTestCase) {
    
    if let unwrappedData = data {
      dataToBeReturned[url] = unwrappedData
    }
    
    self.errorToBeReturned = error
    
    StubURLProtocol.testCase = testCase
    // Create expectation
    self.expectation = testCase.expectation(description: "Async")
    
    URLProtocol.registerClass(self.self)
  }
  
  static var lastURL: URL? {
    // Wait for the expectation to be
    testCase?.waitForExpectations(timeout: 5)
    
    // Return url of last request
    return lastRequest?.url
  }
  
  override class func canInit(
    with request: URLRequest) -> Bool {
    
    // Store last request
    StubURLProtocol.lastRequest = request
    return true
  }
  
  override class func canonicalRequest(
    for request: URLRequest) -> URLRequest {
    // Minimal code
    return request
  }
  
  static func waitForAsync() {
    // Wait for the expectation
    testCase?.waitForExpectations(timeout: 5)
  }
  
  override func startLoading() {
    DispatchQueue.main.async {
      // In case of error != nil, return it
      if let error =
        StubURLProtocol.errorToBeReturned {
          self.client?.urlProtocol(self, didFailWithError: error)
      } else {
        // Return the data
        let data = StubURLProtocol.dataToBeReturned[self.request.url!]!
        self.client?.urlProtocol(self, didLoad: data)
        self.client?.urlProtocolDidFinishLoading(self)
      }
      // Fulfill expectation after a delay
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
        StubURLProtocol.expectation?.fulfill()
      })
    }
  }
  
  override func stopLoading() {
    // Minimal code
  }
}
```

 > **Note**: There is an `XCTestExpectation` hidden in `StubURLProtocol`. Therefore in your test, you need to call `StubURLProtocol.lastURL` or `StubURLProtocol.waitForAsync()` **before** you inspect the result.
 
## Step 2: Test Error Case - URLRequest Returns An Error

```swift
  func test_loadUser_errorInCompletionBlock() {
    // given
    let url = URL(string: "http://example.com/user")!
    let error = NSError(domain: "FooError", code: 42, userInfo: nil)
    
    StubURLProtocol.register(for: url, error: error, in: self)
 
    // when
    var result: NSError? = nil
    sut.loadUser { _, error in
      result = error as NSError?
    }
 
    // then
    XCTAssertEqual(StubURLProtocol.lastURL, url)
    XCTAssertEqual(result!, error)
  }
```

## Step 3: Test Error Case - Data Returned Is Not JSON

```swift
  func test_loadUser_errorWhenNotJSON() {
    // given
    let url = URL(string: "http://example.com/user")!
    let data = "1234".data(using: .utf8)
    StubURLProtocol.register(for: url, with: data, in: self)
    
    // when
    var result: NSError! = nil
    sut.loadUser { _, error in
      result = error as NSError?
    }
 
    // then
    XCTAssertEqual(StubURLProtocol.lastURL, url)
    XCTAssertEqual(result.localizedDescription,
                   "The data couldn’t be read because it isn’t in the correct format.")
  }
```

## Step 4: Test - Happy Path

```swift
  func test_loadUser_userInBlock() {
    // given
    let url = URL(string: "http://example.com/user")!
    let data = try! JSONSerialization.data(withJSONObject: ["name":"dasdom"], options: [])
    StubURLProtocol.register(for: url, with: data, in: self)
    
    // when
    var result: User? = nil
    sut.loadUser { user, _ in
      result = user
    }
    
    // then
    XCTAssertEqual(StubURLProtocol.lastURL, url)
    XCTAssertEqual(result, User(name: "dasdom"))
  }
```

## Step 5: Example code that makes the test pass

```swift
class APIClient: NSObject {
  
  func loadUser(completionBlock: @escaping (User?, Error?) -> Void) {
    
    guard let url = URL(string: "http://example.com/user") else {
      fatalError()
    }
    
    URLSession.shared.dataTask(
    with: url) { data, response, error in
      
      if let unwrappedError = error {
        completionBlock(nil, unwrappedError)
      }
      
      guard let data = data else { return }
      DispatchQueue.main.async {
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: [])
          if let userData = json as? [String:String], let userName = userData["name"] {
            
            let user = User(name: userName)
            completionBlock(user, error)
          }
        } catch {
          completionBlock(nil, error)
        }
      }
      }.resume()
  }
}

struct User: Equatable {
  let name: String
}
```

