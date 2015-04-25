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
    var dropZone : DragView
    init(frame frameRect:NSRect, id:String) {
        var textRect = NSRect(x: 5, y: 5, width: frameRect.width/2, height: frameRect.height-10)
        self.text = NSTextField(frame: textRect)
        self.text.stringValue = "HI"
//        self.text.backgroundColor = NSColor.grayColor()
        var dropRect = NSRect(x: frameRect.width-frameRect.height*2, y: 0, width: frameRect.height*2, height: frameRect.height)
        dropZone = DragView(frame: dropRect)
        super.init(frame: frameRect)
        
        self.identifier = id

        self.addSubview(text)
        self.addSubview(dropZone)
        
        
        
        println(self.text.stringValue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        //highlight by overlaying a gray border
//        NSColor.grayColor().set()
//        NSBezierPath.setDefaultLineWidth(5)
//        NSBezierPath.strokeRect(dirtyRect)
        var bPath:NSBezierPath = NSBezierPath()
        bPath.appendBezierPathWithRoundedRect(dirtyRect, xRadius: 10.0, yRadius: 10.0)
        bPath.lineWidth = 3
        NSColor(red: 0.0, green: 0.25, blue: 0.75, alpha: 0.75).set()
        bPath.stroke()
//        var gradient:NSGradient = NSGradient(colorsAndLocations:
//            (NSColor(red: 0.0, green: 0.0, blue: 0.75, alpha: 1.0),0.0),
//            (NSColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0),0.25))
//        
//        gradient.drawInBezierPath(bPath, angle: 270.0)
    }
    func setString(text:String){
        println(self.text.stringValue)
        self.text.stringValue = text
        
    }
}