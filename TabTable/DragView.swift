//
//  DragView.swift
//  dragTest
//
//  Created by Sean Mullan on 4/24/15.
//  Copyright (c) 2015 SilentLupin. All rights reserved.
//

import Foundation
import Cocoa

class DragView: NSImageView, NSDraggingDestination{

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.registerForDraggedTypes([NSURLPboardType,NSStringPboardType])//NSImage.imagePasteboardTypes())
        println(self.registeredDraggedTypes)
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
        println("Dragging Enter")
        return NSDragOperation.Generic
    }
    override func draggingExited(sender: NSDraggingInfo?) {
        println("Dragging Exit")
        return
    }
    override func prepareForDragOperation(sender: NSDraggingInfo) -> Bool {
        var pasting : NSPasteboard = sender.draggingPasteboard()
        var itemArray = pasting.pasteboardItems!
        itemArray = pasting.readObjectsForClasses([NSString.self,NSURL.self], options: nil)!
        for temp in itemArray{
            //Do shenanigans with the dragged thing(s)
            println(temp)
        }
        return true
    }
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        return true
    }

    func windowWillUseStandardFrame(window : NSWindow, newFrame : NSRect) -> NSWindow{
        var contentRect:NSRect = self.window!.frame
        contentRect.size = self.window!.frame.size
        return NSWindow(contentRect: contentRect, styleMask: window.styleMask, backing: NSBackingStoreType.Retained, defer:false)
    }
}

