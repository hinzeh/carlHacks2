//
//  AppDelegate.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa
import AppKit

@NSApplicationMain
class AppDelegate: NSWindow, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    var masterViewController: MasterViewController!
    var menuControl: MenuControl?

    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        window.contentView.addSubview(masterViewController.view)
        masterViewController.view.frame = (window.contentView as! NSView).bounds
        
        self.menuControl = MenuControl(title: "TabNab",thumbkin: masterViewController, windowVar:window)
        self.menuControl?.statusMenuLaunch()
        self.masterViewController.view.autoresizingMask = (self.window.contentView as! NSView).autoresizingMask;
    }
    
    func windowToFront(){
        println("Man")
        self.orderFront(window)
    }


    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        masterViewController.saveData()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}

