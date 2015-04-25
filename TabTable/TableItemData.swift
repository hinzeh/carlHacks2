//
//  TableItemData.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Cocoa

class TableItemData: NSObject {
    var title: String
    
    override init() {
        self.title = String()
    }
    
    init(title: String) {
        self.title = title
    }

}
