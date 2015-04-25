//
//  TableDataFolder.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Foundation
import CoreData

class TableDataFolder: NSManagedObject {

    @NSManaged var tableDataArray: AnyObject
    @NSManaged var item: TableData
    @NSManaged var folder: TableDataFolder

}
