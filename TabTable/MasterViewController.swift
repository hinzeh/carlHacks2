//
//  MasterViewController.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {
    var table = [TableItemDoc]()
    var allToDoItems = [ToDoItemObj]()
    
    @IBAction func tableAction(sender: AnyObject) {
        var flags = NSEvent.modifierFlags()
        if(flags == .ShiftKeyMask){
            //do something to get url from table item
            NSWorkspace.sharedWorkspace().openURL(NSURL(string: "http://www.google.com")!)
        }
        if (sender.clickedRow==self.table.count){
            //last item
        }else{
            //other items
        }
        println("Table Stuff \(sender.clickedRow)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.saveData()
        // Do view setup here.
    }
    
    func setupSampleTable() {
        let item1 = TableItemDoc(title: "http://www.moodle.com")
        let item2 = TableItemDoc(title: "ThisShouldBeTooLongToCompletelyFitOnTheTableView,ButWeWillSee")
        let item3 = TableItemDoc(title: "Hi3")
        let item4 = TableItemDoc(title: "Hi4")
        let item5 = TableItemDoc(title: "Hi5")
        let item6 = TableItemDoc(title: "Hi6")
        table = [item1, item2,item3,item4,item5,item6]
    }
    
    func loadData() {
        
        self.allToDoItems = []
        
        // Getting path to ToDoItems.plist
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! String
        let path = documentsDirectory.stringByAppendingPathComponent("data.plist")
        
        let fileManager = NSFileManager.defaultManager()
        
        if let bundlePath = NSBundle.mainBundle().pathForResource("ToDoItems", ofType: "plist") {
            
            let result1Dictionary = NSMutableDictionary(contentsOfFile: bundlePath)
            println("Bundle ToDoItems.plist file is --> \(result1Dictionary?.description)")
        }
        
        // Check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("ToDoItems", ofType: "plist") {
                
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                println("Bundle ToDoItems.plist file is --> \(resultDictionary?.description)")
                
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("copy")
                
            } else {
                println("ToDoItems.plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            println("ToDoItems.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Loaded data.plist file is --> \(resultDictionary?.description)")
        
        var dictArray = resultDictionary?.objectForKey("allToDoItems") as! NSArray
        for item in dictArray {
            allToDoItems.append(ToDoItemObj(dict: item as! NSMutableDictionary))
        }
        
    }
    
    func saveData() {
        
        //        var obj = ToDoItemObj(name: "Hi", priority: 1, linkArray: ["hi", "bye", "hi"])
        //        var obj2 = ToDoItemObj(name: "Hi2", priority: 2, linkArray: ["hi2", "bye2", "hi2"])
        //
        //        allToDoItems.append(obj)
        //        allToDoItems.append(obj2)
        //
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("data.plist")
        var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        
        //saving values
        var allItemDictArray = [NSMutableDictionary]()
        for item in self.allToDoItems {
            allItemDictArray.append(item.toDict())
        }
        
        dict = ["allToDoItems" : allItemDictArray]
        
        dict.writeToFile(path, atomically: false)
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Saved data.plist file is --> \(resultDictionary?.description)")
        //var unwrappedResultDict = ToDoItemObj(dict: resultDictionary!)
    }

    
    
}

// MARK: - NSTableViewDataSource
extension MasterViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.table.count+1
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 1
//        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        if (row != self.table.count){
            var cellView = TableViewCell(frame: NSRect(x: 0, y: 0, width: tableColumn!.width, height: 50),doc: self.table[row])
            if tableColumn!.identifier == "TableColumn" {
                // 3
                let tableDoc = self.table[row]
                return cellView
            }
        }
        return AddTableViewCell(frame: NSRect(x: 0, y: 0, width: tableColumn!.width, height: 50),parent: self)
    }
}

// MARK: - NSTableViewDelegate
extension MasterViewController: NSTableViewDelegate {
}

extension MasterViewController: DragViewDelegate{
    func receiveDragged(object: AnyObject) {
        println(object)
        if (object is String || object is NSString){
            table.append(TableItemDoc(title: object as! String))
        }else{
            table.append(TableItemDoc(title: (object as! NSURL).absoluteString!))
        }
        
    }
}
