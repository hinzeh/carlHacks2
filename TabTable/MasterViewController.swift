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
        if (sender.clickedRow==self.table.count-1){
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
        let item1 = TableItemDoc(title: "hi")
        let item2 = TableItemDoc(title: "hi")
        let item3 = TableItemDoc(title: "hi")
        let item4 = TableItemDoc(title: "hi")
        let item5 = TableItemDoc(title: "hi")
        let item6 = TableItemDoc(title: "hi")
        let item7 = TableItemDoc(title: "bye")
        table = [item1, item2,item3,item4,item5,item6,item7]
    }
    
    
}

// MARK: - NSTableViewDataSource
extension MasterViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.table.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 1
//        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        if (row != self.table.count-1){
            var cellView = TableViewCell(frame: NSRect(x: 0, y: 0, width: tableColumn!.width, height: 50))
            if tableColumn!.identifier == "TableColumn" {
                // 3
                let tableDoc = self.table[row]
                cellView.setString(tableDoc.data.title)
                return cellView
            }
        }
        return AddTableViewCell(frame: NSRect(x: 0, y: 0, width: tableColumn!.width, height: 50))
    }
}

// MARK: - NSTableViewDelegate
extension MasterViewController: NSTableViewDelegate {
    

    
}
