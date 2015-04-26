//
//  DragView.swift
//  dragTest
//
//  Created by Sean Mullan on 4/24/15.
//  Copyright (c) 2015 SilentLupin. All rights reserved.
//

import Foundation
import Cocoa

protocol DragViewDelegate {
    func receiveDragged(object:AnyObject)
}

class DragView: NSImageView, NSDraggingDestination{

    var highlight : Bool
    var delegate : DragViewDelegate
    required init?(coder: NSCoder) {
        self.highlight = false
        delegate = coder as! DragViewDelegate
        
        super.init(coder: coder)
        self.registerForDraggedTypes([NSURLPboardType,NSStringPboardType])//NSImage.imagePasteboardTypes())
    }
    init(frame frameRect: NSRect, newDelegate:DragViewDelegate) {
        self.highlight = false
        self.delegate = newDelegate

        super.init(frame: frameRect)
        self.registerForDraggedTypes([NSURLPboardType,NSStringPboardType])//NSImage.imagePasteboardTypes())
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        var bPath:NSBezierPath = NSBezierPath()
        bPath.appendBezierPathWithRoundedRect(dirtyRect, xRadius: 5.0, yRadius: 5.0)
        bPath.lineWidth = 3
        NSColor(red: 0.13, green: 0.50, blue: 0.2, alpha: 1).set()
        bPath.stroke()
        
        var gradient:NSGradient = NSGradient(colorsAndLocations:
            (NSColor(red: 0.0, green: 0.0, blue: 0.25, alpha: 0.25),0.0),
            (NSColor(red: 0.0, green: 0.0, blue: 0.25, alpha: 0.5),1))
        
        gradient.drawInBezierPath(bPath, angle: 90.0)
        
        if ( highlight ) {
            //highlight by overlaying a gray border
            NSColor.grayColor().set()
            NSBezierPath.setDefaultLineWidth(5)
            NSBezierPath.strokeRect(dirtyRect)
        }

//        self.image = NSImage(named: "smallplus")
        var plus = NSImage(named:"smallplus")
        self.image = plus
        var ratio = dirtyRect.size.height/plus!.size.height
        var newSize = NSMakeSize(ratio*plus!.size.width, ratio*plus!.size.height)
        var newRect = NSZeroRect
        newRect.size = newSize
        newRect.origin = NSPoint(x:dirtyRect.width/2-newSize.width/2, y:dirtyRect.height/2-newSize.height/2)
        
        
        var imageRect = NSZeroRect
        imageRect.size = self.image!.size
        imageRect.origin = NSZeroPoint
        
//        newRect.origin.y = vSize.height/2-previewSize.height/2
//        newRect.size = previewImage.size
        self.image!.drawInRect(newRect, fromRect: imageRect, operation: NSCompositingOperation.CompositeSourceOver, fraction: 1.0)

    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
        println("Dragging Enter")
        self.highlight = true
        self.setNeedsDisplay()
        return NSDragOperation.Generic
    }
    override func draggingExited(sender: NSDraggingInfo?) {
        println("Dragging Exit")
        self.highlight = false
        self.setNeedsDisplay()
        return
    }
    override func prepareForDragOperation(sender: NSDraggingInfo) -> Bool {
        var pasting : NSPasteboard = sender.draggingPasteboard()
        var itemArray = pasting.pasteboardItems!
        itemArray = pasting.readObjectsForClasses([NSString.self,NSURL.self], options: nil)!
        for temp in itemArray{
            //Do shenanigans with the dragged thing(s)
            delegate.receiveDragged(temp)
        }
        self.highlight = false
        self.setNeedsDisplay()
        return true
    }
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        return true
    }

//    func windowWillUseStandardFrame(window : NSWindow, newFrame : NSRect) -> NSWindow{
//        var contentRect:NSRect = self.window!.frame
//        contentRect.size = self.window!.frame.size
//        return NSWindow(contentRect: contentRect, styleMask: window.styleMask, backing: NSBackingStoreType.Retained, defer:false)
//    }
}

