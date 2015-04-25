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
    
    @IBOutlet weak var window: NSWindow!
    var masterViewController: MasterViewController!
    var menuControl: MenuControl?

    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        masterViewController.setupSampleTable()
        window.contentView.addSubview(masterViewController.view)
        masterViewController.view.frame = (window.contentView as! NSView).bounds
        
        self.menuControl = MenuControl()
        self.menuControl?.statusMenuLaunch()
        // Insert code here to initialize your application

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        masterViewController.saveData()
    }
}

