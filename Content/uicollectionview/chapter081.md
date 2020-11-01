---
date: 2020-10-16 01:21
description:  Test whether a list cell in the collection view compositional list layout is populated with data.
tags: UICollectionViewComposionalLayout
---

# Populate a Collection View Compositional Layout List Cell

Test whether a list cell in the collection view compositional list layout is populated with data

## Step 1: Test

```swift
func test_cellForItem_returnsPopulatedCell() {
  // given
  sut.names = ["foobar"]
  let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
  window.rootViewController = sut
  window.makeKeyAndVisible()
  
  // when
  let indexPath = IndexPath(item: 0, section: 0)
  let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: indexPath) as! UICollectionViewListCell

  // then
  let contentConfiguration = cell.contentConfiguration as! UIListContentConfiguration
  XCTAssertEqual(contentConfiguration.text, sut.names.first)
}
```

## Step 2: Example code that makes the test pass

This code is taken from the sample project provided by Apple for the WWDC20.

Licence:

> Apple, iPhone, iMac, iPad Pro, Apple Pencil, Apple Watch, App Store, TestFlight, Siri, and SiriKit are trademarks of Apple, Inc.
>
> The following license applies to the source code, and other elements of this package:
>
> Copyright © 2020 Apple Inc.
> Changes by Dominik Hauser (@dasdom).
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

```swift
class SimpleListViewController: UIViewController {
  
  enum Section {
    case main
  }
  
  var dataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
  var collectionView: UICollectionView! = nil
  var names: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "List"
    
    configureHierarchy()
    configureDataSource()
  }
}

extension SimpleListViewController {
  private func createLayout() -> UICollectionViewLayout {
    let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    return UICollectionViewCompositionalLayout.list(using: config)
  }
}

extension SimpleListViewController {
  private func configureHierarchy() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(collectionView)
  }
  
  private func configureDataSource() {
    
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, item) in
      var content = cell.defaultContentConfiguration()
      content.text = item
      cell.contentConfiguration = content
      }
    
    dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, name: String) -> UICollectionViewCell? in
      
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: name)
    }
    
    // initial data
    var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
    snapshot.appendSections([.main])
    snapshot.appendItems(names)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}
```

