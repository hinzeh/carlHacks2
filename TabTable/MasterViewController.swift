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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func setupSampleTable() {
        let item1 = TableItemDoc(title: "hi")
        let item2 = TableItemDoc(title: "bye")
        table = [item1, item2]
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
        var cellView = TableViewCell(frame: NSRect(x: 0, y: 0, width: tableColumn!.width, height: 50), id: "Temp")
        // 2
        if tableColumn!.identifier == "TableColumn" {
            // 3
            let tableDoc = self.table[row]
            cellView.setString(tableDoc.data.title)
            return cellView
        }
        
        return cellView
    }
}

// MARK: - NSTableViewDelegate
extension MasterViewController: NSTableViewDelegate {
}
