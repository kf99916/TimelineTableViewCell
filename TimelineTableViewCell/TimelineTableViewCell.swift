//
//  TimelineTableViewCell.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/20.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import UIKit


open class TimelineTableViewCell: UITableViewCell {
    
    open var timelinePoint = TimelinePoint()
    
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
    
    open var bubbleRadius = 2.0 {
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
        
        let x = self.layoutMargins.left + lineWidth / 2
        var (startY, endY): (CGFloat, CGFloat) = (0, self.bounds.size.height)
        switch position {
        case .start:
            startY = self.bounds.size.height / 2
        case .end:
            endY = self.bounds.size.height / 2
        default:
            break
        }

        drawLine(start: CGPoint(x: x + pointDiameter / 2, y: startY), end: CGPoint(x: x + pointDiameter / 2, y: endY))
        drawPoint(CGPoint(x:x, y: self.bounds.size.height / 2))
        
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
        
        self.layer.addSublayer(shapeLayer)
    }
    
    fileprivate func drawPoint(_ point:CGPoint) {
        let path = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: pointDiameter, height: pointDiameter))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = pointColor.cgColor
        shapeLayer.fillColor = isPointFilled ? pointColor.cgColor : self.backgroundColor?.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
    }
}
