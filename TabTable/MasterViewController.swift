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
