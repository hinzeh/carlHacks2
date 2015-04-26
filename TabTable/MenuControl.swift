//
//  MenuControl.swift
//  TabTable
//
//  Created by Sam on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa

class MenuControl: NSMenu {
    @IBOutlet var statusMenu: NSMenu! = NSMenu();
    var statusItem: NSStatusItem!;
    var menuClose: NSMenuItem = NSMenuItem()
    var closeNum = 1
    var dvd :DragViewDelegate
    var window :NSWindow
    
    func statusMenuLaunch() {

        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(CGFloat(59))
        statusItem.button!.title = "Tab Nab"
        statusItem.button!.appearsDisabled = false
        statusItem.button!.action = Selector("trial:")
        statusItem.button!.target = self
        
    }
    
    func trial(sender: NSObject){
        println(self.dvd)
        if (self.window.visible) {
            println("window is open")
            self.window.orderFront(self.window)
            NSApp.activateIgnoringOtherApps(true)
        } else {
            println("window is closed")
            NSApp.activateIgnoringOtherApps(true)

        }
    }

    
    override func performActionForItemAtIndex(index: Int) {
        if (index == closeNum){
            menuClose.title = "open"
            println(menuClose.title)
            self.update()
        }
    }
    
    init(title aTitle: String, thumbkin:DragViewDelegate, windowVar:NSWindow) {
        self.dvd = thumbkin
        self.window = windowVar
        super.init(title: aTitle)
        self.title = title
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
