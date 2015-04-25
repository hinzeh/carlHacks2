//
//  TableViewCell.swift
//  TabTable
//
//  Created by Sean Mullan on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Foundation
import Cocoa

class TableViewCell : NSTableCellView{
    var text: NSTextField
    var site: NSURL = NSURL()
    override init(frame frameRect:NSRect) {
        var textRect = NSRect(x: 5, y: 5, width: frameRect.width/2, height: frameRect.height-10)
        self.text = NSTextField(frame: textRect)
        self.text.font = NSFont(name: "Futura", size: frameRect.height-20)
        self.text.stringValue = "HI"
        self.text.editable = false
        self.text.selectable = false
        self.text.drawsBackground = false
        self.text.bezeled = false
        
        super.init(frame: frameRect)
        
        self.addSubview(text)
        site = NSURL(fileURLWithPath: "http://www.google.com")!
        
        
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        var bPath:NSBezierPath = NSBezierPath()
        bPath.appendBezierPathWithRoundedRect(dirtyRect, xRadius: 5.0, yRadius: 5.0)
        bPath.lineWidth = 3
        NSColor(red: 0.13, green: 0.70, blue: 1, alpha: 1).set()
        bPath.stroke()
        var gradient:NSGradient = NSGradient(colorsAndLocations:
            (NSColor(red: 0.0, green: 0.0, blue: 0.25, alpha: 0.25),0.0),
            (NSColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 0.25),1))

        gradient.drawInBezierPath(bPath, angle: 90.0)
    }
    func setString(text:String){
        self.text.stringValue = text
        
    }
}