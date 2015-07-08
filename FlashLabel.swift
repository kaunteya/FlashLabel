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
        self.setVisibility(false, animated: false)
    }
    
    var visible: Bool {
        get {
            return self.alphaValue == 1
        }
    }
    
    func setVisibility(enabled: Bool, animated: Bool) {
        if animated {
            NSAnimationContext.beginGrouping()
            NSAnimationContext.currentContext().duration = 1.5
            NSAnimationContext.currentContext().timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            self.animator().alphaValue = enabled ? 1 : 0
            NSAnimationContext.endGrouping()
        } else {
            self.alphaValue = enabled ? 1 : 0
        }
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
}
