//
//  TableViewCell.swift
//  TabTable
//
//  Created by Sean Mullan on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

protocol TableViewCellDelegate{
    func deleteTableViewCell(object:AnyObject)
    func refreshTableViewCell(object:AnyObject)
    func addUrlCells(object: AnyObject)
    func deleteUrlCells(object: AnyObject)
}

class TableViewCell : NSTableCellView, NSTextFieldDelegate, NSControlTextEditingDelegate{
    var text: NSTextField
    var date: NSTextField
    var site: NSURL = NSURL()
    var button: NSButton
    var deleteButton: NSButton
    var buttonPress: Bool=false
    var colorChange: Bool = false
    var delegate : TableViewCellDelegate
    var doc: ToDoItemObj
    var textSize: CGFloat
//    var dropZone : DragView
    var title : NSString = ""
    init(tableColumnWidth: CGFloat, doc:ToDoItemObj, newDelegate:TableViewCellDelegate) {
        self.doc=doc
        if doc.name.rangeOfString(".") != nil{
            colorChange = true
        }
        self.delegate=newDelegate
        var heightVar: CGFloat
        heightVar=50.0
        println("heightVar is \(heightVar)")
        self.textSize=17.0
        if (colorChange){
            self.textSize=12.0
        }
        
        self.doc=doc
        var frameRect = NSRect(x: 0, y: 0, width:tableColumnWidth, height: heightVar)
        self.title = doc.name
        var textRect = NSRect(x: 5, y: heightVar, width: frameRect.width/2, height: 50)
        self.text = NSTextField(frame: textRect)
        self.text.font = NSFont(name: "Tahoma", size: textSize)
        self.text.stringValue = doc.name
        self.text.editable = true
        self.text.selectable = true
        self.text.drawsBackground = false
        self.text.bezeled = false
        self.text.textColor = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.text.sizeToFit()
        if (self.text.frame.width>frameRect.width*(3.0/4.0)){
            println("Resizing")
            var newString : NSString = self.text.stringValue
            newString = newString.substringWithRange(NSRange(location: 0, length: 20)) + "..."
            self.text.stringValue = newString as String
            self.text.frame = NSRect(x:5, y:frameRect.height/2-10, width: frameRect.width*(3.0/4.0), height: frameRect.height/2+10)
        }else{
            self.text.frame = NSRect(x:5, y:frameRect.height/2-10, width: frameRect.width*(3.0/4.0), height: frameRect.height/2+10)
        }
        println(frameRect.height)
        var dateRect = NSRect(x: 5, y: heightVar-45, width: frameRect.width*(3.0/4.0), height: textRect.height)
        self.date = NSTextField(frame: dateRect)
        self.date.font = NSFont(name: "Tahoma", size: 9)
        var today = NSDate(timeIntervalSinceNow: 0)
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        var dateString = dateFormatter.stringFromDate(today)
        self.date.stringValue = dateString
        
        self.date.editable = false
        self.date.selectable = false
        self.date.drawsBackground = false
        self.date.bezeled = false
        self.date.sizeToFit()
        
        var buttonRect = NSRect(x: frameRect.width-50, y: 5, width: frameRect.width/20, height: frameRect.height-30)
        self.button=NSButton(frame: buttonRect)
        self.button.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        self.button.title="▾"
        self.button.action = "expandAction:"
        
        
        let utf8 : [UInt8]=[0xE2, 0x9C, 0x98, 0]
        let str=NSString(bytes: utf8, length: utf8.count, encoding: NSUTF8StringEncoding)
        var deleteButtonRect = NSRect(x: frameRect.width-50, y: 25, width: frameRect.width/20, height: frameRect.height-30)
        self.deleteButton=NSButton(frame: deleteButtonRect)
        self.deleteButton.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        self.deleteButton.title=str as! String
        self.deleteButton.action = "deleteAction:"

        
        println(self.text.stringValue)
        
        
        super.init(frame: frameRect)
        
        var  dropRect = NSRect(x: 500*(0.75), y: 5,  width: 40, height: 40)
        var dropZone = DragView(frame: dropRect, newDelegate: self)
        self.button.target = self
        self.deleteButton.target = self

        self.text.delegate = self
        self.addSubview(text)
        self.addSubview(date)
        if doc.name.rangeOfString(".") != nil{
            colorChange = true
        }else{
            self.addSubview(dropZone)
            self.addSubview(button)
        }
        self.addSubview(deleteButton)
        site = NSURL(fileURLWithPath: "http://www.google.com")!
        
    }
    
