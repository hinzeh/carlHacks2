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
    var date: NSTextField
    var site: NSURL = NSURL()
    init(frame frameRect:NSRect, doc:TableItemDoc) {
        var textRect = NSRect(x: 5, y: 5, width: frameRect.width/2, height: frameRect.height-10)
        self.text = NSTextField(frame: textRect)
        self.text.font = NSFont(name: "Courier", size: frameRect.height/2)
        self.text.stringValue = doc.data.title
        self.text.editable = false
        self.text.selectable = false
        self.text.drawsBackground = false
        self.text.bezeled = false
        self.text.sizeToFit()
        if (self.text.frame.width>frameRect.width*(3.0/4.0)){
            println("Resizing")
            var newString : NSString = self.text.stringValue
            newString = newString.substringWithRange(NSRange(location: 0, length: 20)) + "..."
            self.text.stringValue = newString as String
            self.text.frame = NSRect(x:5, y:20, width: frameRect.width*(3.0/4.0), height: frameRect.height-20)
        }else{
            self.text.frame = NSRect(x:5, y:20, width: frameRect.width*(3.0/4.0), height: frameRect.height-20)
        }
        var dateRect = NSRect(x: 5, y: frameRect.height-20, width: frameRect.width*(3.0/4.0), height: frameRect.height)
        self.date = NSTextField(frame: dateRect)
        self.date.font = NSFont(name: "Courier", size: 5)
        self.date.stringValue = "30/30/30"
        self.date.editable = false
        self.date.selectable = false
        self.date.drawsBackground = false
        self.date.bezeled = false
        self.date.sizeToFit()
        
        println(self.text.stringValue)
        super.init(frame: frameRect)
        
        self.addSubview(text)
        self.addSubview(date)
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