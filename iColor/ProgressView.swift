//
//  ProgressView.swift
//  CustomProgressBar
//
//  Created by Sztanyi Szabolcs on 16/10/14.
//  Copyright (c) 2014 Sztanyi Szabolcs. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    private let progressLayer: CAShapeLayer = CAShapeLayer()
    
    private var progressLabel: UILabel
    
    required init(coder aDecoder: NSCoder) {
        progressLabel = UILabel()
        super.init(coder: aDecoder)!
        createProgressLayer()
        createLabel()
    }
    
    override init(frame: CGRect) {
        progressLabel = UILabel()
        super.init(frame: frame)
        createProgressLayer()
        createLabel()
    }
    
    func createLabel() {
        progressLabel = UILabel(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 60.0))
        progressLabel = UILabel(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 60.0))
        progressLabel.textAlignment = .Center
        progressLabel.text = "60"
//        progressLabel.textColor = UIColor.appYellowFont()
        progressLabel.textColor = UIColor.whiteColor()
        progressLabel.font = UIFont(name: "Avenir-Heavy", size: 50.0)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    //Rotate counter clockwise
//    private func createProgressLayer() {
//        let startAngle = CGFloat(M_PI_2)
//        let endAngle = CGFloat(M_PI * 2 + M_PI_2)
//        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
//        
//        let gradientMaskLayer = gradientMask()
//        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
//        progressLayer.backgroundColor = UIColor.clearColor().CGColor
//        progressLayer.fillColor = nil
//        progressLayer.strokeColor = UIColor.blackColor().CGColor
//        progressLayer.lineWidth = 5.0
//        progressLayer.strokeStart = 0.0
//        progressLayer.strokeEnd = 0.0
//        
//        gradientMaskLayer.mask = progressLayer
//        layer.addSublayer(gradientMaskLayer)
//        
//        let dashedLayer = CAShapeLayer()
//        dashedLayer.strokeColor = UIColor(white: 1.0, alpha: 0.5).CGColor
//        dashedLayer.fillColor = nil
//        dashedLayer.lineDashPattern = [2, 4]
//        dashedLayer.lineJoin = "round"
//        dashedLayer.lineWidth = 5.0
//        dashedLayer.path = progressLayer.path
//        layer.insertSublayer(dashedLayer, below: progressLayer)
//    }
    
    //Rotate clockwise
    private func createProgressLayer() {
        let startAngle = CGFloat(-M_PI_2)
        print(startAngle)
        let endAngle = CGFloat((M_PI + M_PI_2))
        print(CGFloat((M_PI * 2 + M_PI_2)))
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        
        let gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.blackColor().CGColor
        progressLayer.lineWidth = 5.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        
        gradientMaskLayer.mask = progressLayer
        layer.addSublayer(gradientMaskLayer)
        
        let dashedLayer = CAShapeLayer()
        dashedLayer.strokeColor = UIColor(white: 1.0, alpha: 0.5).CGColor
        dashedLayer.fillColor = nil
        dashedLayer.lineDashPattern = [2, 4]
        dashedLayer.lineJoin = "round"
        dashedLayer.lineWidth = 5.0
        dashedLayer.path = progressLayer.path
        layer.insertSublayer(dashedLayer, below: progressLayer)
    }

    
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds

        gradientLayer.locations = [0.0, 1.0]
        
//        let colorTop: AnyObject = UIColor(red: 255.0/255.0, green: 213.0/255.0, blue: 63.0/255.0, alpha: 1.0).CGColor
        let colorTop: AnyObject = UIColor.redColor().CGColor
        let colorBottom: AnyObject = UIColor.redColor().CGColor
//        let colorBottom: AnyObject = UIColor(red: 255.0/255.0, green: 198.0/255.0, blue: 5.0/255.0, alpha: 1.0).CGColor
        let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    func hideProgressView() {
        progressLayer.strokeEnd = 0.0
        progressLayer.removeAllAnimations()
        progressLabel.text = "60"
    }
    
    func animateProgressViewToProgress(progress: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(progressLayer.strokeEnd)
        animation.toValue = CGFloat(progress)
        animation.duration = 0.2
        animation.fillMode = kCAFillModeForwards
        progressLayer.strokeEnd = CGFloat(progress)
        progressLayer.addAnimation(animation, forKey: "animation")
    }
    
    func updateProgressViewLabelWithProgress(seconds: Int) {
        var counterString = ""
        if seconds < 10 {
            counterString += "0" + String(seconds)
        } else {
            counterString += String(seconds)
        }
        progressLabel.text = counterString
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        progressLabel.text = "Done"
    }
}
