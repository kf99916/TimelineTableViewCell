//
//  Timeline.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/21.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation
import UIKit

public struct Timeline {
    public var width: CGFloat = 2.0 {
        didSet {
            if (width < 0.0) {
                width = 0.0
            }
        }
    }
    
    public var (frontColor, backColor) = (UIColor.black, UIColor.black)
    
    public var leftMargin: CGFloat = 80.0
    
    internal var (start, middle, end) = (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0))
    
    public init(width: CGFloat, frontColor: UIColor, backColor: UIColor) {
        self.width = width
        self.frontColor = frontColor
        self.backColor = backColor
        self.leftMargin -= width / 2
    }
    
    public init(frontColor: UIColor, backColor: UIColor) {
        self.init(width: 2, frontColor: frontColor, backColor: backColor)
    }
    
    public init() {
        self.init(width: 2, frontColor: UIColor.black, backColor: UIColor.black)
    }
    
    public func draw(view: UIView) {
        draw(view: view, from: start, to: middle, color: frontColor)
        draw(view: view, from: middle, to: end, color: backColor)
    }
}

// MARK: - Fileprivate Methods
fileprivate extension Timeline {
    func draw(view: UIView, from: CGPoint, to: CGPoint, color: UIColor) {
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineCap = .round

        view.layer.addSublayer(shapeLayer)
    }
}
