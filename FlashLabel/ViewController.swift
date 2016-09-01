//
//  ViewController.swift
//  FlashLabel
//
//  Created by Kauntey Suryawanshi on 07/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var enableFlash: Bool = false
    @IBOutlet weak var flashLabel: FlashLabel!
    
    @IBAction func enableFlash(sender: NSButton) {
        enableFlash = sender.state == NSOnState
    }
    
    @IBAction func buttonPressed(sender: NSButton) {
        flashLabel.show("Please enter a valid password", forDuration: 2, withFlash: self.enableFlash)
    }

}

