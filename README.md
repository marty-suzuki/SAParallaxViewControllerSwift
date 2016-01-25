# SAParallaxViewControllerSwift

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Version](https://img.shields.io/cocoapods/v/SAParallaxViewControllerSwift.svg?style=flat)](http://cocoadocs.org/docsets/MSAlertController)

![](./SampleImage/sample.gif) ![](./SampleImage/open_sample.gif)

SAParallaxViewControllerSwift realizes parallax scrolling with blur effect. In addition, it realizes seamless opening transition.

## Features

- [x] Parallax scrolling
- [x] Parallax scrolling with blur accessory view
- [x] Seamlees opening transition

## Installation

#### CocoaPods

SAParallaxViewControllerSwift is available through [CocoaPods](http://cocoapods.org). If you have cocoapods 0.36 beta or greater, you can install
it, simply add the following line to your Podfile:

    pod "SAParallaxViewControllerSwift"

#### Manually

Add the [SAParallaxViewControllerSwift](./SAParallaxViewControllerSwift) directory to your project.

## Usage

If you install from cocoapods, You have to white `import SAParallaxViewControllerSwift`.

Extend `SAParallaxViewController` like this.

```swift
class ViewController: SAParallaxViewController {
    override init() {
        super.init()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

If you want to use `UICollectionViewDataSource`, implement extension like this. You can set image with `cell.setImage()`. You can add some UIView member classes to `cell.containerView.accessoryView`.

```swift
extension ViewController: UICollectionViewDataSource {
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as SAParallaxViewCell

        let index = indexPath.row % 6
        let imageName = String(format: "image%d", index + 1)
        if let image = UIImage(named: imageName) {
            cell.setImage(image)
        }
        let title = ["Girl with Room", "Beautiful sky", "Music Festival", "Fashion show", "Beautiful beach", "Pizza and beer"]
        let label = UILabel(frame: cell.containerView.accessoryView.bounds)
        label.textAlignment = .Center
        label.text = title[index]
        label.textColor = .whiteColor()
        label.font = .systemFontOfSize(30)
        cell.containerView.accessoryView.addSubview(label)

        return cell
    }
}
```

If you want to use `UICollectionViewDelegate`, implement extension like this.

You must copy `cell.containerView` to `viewController.trantisionContainerView` because to use opening transition. When you copy them, use `containerView.setViews(cells: cells, view: view)`. Set `viewController.transitioningDelegate` as self, finally call `self.presentViewController()`.

```swift
extension ViewController: UICollectionViewDelegate {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        super.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)

        if let cells = collectionView.visibleCells() as? [SAParallaxViewCell] {
            let containerView = SATransitionContainerView(frame: view.bounds)
            containerView.setViews(cells: cells, view: view)

            let viewController = DetailViewController()
            viewController.transitioningDelegate = self
            viewController.trantisionContainerView = containerView

            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }
}
```

Extend `SADetailViewController` like this.

`SADetailViewController` is detail view controller for parallax cell.

```swift
class DetailViewController: SADetailViewController {
    override init() {
        super.init()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

## Customize

You can change parallax start position with function of `cell.containerView`.

```swift
func setParallaxStartPosition(#y: CGFloat)
```

You can change height of `cell.containerView.accessoryView`.

```swift
func setAccessoryViewHeight(height: CGFloat)
```

You can change blur size of `cell.containerView.accessoryView`.

```swift  
func setBlurSize(size: CGFloat)
```

You can change blur color of `cell.containerView.accessoryView`.

```swift
func setBlurColor(color: UIColor)
```

You can change blur color alpha of `cell.containerView.accessoryView`.

```swift  
func setBlurColorAlpha(alpha: CGFloat)
```

## Requirements

- Xcode 7.0 or greater
- iOS 8.0 or greater
- ARC
- [SABlurImageView](https://github.com/szk-atmosphere/SABlurImageView)
- [MisterFusion](https://github.com/szk-atmosphere/MisterFusion)

## Author

Taiki Suzuki, s1180183@gmail.com

## License

SAParallaxViewControllerSwift is available under the MIT license. See the LICENSE file for more info.