    override func controlTextDidBeginEditing(obj: NSNotification) {
        self.text.stringValue = self.title as String
    }
    override func controlTextDidEndEditing(obj: NSNotification) {
        if(self.text.stringValue != self.title){
            if(self.text.stringValue.rangeOfString(".") != nil){
                self.text.stringValue = self.text.stringValue.stringByReplacingOccurrencesOfString(".", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            }
            self.title = self.text.stringValue
            self.doc.name = self.text.stringValue
            self.doc.priority = self.doc.name
        }
        self.text.sizeToFit()
        if (self.text.frame.width>self.frame.width*(3.0/4.0)){
            println("Resizing")
            var newString : NSString = self.text.stringValue
            newString = newString.substringWithRange(NSRange(location: 0, length: 20)) + "..."
            self.text.stringValue = newString as String
            self.text.frame = NSRect(x:5, y:self.frame.height/2-10, width: self.frame.width*(3.0/4.0), height: self.frame.height/2+10)
        }else{
            self.text.frame = NSRect(x:5, y:self.frame.height/2-10, width: self.frame.width*(3.0/4.0), height: self.frame.height/2+10)
        }
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
        if !colorChange{
            var gradient:NSGradient = NSGradient(colorsAndLocations:
                (NSColor(red: 0.0, green: 0.5, blue: 0.9, alpha: 0.5),0.0),
                (NSColor(red: 0.0, green: 0.5, blue: 0.75, alpha: 0.5),1))
            gradient.drawInBezierPath(bPath, angle: 90.0)

        }else{
            NSColor(red: 0.0, green: 0.70, blue: 1, alpha: 1).set()
            bPath.stroke()
            var gradient:NSGradient = NSGradient(colorsAndLocations:
            (NSColor(red: 0.0, green: 0.9, blue: 0.9, alpha: 0.5),0.0),
            (NSColor(red: 0.0, green: 0.5, blue: 0.75, alpha: 0.5),1))
            gradient.drawInBezierPath(bPath, angle: 90.0)

        }

    }
    func setString(text:String){
        self.text.stringValue = text
        
    }
    
    func expandAction(obj:AnyObject?){
        println("button press is: \(buttonPress)")
        println("boolExpanded is: \(self.doc.boolExpanded)")
        if (self.doc.boolExpanded){
            delegate.deleteUrlCells(self.doc)
            buttonPress=false
            self.doc.boolExpanded=false
        }
        else{
            delegate.addUrlCells(self.doc)
            buttonPress=true
            self.doc.boolExpanded=true
            
        }
        
        println("middle button press is: \(buttonPress)")
        println("middle boolExpanded is: \(self.doc.boolExpanded)")
        delegate.refreshTableViewCell(self.doc)
        println("after button press is: \(buttonPress)")
        println("after boolExpanded is: \(self.doc.boolExpanded)")
    }
    
    func deleteAction(obj:AnyObject?){
        delegate.deleteTableViewCell(self.doc)
    }
    
    func addExpandView(frameRect: NSRect){
        var size = self.doc.linkArray.count
        
    }
    
    func changeColor(){
        if(colorChange){
            colorChange = false
        }else{
            colorChange = true
        }
        self.needsDisplay = true
    }
}

extension TableViewCell: DragViewDelegate{
    func receiveDragged(object: AnyObject) {
        if (object is String || object is NSString){
            doc.linkArray.append(object as! String)
        }else{
            doc.linkArray.append((object as! NSURL).absoluteString!)
        }
    }
}