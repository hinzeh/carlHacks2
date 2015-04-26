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
    var priority: String
    //var creationDate: NSDate
    //var dueDate: NSDate
    var linkArray: [String]
    var boolExpanded: Bool
    
    override init() {
        self.name = String()
        self.priority = String()
        //self.creationDate = NSDate()
        //self.dueDate = NSDate()
        self.linkArray = [String]()
        self.boolExpanded=false

    }
    
    init(name: String, priority: String, /*creationDate: NSDate, dueDate: NSDate,*/ linkArray: [String]) {
        self.name = name
        self.priority = priority
        //self.creationDate = creationDate
        //self.dueDate = dueDate
        self.linkArray = linkArray
        self.boolExpanded=false

    }
    
    init(dict: NSMutableDictionary) {
        
        var keys = dict.allKeys
        
        self.name = ""
        self.priority = ""
        self.linkArray = []
        self.boolExpanded=false
        for key in keys{
            self.name = key as! String
            var valueArray = dict[self.name] as! NSArray
            self.priority = valueArray[1] as! String
            self.linkArray = valueArray[2] as! [String]
        }
    }
    
    func toDict() -> NSMutableDictionary{
        var dict: NSMutableDictionary
        dict = [self.name : [self.name, self.priority, /*self.creationDate, self.dueDate, */self.linkArray]]
        return dict
    }
    
    func loadURL(path: NSURL){
        var temp = path.path!.lastPathComponent
        self.name = temp
    }
    
    func loadString(path: String){
        var urlPath = NSURL(string: path)
        println(urlPath!.absoluteURL)
        var htmlString = NSString(contentsOfURL: urlPath!, encoding: NSUTF8StringEncoding, error: nil)
        var titleSearchString = "(<title>)(.*?)(</title>)"
        let titleRegex : NSRegularExpression = NSRegularExpression(pattern: titleSearchString, options:.DotMatchesLineSeparators, error: nil)!
        var titleMatches = titleRegex.matchesInString(htmlString as! String, options: nil, range: NSMakeRange(0, htmlString!.length))
        for item in titleMatches{
            var titleRange = item.range
            titleRange.location = titleRange.location+7
            titleRange.length = titleRange.length-15
            self.name = htmlString!.substringWithRange(titleRange)
        }
        println(htmlString)
    }
}
