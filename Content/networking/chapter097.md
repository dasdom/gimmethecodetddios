---
date: 2020-10-16 10:43
description: Test wheather the method `loadUser` fetches data and calls completion closure.
tags: networking
---

# Mocking and Stubbing a Data Task with URLSession

 Test wheather the method `loadUser` fetches data and calls completion closure
 
## Step 0: Prerequisites

Possibility to inject the url session as a dependency (see **Dependency Injection**)
 
## Step 0: Protocol

```swift
protocol DDHURLSessionProtocol {
  func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: DDHURLSessionProtocol {}
```

## Step 1.1: URLSession Stub

```swift
class StubURLSession: DDHURLSessionProtocol {
  
  private var url: URL?
  private let dataTask: StubURLSessionDataTask
  
  init(data: Data?, urlResponse: URLResponse?, error: Error?, testCase: XCTestCase) {
    
    dataTask = StubURLSessionDataTask(data: data, urlResponse: urlResponse, error: error, testCase: testCase)
  }
  
  func waitForAsync() {
    dataTask.testCase.waitForExpectations(timeout: 5)
  }
  
  var lastURL: URL? {
    dataTask.testCase.waitForExpectations(timeout: 5)
    
    return url
  }
  
  func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    
    self.url = url
    dataTask.completionHandler = completionHandler
    return dataTask
  }
}
```

## Step 1.2: URLSessionDataTask Stub

```swift
class StubURLSessionDataTask: URLSessionDataTask {
  
  private let data: Data?
  private let urlResponse: URLResponse?
  private let responseError: Error?
  let testCase: XCTestCase
  private let expectation: XCTestExpectation
  
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
  var completionHandler: CompletionHandler?
  
  init(data: Data?, urlResponse: URLResponse?, error: Error?, testCase: XCTestCase) {
    
    self.data = data
    self.urlResponse = urlResponse
    self.responseError = error
    self.testCase = testCase
    self.expectation = testCase.expectation(description: "Async")
  }
  
  override func resume() {
    DispatchQueue.main.async {
      self.completionHandler?(self.data, self.urlResponse, self.responseError)
      
      // Fulfill expectation after a delay
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
        self.expectation.fulfill()
      })
    }
  }
}
```

## Step 2: Test Error Case - URLRequest Returns An Error

```swift
  func test_loadUser_errorInCompletionBlock() {
    // given
    let error = NSError(domain: "FooError", code: 42, userInfo: nil)
    let stubSession = StubURLSession(data: nil, urlResponse: nil, error: error, testCase: self)
    sut.session = stubSession
    
    // when
    var result: NSError? = nil
    sut.loadUser { _, error in
      result = error as NSError?
    }
    
    // then
    XCTAssertEqual(stubSession.lastURL, URL(string: "http://example.com/user"))
    XCTAssertEqual(result!, error)
  }
```

## Step 3: Test Error Case - Data Returned Is Not JSON

```swift
  func test_loadUser_errorWhenNotJSON() {
    // given
    let data = "1234".data(using: .utf8)
    let stubSession = StubURLSession(data: data, urlResponse: nil, error: nil, testCase: self
    )
    sut.session = stubSession
    
    // when
    var result: NSError! = nil
    sut.loadUser { _, error in
      result = error as NSError?
    }
    
    // then
    XCTAssertEqual(stubSession.lastURL, URL(string: "http://example.com/user"))
    XCTAssertEqual(result.localizedDescription,
                   "The data couldn’t be read because it isn’t in the correct format.")
  }
```

## Step 4: Test The Happy Path

```swift
  func test_loadUser_userInBlock() {
    // given
    let data = try! JSONSerialization.data(withJSONObject: ["name":"dasdom"], options: [])
    let stubSession = StubURLSession(data: data, urlResponse: nil, error: nil, testCase: self)
    sut.session = stubSession
    
    // when
    var result: User? = nil
    sut.loadUser { user, _ in
      result = user
    }
    
    // then
    XCTAssertEqual(stubSession.lastURL, URL(string: "http://example.com/user"))
    XCTAssertEqual(result, User(name: "dasdom"))
  }
```

## Step 5: Example code that makes the test pass

```swift
class APIClient: NSObject {
  
  lazy var session: DDHURLSessionProtocol? = URLSession.shared
  
  func loadUser(completionBlock: @escaping (User?, Error?) -> Void) {
    guard let url = URL(string: "http://example.com/user") else {
      fatalError()
    }
    
    session?.dataTask(
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

