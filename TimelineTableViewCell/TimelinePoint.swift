//
//  TimelinePoint.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/20.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation

public struct TimelinePoint {
    internal var position = CGPoint(x: 0, y: 0)
    
    public var diameter: CGFloat = 6.0 {
        didSet {
            if (diameter < 0.0) {
                diameter = 0.0
            } else if (diameter > 100.0) {
                diameter = 100.0
            }
        }
    }
    
    public var lineWidth: CGFloat = 2.0 {
        didSet {
            if (lineWidth < 0.0) {
                lineWidth = 0.0
            } else if(lineWidth > 20.0) {
                lineWidth = 20.0
            }
        }
    }
    
    public var color = UIColor.black
    
    public var isFilled = false
    
    public func draw(view: UIView) {
        let path = UIBezierPath(ovalIn: CGRect(x: position.x, y: position.y, width: diameter, height: diameter))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = isFilled ? color.cgColor : UIColor.white.cgColor
        shapeLayer.lineWidth = lineWidth

        view.layer.addSublayer(shapeLayer)
    }
}
