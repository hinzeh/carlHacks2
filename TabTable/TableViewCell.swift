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
}

class TableViewCell : NSTableCellView{
    var text: NSTextField
    var date: NSTextField
    var site: NSURL = NSURL()
    var button: NSButton
    var deleteButton: NSButton
    var buttonPress: Bool=false
    var delegate : TableViewCellDelegate
    var doc: ToDoItemObj

    init(frame frameRect:NSRect, doc:ToDoItemObj, newDelegate:TableViewCellDelegate) {
        self.doc=doc
        self.delegate=newDelegate
        var textRect = NSRect(x: 5, y: 5, width: frameRect.width/2, height: frameRect.height-10)
        self.text = NSTextField(frame: textRect)
        self.text.font = NSFont(name: "Courier", size: frameRect.height/2)
        self.text.stringValue = doc.name
        self.text.editable = true
        self.text.selectable = false
        self.text.drawsBackground = false
        self.text.bezeled = false
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
        var dateRect = NSRect(x: 5, y: 5, width: frameRect.width*(3.0/4.0), height: frameRect.height)
        self.date = NSTextField(frame: dateRect)
        self.date.font = NSFont(name: "Courier", size: frameRect.height/4)
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
        self.button.action = "myAction:"
        
        
        let utf8 : [UInt8]=[0xE2, 0x9C, 0x98, 0]
        let str=NSString(bytes: utf8, length: utf8.count, encoding: NSUTF8StringEncoding)
        var deleteButtonRect = NSRect(x: frameRect.width-50, y: 25, width: frameRect.width/20, height: frameRect.height-30)
        self.deleteButton=NSButton(frame: deleteButtonRect)
        self.deleteButton.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        self.deleteButton.title=str as! String
        self.deleteButton.action = "deleteAction:"

        
        println(self.text.stringValue)
        super.init(frame: frameRect)
        self.button.target = self
        self.deleteButton.target = self

        
        self.addSubview(text)
        self.addSubview(date)
        self.addSubview(button)
        self.addSubview(deleteButton)
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
    
    func myAction(obj:AnyObject?){
        var testArr: Array<String>
        testArr=Array()
        testArr.append("hey")
        testArr.append("hey again")
        if buttonPress{
            buttonPress=false
        }
        if !buttonPress{
            buttonPress=true
            showURLS(testArr)
        }
    }
    
    func deleteAction(obj:AnyObject?){
        delegate.deleteTableViewCell(self.doc)
    }
    
    func showURLS(urlArray: Array<String>){
        var url: String
        for url: String in urlArray{
            
        }
    }
}