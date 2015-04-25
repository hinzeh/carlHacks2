//
//  MenuControl.swift
//  TabTable
//
//  Created by Sam on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa

class MenuControl: NSMenu{
    @IBOutlet var statusMenu: NSMenu! = NSMenu();
    var statusItem: NSStatusItem?;
    var menuClose: NSMenuItem = NSMenuItem()
    var closeNum = 1
    
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
        statusItem!.action = Selector("trial:")
        
    }
    
    @IBAction func trial(sender: NSObject){
        println("Yo")
    }
    
    override func performActionForItemAtIndex(index: Int) {
        if (index == closeNum){
            menuClose.title = "open"
            println(menuClose.title)
            self.update()
        }
    }
    
    override init(title aTitle: String) {
        super.init(title: aTitle)
        self.title = title
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
