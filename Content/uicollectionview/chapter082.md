---
date: 2020-10-16 01:22
description:  Test whether a list cell in the collection view compositional list layout is populated with data.
tags: UICollectionViewComposionalLayout
---

# Populate a Custom Collection View Compositional Layout List Cell

Test whether a custom list cell in the collection view compositional list layout is populated with data

## Step 1: Test

```swift
func test_cellForItem_returnsConfiguresCell() {
  // given
  let item = Item(category: .music, title: "Foo", description: "Bar")
  sut.items = [item]
  sut.loadViewIfNeeded()
  
  // when
  let indexPath = IndexPath(item: 0, section: 0)
  let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: indexPath) as! CustomListCell
  
  // then
  let listContentConfiguration = cell.listContentView.configuration as! UIListContentConfiguration
  XCTAssertEqual(listContentConfiguration.text, item.title)
}
```

## Step 2: Example code that lets the test pass

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
private enum Section: Hashable {
  case main
}

struct Category: Hashable {
  let icon: UIImage?
  let name: String?
  
  static let music = Category(icon: UIImage(systemName: "music.mic"), name: "Music")
  static let transportation = Category(icon: UIImage(systemName: "car"), name: "Transportation")
  static let weather = Category(icon: UIImage(systemName: "cloud.rain"), name: "Weather")
}

struct Item: Hashable {
  let category: Category
  let image: UIImage?
  let title: String?
  let description: String?
  
  init(category: Category, imageName: String? = nil, title: String? = nil, description: String? = nil) {
    self.category = category
    if let systemName = imageName {
      self.image = UIImage(systemName: systemName)
    } else {
      self.image = nil
    }
    self.title = title
    self.description = description
  }
}

class CustomCellListViewController: UIViewController {
  
  private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  private(set) var collectionView: UICollectionView!
  lazy var items: [Item] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "List with Custom Cells"
    
    configureHierarchy()
    configureDataSource()
  }
}

extension CustomCellListViewController {
  private func createLayout() -> UICollectionViewLayout {
    let config = UICollectionLayoutListConfiguration(appearance: .plain)
    return UICollectionViewCompositionalLayout.list(using: config)
  }
}

extension CustomCellListViewController {
  private func configureHierarchy() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(collectionView)
  }
  private func configureDataSource() {
    
    let cellRegistration = UICollectionView.CellRegistration<CustomListCell, Item> { (cell, indexPath, item) in
      cell.updateWithItem(item)
      cell.accessories = [.disclosureIndicator()]
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
      
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    }
    
    // initial data
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

// Declare a custom key for a custom `item` property.
fileprivate extension UIConfigurationStateCustomKey {
  static let item = UIConfigurationStateCustomKey("com.apple.ItemListCell.item")
}

// Declare an extension on the cell state struct to provide a typed property for this custom state.
private extension UICellConfigurationState {
  var item: Item? {
    set { self[.item] = newValue }
    get { return self[.item] as? Item }
  }
}

// This list cell subclass is an abstract class with a property that holds the item the cell is displaying,
// which is added to the cell's configuration state for subclasses to use when updating their configuration.
private class ItemListCell: UICollectionViewListCell {
  private var item: Item? = nil
  
  func updateWithItem(_ newItem: Item) {
    guard item != newItem else { return }
    item = newItem
    setNeedsUpdateConfiguration()
  }
  
  override var configurationState: UICellConfigurationState {
    var state = super.configurationState
    state.item = self.item
    return state
  }
}

private class CustomListCell: ItemListCell {
  
  private func defaultListContentConfiguration() -> UIListContentConfiguration {
    return .subtitleCell()
  }
  private(set) lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
  
  private let categoryIconView = UIImageView()
  private let categoryLabel = UILabel()
  private var customViewConstraints: (categoryLabelLeading: NSLayoutConstraint,
                                      categoryLabelTrailing: NSLayoutConstraint,
                                      categoryIconTrailing: NSLayoutConstraint)?
  
  private func setupViewsIfNeeded() {
    // We only need to do anything if we haven't already setup the views and created constraints.
    guard customViewConstraints == nil else { return }
    
    contentView.addSubview(listContentView)
    contentView.addSubview(categoryLabel)
    contentView.addSubview(categoryIconView)
    listContentView.translatesAutoresizingMaskIntoConstraints = false
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false
    categoryIconView.translatesAutoresizingMaskIntoConstraints = false
    let constraints = (
      categoryLabelLeading: categoryLabel.leadingAnchor.constraint(equalTo: listContentView.trailingAnchor),
      categoryLabelTrailing: categoryIconView.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
      categoryIconTrailing: contentView.trailingAnchor.constraint(equalTo: categoryIconView.trailingAnchor)
    )
    NSLayoutConstraint.activate([
      listContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
      listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      categoryIconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      constraints.categoryLabelLeading,
      constraints.categoryLabelTrailing,
      constraints.categoryIconTrailing
    ])
    customViewConstraints = constraints
  }
  
  override func updateConfiguration(using state: UICellConfigurationState) {
    setupViewsIfNeeded()
    
    // Configure the list content configuration and apply that to the list content view.
    var content = defaultListContentConfiguration().updated(for: state)
    content.imageProperties.preferredSymbolConfiguration = .init(font: content.textProperties.font, scale: .large)
    content.image = state.item?.image
    content.text = state.item?.title
    content.secondaryText = state.item?.description
    content.axesPreservingSuperviewLayoutMargins = []
    listContentView.configuration = content
    
    // Get the list value cell configuration for the current state, which we'll use to obtain the system default
    // styling and metrics to copy to our custom views.
    let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)
    
    // Configure custom image view for the category icon, copying some of the styling from the value cell configuration.
    categoryIconView.image = state.item?.category.icon
    categoryIconView.tintColor = valueConfiguration.imageProperties.resolvedTintColor(for: tintColor)
    categoryIconView.preferredSymbolConfiguration = .init(font: valueConfiguration.secondaryTextProperties.font, scale: .small)
    
    // Configure custom label for the category name, copying some of the styling from the value cell configuration.
    categoryLabel.text = state.item?.category.name
    categoryLabel.textColor = valueConfiguration.secondaryTextProperties.resolvedColor()
    categoryLabel.font = valueConfiguration.secondaryTextProperties.font
    categoryLabel.adjustsFontForContentSizeCategory = valueConfiguration.secondaryTextProperties.adjustsFontForContentSizeCategory
    
    // Update some of the constraints for our custom views using the system default metrics from the configurations.
    customViewConstraints?.categoryLabelLeading.constant = content.directionalLayoutMargins.trailing
    customViewConstraints?.categoryLabelTrailing.constant = valueConfiguration.textToSecondaryTextHorizontalPadding
    customViewConstraints?.categoryIconTrailing.constant = content.directionalLayoutMargins.trailing
  }
}
```

