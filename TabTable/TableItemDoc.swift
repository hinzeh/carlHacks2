//
//  TableItemDoc.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa

class TableItemDoc: NSObject {
    var data: TableItemData
    
    override init() {
        self.data = TableItemData()
    }
    
    init(title: String) {
        self.data = TableItemData(title: title)
    }
}
