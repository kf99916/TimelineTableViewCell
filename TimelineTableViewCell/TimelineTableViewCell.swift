//
//  TimelineTableViewCell.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/20.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import UIKit


open class TimelineTableViewCell: UITableViewCell {
    
    open var timelinePoint: TimelinePoint?
    
    open var pointDiameter: CGFloat = 6.0 {
        didSet {
            if (pointDiameter < 0.0) {
                pointDiameter = 0.0
            } else if (pointDiameter > 100.0) {
                pointDiameter = 100.0
            }
        }
    }
    
    open var lineWidth: CGFloat = 2.0 {
        didSet {
            if (lineWidth < 0.0) {
                lineWidth = 0.0
            } else if(lineWidth > 20.0) {
                lineWidth = 20.0
            }
        }
    }
    
    open var lineLeft: CGFloat = 50.0 {
        didSet {
            if (lineLeft < 0.0) {
                lineLeft = 0.0
            } else if (lineLeft > 100.0) {
                lineLeft = 100.0
            }
        }
    }
    
    open var bubbleRadius: CGFloat = 2.0 {
        didSet {
            if (bubbleRadius < 0.0) {
                bubbleRadius = 0.0
            } else if (bubbleRadius > 6.0) {
                bubbleRadius = 6.0
            }
        }
    }
    
    open var (pointColor, bubbleColor, titleColor, descriptionColor, lineColor) = (UIColor.black, UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0), UIColor.white, UIColor.gray, UIColor.black)

    open var isPointFilled = false
    
    open var position = Position.middle
    
    fileprivate static let gap: CGFloat = 15.0
    
    public enum Position {
        case start, middle, end
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override open func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        let point = CGPoint(x: self.layoutMargins.left + lineLeft + lineWidth / 2, y: self.bounds.size.height / 4)
        var (startY, endY): (CGFloat, CGFloat) = (0, self.bounds.size.height)
        switch position {
        case .start:
            startY = point.y
        case .end:
            endY = point.y
        default:
            break
        }

        let start = CGPoint(x: point.x + pointDiameter / 2, y: startY)
        let end = CGPoint(x: point.x + pointDiameter / 2, y: endY)
        drawLine(start: start, end: end)
        drawLineInfo(point: point)
        drawPoint(point)
        if let bubbleRect = drawBubble(point: point) {
            drawDescription(bubbleRect: bubbleRect)
            drawImage(bubbleRect: bubbleRect)
        }
        
        context?.restoreGState()
    }
    
    fileprivate func drawLine(start: CGPoint, end: CGPoint) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.contentView.layer.addSublayer(shapeLayer)
    }
    
    fileprivate func drawLineInfo(point: CGPoint) {
        guard let lineInfo = timelinePoint?.lineInfo else {
            return
        }
        
        let offset: CGFloat = 5
        let lineInfoLabel = UILabel()
        lineInfoLabel.text = lineInfo
        lineInfoLabel.font = UIFont.systemFont(ofSize: 8.0)
        lineInfoLabel.textColor = lineColor
        lineInfoLabel.lineBreakMode = .byWordWrapping
        lineInfoLabel.numberOfLines = 0
        lineInfoLabel.textAlignment = .center
        lineInfoLabel.sizeToFit()
        lineInfoLabel.center = CGPoint(x: self.layoutMargins.left + lineLeft - lineInfoLabel.frame.width / 2 - offset, y: point.y * 3)
        self.contentView.addSubview(lineInfoLabel)
    }
    
    fileprivate func drawPoint(_ point: CGPoint) {
        if timelinePoint == nil {
            return
        }
        
        let path = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: pointDiameter, height: pointDiameter))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = pointColor.cgColor
        shapeLayer.fillColor = isPointFilled ? pointColor.cgColor : self.backgroundColor?.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.contentView.layer.addSublayer(shapeLayer)
    }
    
    fileprivate func drawBubble(point: CGPoint) -> CGRect? {
        guard let timelinePoint = timelinePoint else {
            return nil
        }
        
        let titleLabel = UILabel()
        titleLabel.text = timelinePoint.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.preferredMaxLayoutWidth = calcWidth()
        
        let maxTitleWidth = calcWidth()
        var titleWidth = titleLabel.intrinsicContentSize.width + 20
        if (titleWidth > maxTitleWidth) {
            titleWidth = maxTitleWidth
        }
        
        let offset: CGFloat = 13
        let bubbleRect = CGRect(
            x: point.x + pointDiameter + lineWidth / 2 + offset,
            y: point.y - pointDiameter - titleLabel.intrinsicContentSize.height / 2,
            width: titleWidth,
            height: titleLabel.intrinsicContentSize.height + TimelineTableViewCell.gap)
        
        let path = UIBezierPath(roundedRect: bubbleRect, cornerRadius: bubbleRadius)
        let startPoint = CGPoint(x: bubbleRect.origin.x, y: bubbleRect.origin.y + bubbleRect.height / 2 - 8)
        path.move(to: startPoint)
        path.addLine(to: startPoint)
        path.addLine(to: CGPoint(x: bubbleRect.origin.x - 8, y: bubbleRect.origin.y + bubbleRect.height / 2))
        path.addLine(to: CGPoint(x: bubbleRect.origin.x, y: bubbleRect.origin.y + bubbleRect.height / 2 + 8))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = bubbleColor.cgColor
        
        self.contentView.layer.addSublayer(shapeLayer)
        
        let titleRect = CGRect(x: bubbleRect.origin.x + 10, y: bubbleRect.origin.y, width: bubbleRect.size.width - 15, height: bubbleRect.size.height - 1)
        titleLabel.textColor = titleColor
        titleLabel.frame = titleRect
        self.contentView.addSubview(titleLabel)
        
        return bubbleRect
    }
    
    fileprivate func drawDescription(bubbleRect: CGRect) {
        guard let description = timelinePoint?.description else {
            return
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 10.0)
        descriptionLabel.textColor = descriptionColor
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.preferredMaxLayoutWidth = calcWidth()
        
        descriptionLabel.frame = CGRect(
            x: bubbleRect.origin.x,
            y: bubbleRect.origin.y + bubbleRect.height + 3,
            width: calcWidth(),
            height: descriptionLabel.intrinsicContentSize.height)
        self.contentView.addSubview(descriptionLabel)
    }
    
    fileprivate func drawImage(bubbleRect: CGRect) {
        guard let image = timelinePoint?.image else {
            return
        }
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(
            x: bubbleRect.origin.x + bubbleRect.size.width + 20,
            y: bubbleRect.origin.y,
            width: bubbleRect.size.height,
            height: bubbleRect.size.height)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)
    }
    
    fileprivate func calcWidth() -> CGFloat {
        return self.bounds.width - (self.layoutMargins.left + self.layoutMargins.right) - lineLeft - pointDiameter - lineWidth - TimelineTableViewCell.gap * 1.5
    }
}
