# TimelineTableViewCell

TimelineTableViewCell is a simple timeline view implemented by UITableViewCell. The UI design of TimelineTableViewCell is inspired by [ISTimeline](https://github.com/instant-solutions/ISTimeline).

[![GitHub stars](https://img.shields.io/github/stars/kf99916/TimelineTableViewCell.svg)](https://github.com/kf99916/TimelineTableViewCell/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/kf99916/TimelineTableViewCell.svg)](https://github.com/kf99916/TimelineTableViewCell/network)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/TimelineTableViewCell.svg)](https://cocoapods.org/pods/TimelineTableViewCell)
[![Platform](https://img.shields.io/cocoapods/p/TimelineTableViewCell.svg)](https://github.com/kf99916/TimelineTableViewCell)
[![GitHub license](https://img.shields.io/github/license/kf99916/TimelineTableViewCell.svg)](https://github.com/kf99916/TimelineTableViewCell/blob/master/LICENSE)

![TimelineTableViewCell](/screenshots/timelineTableView.png 'TimelineTableViewCell')
![TimelineTableViewCell](/screenshots/timelineTableView-2.png 'TimelineTableViewCell')

## Requirements

- iOS 9.0 or higher

### v1.0.1-

- Swift 3

### v1.2-

- Swift 4

### v1.3

- Swift 5

### v2.0+

- Breaking Changes for v1.3-: thumbnailImageView is replaced with UIStackView to support multiple thumbnails.
- Do not support iOS9.0- anymore.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding TimelineTableViewCell as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/kf99916/TimelineTableViewCell.git")
]
```

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate TimelineTableViewCell into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'TimelineTableViewCell'
```

## Usage

### Import

```swift
import TimelineTableViewCell
```

### Integration

#### Register Nib

```swift
let bundle = Bundle(for: TimelineTableViewCell.self)
let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell",
	bundle: Bundle(url: nibUrl!)!)
tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
```

#### Dequeue

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell",
	for: indexPath) as! TimelineTableViewCell

// Configure TimelineTableViewCell...
```

### TimelinePoint

The point in line is represented by a TimelinePoint object.  
`var diameter: CGFloat` the diameter of a point in the line (default `6.0`)  
`var lineWidth: CGFloat` the thickness of the point (default `2.0`)  
`var color: UIColor` the color of each point in the line (default `UIColor.black`)  
`var isFilled: Bool` fills the point in the line (default `false`)

#### Initializers

```swift
TimelinePoint(diameter: CGFloat, lineWidth: CGFloat, color: UIColor, filled: Bool)
```

```swift
TimelinePoint(diameter: CGFloat, color: UIColor, filled: Bool)
```

```swift
TimelinePoint(color: UIColor, filled: Bool)
```

```swift
TimelinePoint()
```

### Timeline

The line in the cell is represented by a Timeline object and is divided by the point as the front line and the backline.  
`var width: CGFloat` the thickness of the line (default `2.0`)  
`var frontColor: UIColor` the color of the front line (defalut `UIColor.black`)  
`var backColor: UIColor` the color of the back line (defalut `UIColor.black`)  
`var leftMargin: CGFloat` the left margin of the line (default `60.0`)

#### Initializers

```swift
Timeline(width: CGFloat, frontColor: UIColor, backColor: UIColor)
```

```swift
Timeline(frontColor: UIColor, backColor: UIColor)
```

```swift
Timeline()
```

### TimelineTableViewCell

The cell is represented by a TimelineTableViewCell object.  
`titleLabel: UILabel!` the title in the bubble  
`descriptionLabel: UILabel!` the description  
`lineInfoLabel: UILabel!` the information about line  
`thumbnailImageView: UIImageView!` the thumbnail
`illustrationImageView: UIImageView!` the illustration  
`var bubbleRadius: CGFloat` the radius of the bubble corners (default `2.0`)  
`var bubbleColor: UIColor` the color of every bubble (default `.init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)`)
`viewsInStackView: [UIView]` the views in the stack view.
`var bubbleEnabled: Bool` Enable draw bubble (default `true`)

## Apps using TimelineTableViewCell

If you are using TimelineTableViewCell in your app and want to be listed here, simply create a pull request.

I am always curious who is using my projects :)

[Hikingbook](https://itunes.apple.com/app/id1067838748) - by Zheng-Xiang Ke

![Hikingbook](apps/Hikingbook.png)

## Demo

TimelineTableViewCellDemo is a simple demo app which shows the usage of TimelineTableViewCell in a storyboard.

## Author

Zheng-Xiang Ke, kf99916@gmail.com

## License

TimelineTableViewCell is available under the MIT license. See the LICENSE file for more info.
