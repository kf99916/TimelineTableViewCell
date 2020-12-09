//
//  TimelineTableViewCell.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/20.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import UIKit


open class TimelineTableViewCell: UITableViewCell {
    
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var descriptionLabel: UILabel!
    @IBOutlet weak open var lineInfoLabel: UILabel!
    @IBOutlet weak internal var stackView: UIStackView!
    @IBOutlet weak open var illustrationImageView: UIImageView!
    
    @IBOutlet weak var titleLabelLeftMargin: NSLayoutConstraint!
    @IBOutlet weak var lineInfoLabelRightMargin: NSLayoutConstraint!
    @IBOutlet weak var descriptionMargin: NSLayoutConstraint!
    @IBOutlet weak var illustrationSize: NSLayoutConstraint!
    @IBOutlet weak var stackViewSize: NSLayoutConstraint!
    
    open var viewsInStackView: [UIView] = []
    
    open var timelinePoint = TimelinePoint() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    open var timeline = Timeline() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    open var bubbleRadius: CGFloat = 2.0 {
        didSet {
            if (bubbleRadius < 0.0) {
                bubbleRadius = 0.0
            } else if (bubbleRadius > 6.0) {
                bubbleRadius = 6.0
            }
            self.setNeedsDisplay()
        }
    }
    
    open var bubbleColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
    open var bubbleEnabled = true

    fileprivate lazy var maxNumSubviews = max(Int(floor(stackView.frame.size.width / (stackView.frame.size.height + stackView.spacing))) - 1, 0)
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override open func draw(_ rect: CGRect) {
        for layer in self.contentView.layer.sublayers! {
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        }

        let textMargin = max(timeline.width / 2, timelinePoint.diameter / 2) + 20

        titleLabelLeftMargin.constant = timeline.leftMargin + textMargin
        titleLabel.sizeToFit()

        lineInfoLabelRightMargin.constant = timeline.leftMargin - textMargin
        lineInfoLabel.sizeToFit()

        descriptionLabel.sizeToFit()

        timelinePoint.position = CGPoint(x: timeline.leftMargin, y: titleLabel.frame.origin.y + titleLabel.intrinsicContentSize.height / 2)

        timeline.start = CGPoint(x: timeline.leftMargin, y: 0)
        timeline.middle = CGPoint(x: timeline.start.x, y: timelinePoint.position.y)
        timeline.end = CGPoint(x: timeline.start.x, y: self.bounds.size.height)
        timeline.draw(view: self.contentView)

        timelinePoint.draw(view: self.contentView)

        if bubbleEnabled {
            drawBubble()
        }
        
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        let views = viewsInStackView.count <= maxNumSubviews ? viewsInStackView : Array(viewsInStackView[0..<maxNumSubviews])
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraint(NSLayoutConstraint(item: view,
                                                  attribute: NSLayoutConstraint.Attribute.width,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: view,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  multiplier: 1,
                                                  constant: 0))
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            stackView.addArrangedSubview(view)
        }
        
        let diffNumViews = viewsInStackView.count - maxNumSubviews
        if diffNumViews > 0 {
            let label = UILabel(frame: CGRect.zero)
            label.text = String(format: "+ %d", diffNumViews)
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            stackView.addArrangedSubview(label)
        }
        else {
            let spacerView = UIView()
            spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
            stackView.addArrangedSubview(spacerView)
        }
    }
}

// MARK: - Fileprivate Methods
fileprivate extension TimelineTableViewCell {
    func drawBubble() {
        let padding: CGFloat = 8
        let bubbleRect = CGRect(
            x: titleLabelLeftMargin.constant - padding,
            y: titleLabel.frame.minY - padding,
            width: titleLabel.frame.size.width + padding * 2,
            height: titleLabel.frame.size.height + padding * 2)

        let path = UIBezierPath(roundedRect: bubbleRect, cornerRadius: bubbleRadius)
        let startPoint = CGPoint(x: bubbleRect.origin.x, y: bubbleRect.origin.y + bubbleRect.height / 2 - 8)
        path.move(to: startPoint)
        path.addLine(to: startPoint)
        path.addLine(to: CGPoint(x: bubbleRect.origin.x - 8, y: bubbleRect.origin.y + bubbleRect.height / 2))
        path.addLine(to: CGPoint(x: bubbleRect.origin.x, y: bubbleRect.origin.y + bubbleRect.height / 2 + 8))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = bubbleColor.cgColor
        
        self.contentView.layer.insertSublayer(shapeLayer, below: titleLabel.layer)
    }
}
