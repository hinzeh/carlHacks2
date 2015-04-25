//
//  AppDelegate.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var statusMenu: NSMenu?;
    @IBOutlet weak var window: NSWindow!
    var statusItem: NSStatusItem?;
    var masterViewController: MasterViewController!

    // Unknown functionality... good luck...
    var button: NSStatusBarButton?
    override func awakeFromNib() {
        let NSVariableStatusItemLength: CGFloat = -1.0
        
        self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
        self.button = self.statusItem?.button
        self.button?.title = "Press Me"
        self.button?.action = "pressed"
        self.button?.target = self
    }
    
    func pressed(sender : AnyObject) {
        println("Pressed")
    }
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        masterViewController.setupSampleTable()
        
        window.contentView.addSubview(masterViewController.view)
        masterViewController.view.frame = (window.contentView as! NSView).bounds

        // menu stuff
        let bar = NSStatusBar.systemStatusBar()
        let NSVariableStatusItemLength: CGFloat = -1.0
        
        statusItem = bar.statusItemWithLength(CGFloat(NSVariableStatusItemLength))
        statusItem!.title = "Tab Nab"
        statusItem!.menu = statusMenu
        statusItem!.highlightMode = true
        // Insert code here to initialize your application

    }
    
    

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        masterViewController.saveData()
    }
}

