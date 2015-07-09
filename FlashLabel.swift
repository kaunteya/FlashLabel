//
//  FlashLabel.swift
//  FlashLabel
//
//  Created by Kauntey Suryawanshi on 07/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

public class FlashLabel: NSTextField {
    
    private var timer: NSTimer!
    private var timeSummation = CGFloat(0)
    let flashInterval = NSTimeInterval(0.5)
    var showTime: CGFloat!
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
//        self.layer!.contentsGravity = kCAGravityCenter
        self.layer!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        println("Anchor point \(self.layer!.anchorPoint)")
        self.setVisibility(false, animated: false)
        makeShowAnimation()
        makeHideAnimation()
    }

    var visible: Bool {
        get {
            return self.layer!.opacity == 1
        }
    }

    var showAnimation: CABasicAnimation!
    func makeShowAnimation() {
        showAnimation = CABasicAnimation(keyPath: "opacity")
        showAnimation.duration = 1
        showAnimation.fromValue = 0
        showAnimation.toValue = 1
        showAnimation.repeatCount = 0
    }

    var hideAnimation: CAAnimationGroup!
    func makeHideAnimation() {
        var scaleXAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        scaleXAnimation.fromValue = 1
        scaleXAnimation.toValue = 1.2
        scaleXAnimation.duration = 1
        scaleXAnimation.fillMode = kCAFillModeForwards
        
        
        var boundsAnimation = CABasicAnimation(keyPath: "bounds")
        boundsAnimation.fromValue =  NSValue(rect: self.bounds)
        var newBounds = self.bounds
        newBounds.size.width += 50
        newBounds.size.height += 20
        boundsAnimation.toValue = NSValue(rect: newBounds)
        
        
        var scaleYAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        scaleYAnimation.fromValue = 1
        scaleYAnimation.toValue = 1.5
        scaleYAnimation.duration = 1
        scaleYAnimation.fillMode = kCAFillModeForwards

        var opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.repeatCount = 0

        hideAnimation = CAAnimationGroup()
        hideAnimation.animations = [scaleXAnimation, boundsAnimation]
//        hideAnimation.animations = [scaleXAnimation, opacityAnimation]
        hideAnimation.duration = 1
        hideAnimation.delegate = self
        }
    
    func setVisibility(enabled: Bool, animated: Bool) {
        if animated {
            if enabled {
                self.layer!.addAnimation(showAnimation, forKey: "visible")
            } else {
                self.layer!.addAnimation(hideAnimation, forKey: "hidden")
            }
        }
//        self.layer!.opacity  = enabled ? 1 : 0
    }
    
    /**
    Shows the FlashLabel for specified time
    
    :param: text Stringvalue of the label
    :param: time Time to live in seconds
    :param: flash enabled will flash the label
    
    */
    public func show(text: String, forDuration time: CGFloat, withFlash flash: Bool) {
        self.setVisibility(true, animated: false)
        self.stringValue = text
        self.sizeToFit()
        if flash {
            timeSummation = 0
            showTime = time
            timer = NSTimer.scheduledTimerWithTimeInterval(flashInterval, target: self, selector: Selector("flashNotify"), userInfo: nil, repeats: true)
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(time), target: self, selector: Selector("timerNotify"), userInfo: nil, repeats: false)
        }
    }
    
    func timerNotify() {
        self.setVisibility(false, animated: true)
    }
    
    func flashNotify() {
        if timeSummation < showTime {
            timeSummation += 0.5
            self.setVisibility(!self.visible, animated: false)
        } else {
            timer.invalidate()
            self.setVisibility(false, animated: false)
        }
    }
    public override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        println("Animation stopped")
    }
}
