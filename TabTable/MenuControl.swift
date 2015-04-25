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
    var statusItem: NSStatusItem?;
    var menuClose: NSMenuItem = NSMenuItem()
    var closeNum = 1
    var dvd :DragViewDelegate
    
    func statusMenuLaunch() {
        // menu stuff
        let bar = NSStatusBar.systemStatusBar()
        let NSVariableStatusItemLength: CGFloat = -1.0

        statusItem = bar.statusItemWithLength(CGFloat(NSVariableStatusItemLength))
        statusItem!.title = "Tab Nab"
        //statusItem!.menu = statusMenu
        statusItem!.highlightMode = true
        
        //menuClose.title = "close"
        //println(menuClose.title)
        //statusMenu.addItem(menuClose)
        //statusItem!.action = Selector("trial:")
        //statusItem!.menu = self
        
        /*var menuItem : NSMenuItem = NSMenuItem(title: "Unknown", action: Selector("dostuff"), keyEquivalent: "")
        menuItem.view = DragView(frame: NSRect(x: 0, y: 0, width: 100, height: 100), newDelegate: self.dvd)
        self.addItem(menuClose) */
        
    }
    
//    @IBAction func trial(sender: NSObject){
//        println("Yo")
//    }
    
    override func performActionForItemAtIndex(index: Int) {
        if (index == closeNum){
            menuClose.title = "open"
            println(menuClose.title)
            self.update()
        }
    }
    
    init(title aTitle: String, thumbkin:DragViewDelegate) {
        self.dvd = thumbkin
        super.init(title: aTitle)
        self.title = title
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
