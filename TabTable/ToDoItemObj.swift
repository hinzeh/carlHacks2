//
//  ToDoItemObj.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa

class ToDoItemObj: NSObject {
    
    var name: String
    var priority: Int
    //var creationDate: NSDate
    //var dueDate: NSDate
    var linkArray: [String]
    
    override init() {
        self.name = String()
        self.priority = Int()
        //self.creationDate = NSDate()
        //self.dueDate = NSDate()
        self.linkArray = [String]()
    }
    
    init(name: String, priority: Int, /*creationDate: NSDate, dueDate: NSDate,*/ linkArray: [String]) {
        self.name = name
        self.priority = priority
        //self.creationDate = creationDate
        //self.dueDate = dueDate
        self.linkArray = linkArray
    }
    
    init(dict: NSMutableDictionary) {
        
        var keys = dict.allKeys
        
        self.name = ""
        self.priority = -1
        self.linkArray = []
        
        for key in keys{
            self.name = key as! String
            var valueArray = dict[self.name] as! NSArray
            self.priority = valueArray[1] as! Int
            self.linkArray = valueArray[2] as! [String]
        }
    }
    
    func toDict() -> NSMutableDictionary{
        var dict: NSMutableDictionary
        dict = [self.name : [self.name, self.priority, /*self.creationDate, self.dueDate, */self.linkArray]]
        return dict
    }

}
