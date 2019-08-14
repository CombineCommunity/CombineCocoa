# CombineCocoa

<p align="center">
<img src="https://github.com/freak4pc/CombineCocoa/raw/master/Resources/logo.png" width="45%">
<br /><br />
<a href="https://cocoapods.org/pods/CombineCocoa" target="_blank"><img src="https://img.shields.io/cocoapods/v/CombineCocoa.svg?1" alt="CombineCocoa supports CocoaPods"></a>
<a href="https://github.com/apple/swift-package-manager" target="_blank"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="CombineCocoa supports Swift Package Manager (SPM)"></a>
<a href="https://github.com/Carthage/Carthage" target="_blank"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="CombineCocoa supports Carthage"></a>
<br />
<img src="https://img.shields.io/badge/platforms-iOS%2013.0-333333.svg" />
</p>

CombineCocoa attempts to provide publishers for common UIKit controls so you can consume user interaction as Combine emissions and compose them into meaningful, logical publisher chains.

**Note**: This is still a primal version of this, with much more to be desired. I gladly accept PRs, ideas, opinions, or improvements. Thank you ! :)

## Basic Examples

Check out the [Example in the **Example** folder](https://github.com/freak4pc/CombineCocoa/blob/master/Example/Example/ControlsViewController.swift#L27). Open the project in Xcode 11 and Swift Package Manager should automatically resolve the required dependencies.

<p align="center"><img src="https://github.com/freak4pc/CombineCocoa/raw/master/Resources/example.gif"></p>

## Usage

tl;dr: 

```swift
import Combine
import CombineCocoa

textField.textPublisher // AnyPublisher<String, Never>
segmented.selectedSegmentIndexPublisher // AnyPublisher<Int, Never>
slider.valuePublisher // AnyPublisher<Float, Never>
button.tapPublisher // AnyPublisher<Void, Never>
barButtonItem.tapPublisher // AnyPublisher<Void, Never>
swtch.isOnPublisher // AnyPublisher<Bool, Never>
stepper.valuePublisher // AnyPublisher<Double, Never>
datePicker.datePublisher // AnyPublisher<Date, Never>
refreshControl.isRefreshingPublisher // AnyPublisher<Bool, Never>
pageControl.currentPagePublisher // AnyPublisher<Int, Never>
tapGesture.tapPublisher // AnyPublisher<UITapGestureRecognizer, Never>
pinchGesture.pinchPublisher // AnyPublisher<UIPinchGestureRecognizer, Never>
rotationGesture.rotationPublisher // AnyPublisher<UIRotationGestureRecognizer, Never>
swipeGesture.swipePublisher // AnyPublisher<UISwipeGestureRecognizer, Never>
panGesture.panPublisher // AnyPublisher<UIPanGestureRecognizer, Never>
screenEdgePanGesture.screenEdgePanPublisher // AnyPublisher<UIScreenEdgePanGestureRecognizer, Never>
longPressGesture.longPressPublisher // AnyPublisher<UILongPressGestureRecognizer, Never>
scrollView.contentOffsetPublisher // AnyPublisher<CGPoint, Never>
scrollView.reachedBottomPublisher(offset:) // AnyPublisher<Void, Never>
```

## Installation

### CocoaPods

Add the following line to your **Podfile**:

```rb
pod 'CombineCocoa'
```

### Swift Package Manager

Add the following dependency to your **Package.swift** file:

```swift
.package(url: "https://github.com/freak4pc/CombineCocoa.git", from: "0.0.1")
```

### Carthage

Carthage support is offered as a prebuilt binary.

Add the following to your **Cartfile**:

```
github "freak4pc/CombineCocoa"
```

## Future ideas 

* Support non `UIControl.Event`-based publishers (e.g. delegates).
* ... your ideas? :)

## Acknowledgments

* CombineCocoa is highly inspired by RxSwift's [RxCocoa](https://github.com/ReactivXx/RxSwift) in its essence, kudos to [Krunoslav Zaher](https://twitter.com/KrunoslavZaher) for all of his amazing work on this.
* Thanks to [Antoine van der Lee](https://twitter.com/twannl) for his tutorial on [Creating Custom Publishers](https://www.avanderlee.com/swift/custom-combine-publisher/). The idea to set up a control target inside the publisher was inspired by it.

## License

MIT, of course ;-) See the [LICENSE](LICENSE) file. 

The Apple logo and the Combine framework are property of Apple Inc.
