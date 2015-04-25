//
//  AddTableViewCell.swift
//  TabTable
//
//  Created by Sean Mullan on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

//
//  TableViewCell.swift
//  TabTable
//
//  Created by Sean Mullan on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Foundation
import Cocoa

class AddTableViewCell : NSTableCellView{
    var dropZone : DragView
    override init(frame frameRect:NSRect) {
        var dropRect = NSRect(x: frameRect.width/4, y: 0, width: frameRect.width/2, height: frameRect.height)
        dropZone = DragView(frame: dropRect)
        super.init(frame: frameRect)
        
        self.addSubview(dropZone)
        
        
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

}