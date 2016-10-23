//
//  Timeline.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/21.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation

public struct Timeline {
    internal var (start, end) = (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0))
    
    public enum TimelineType {
        case start, middle, end
    }
    
    public var type: TimelineType = .middle
    
    public var width: CGFloat = 2.0 {
        didSet {
            if (width < 0.0) {
                width = 0.0
            } else if(width > 20.0) {
                width = 20.0
            }
        }
    }
    
    internal var leftMargin: CGFloat = 50.0
    
    public var color = UIColor.black
    
    public func draw(view: UIView) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        
        view.layer.addSublayer(shapeLayer)
    }
}
