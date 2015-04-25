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
        self.text.backgroundColor = NSColor.grayColor()
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
        NSColor.grayColor().set()
        NSBezierPath.setDefaultLineWidth(5)
        NSBezierPath.strokeRect(dirtyRect)
        var gradient = NSGradient(startingColor: NSColor.blueColor(), endingColor: NSColor.greenColor())
        gradient.drawInBezierPath(NSBezierPath(), angle: 90)
//        gradient.drawFromCenter(CGPoint(x: dirtyRect.midX, y: dirtyRect.midY), radius: 1, toCenter: <#NSPoint#>, radius: <#CGFloat#>, options: <#NSGradientDrawingOptions#>)
//        gradient.drawInRect(dirtyRect, angle: 90)
    }
    func setString(text:String){
        println(self.text.stringValue)
        self.text.stringValue = text
        
    }
}