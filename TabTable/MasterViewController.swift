//
//  MasterViewController.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController{
    var allToDoItems = [ToDoItemObj]()
    
    
    @IBOutlet weak var tableView: NSTableView!
    @IBAction func tableAction(sender: AnyObject) {
        var flags = NSEvent.modifierFlags()
        
        if(flags == .ShiftKeyMask ){
            //do something to get url from table item
            var currentLink = allToDoItems[sender.clickedRow].name
            NSWorkspace.sharedWorkspace().openURL(NSURL(string: currentLink)!)
        }
        if (sender.clickedRow==self.allToDoItems.count){
            //last item
        }
        else{
            //other items
        }
        println("Table Stuff \(sender.clickedRow)")
    }
    
    
    override func keyDown(theEvent: NSEvent) {
        self.interpretKeyEvents([theEvent])
        var chars : String = theEvent.characters!
        if(theEvent.keyCode == 51){
            println("Delete")
            var rows = tableView.selectedRowIndexes
            var toDelete : NSMutableArray = []
            
            var offset = 0
            var stop = allToDoItems.count
            for item in rows{
                if item>=stop{
                    continue
                }
                var temp : Int = item
                allToDoItems.removeAtIndex(temp-offset)
                offset+=1
            }
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        tableView.allowsMultipleSelection = true
        tableView.doubleAction = Selector ("doubleClicked")
        // Do view setup here.
    }
    
    func doubleClicked(){
        // edit stuff on double click
        println("double")
        
        
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
//            println("Bundle ToDoItems.plist file is --> \(result1Dictionary?.description)")
        }
        
        // Check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("ToDoItems", ofType: "plist") {
                
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
//                println("Bundle ToDoItems.plist file is --> \(resultDictionary?.description)")
                
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
//                println("copy")
                
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
        return self.allToDoItems.count+1
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 1
        //        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        if (row != self.allToDoItems.count){
            var rowAllToDo: ToDoItemObj=self.allToDoItems[row]
                var cellView = TableViewCell(tableColumnWidth: tableColumn!.width, doc: self.allToDoItems[row], newDelegate: self)
            if tableColumn!.identifier == "TableColumn" {
                // 3
                let tableDoc = self.allToDoItems[row]
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
            var newItem = ToDoItemObj.init()
            newItem.name = object as! String
            newItem.loadString(object as! String)
            allToDoItems.append(newItem)
        }else{
            var newItem = ToDoItemObj.init()
            newItem.name = (object as! NSURL).absoluteString!
            newItem.loadURL(object as! NSURL)
            allToDoItems.append(newItem)
        }
        tableView.reloadData()
        self.saveData()
    }
}

extension MasterViewController: TableViewCellDelegate{
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat{
        var heightVar: CGFloat = 50.0
        if(row<self.allToDoItems.count){
            var rowItem=self.allToDoItems[row]
            if(self.allToDoItems[row].boolExpanded){
                heightVar=CGFloat(rowItem.linkArray.count) * 30.0 + 50.0
            }
            
        }
        return heightVar
    }
    
    func deleteTableViewCell(object: AnyObject){
        println("I am in deleteTableView")
        var index = find(allToDoItems, object as! ToDoItemObj)
        self.allToDoItems.removeAtIndex(index!)
        self.saveData()
        tableView.reloadData()
        
    }
    func refreshTableViewCell(object: AnyObject){
        println("I am in refreshTableView")
        //var index = find(allToDoItems, object as! ToDoItemObj)
        //self.allToDoItems.removeAtIndex(index!)
        //self.saveData()
        tableView.reloadData()
        
    }

    }

