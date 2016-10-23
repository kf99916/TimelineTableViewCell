//
//  Timeline.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/21.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation

public struct Timeline {
    internal var (start, middle, end) = (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0))
    
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
    
    public var (frontColor, backColor) = (UIColor.clear, UIColor.black)
    
    public func draw(view: UIView) {
        draw(view: view, from: start, to: middle, color: frontColor)
        draw(view: view, from: middle, to: end, color: backColor)
    }
    
    fileprivate func draw(view: UIView, from: CGPoint, to: CGPoint, color: UIColor) {
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        
        view.layer.addSublayer(shapeLayer)
    }
}
