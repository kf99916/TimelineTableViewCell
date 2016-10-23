# TimelineTableViewCell

TimelineTableViewCell is a simple timeline view implemented by UITableViewCell written in Swift 3.0. The UI design of TimelineTableViewCell is inspired by [ISTimeline](https://github.com/instant-solutions/ISTimeline).

[![Language Swift 3.0](https://img.shields.io/badge/Language-Swift%203.0-orange.svg?style=flat)](https://swift.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/TimelineTableViewCell.svg)](#cocoapods)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/github/license/kf99916/TimelineTableViewCell.svg)](LICENSE)

![TimelineTableViewCell](/screenshots/timelineTableView.png "TimelineTableViewCell")

## Requirements

- iOS 8.0 or higher
- Swift 3.0

## Installation

- [CocoaPods](http://cocoapods.org/):

```ruby
pod "TimelineTableViewCell"
```

- [Swift Package Manager](https://swift.org/package-manager/):

```
.Package(url: "https://github.com/kf99916/TimelineTableViewCell.git", majorVersion: 1.0)
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
`var color: UIColor` the color of each point in the line (defalut `UIColor.black`)  
`var isFilled: Bool` fills the point in the line (default: `false`)

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
`thumbnailImageView: thumbnailImageView!` the thumbnail  
`var bubbleRadius: CGFloat` the radius of the bubble corners (default `2.0`)  
`var bubbleColor: UIColor` the color of every bubble (default `.init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)`)

## Demo

TimelineTableViewCellDemo is a simple demo app which shows the usage of TimelineTableViewCell in a storyboard.

## Author

Zheng-Xiang Ke, kf99916@gmail.com

## License

TimelineTableViewCell is available under the MIT license. See the LICENSE file for more info.
