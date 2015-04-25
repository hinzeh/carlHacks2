//
//  Entity.swift
//  TabTable
//
//  Created by Emily Balczewski on 4/25/15.
//  Copyright (c) 2015 ebal. All rights reserved.
//

import Foundation
import CoreData

class TableData: NSManagedObject {

    @NSManaged var createDate: NSDate
    @NSManaged var dueDate: NSDate
    @NSManaged var linkList: AnyObject
    @NSManaged var name: String
    @NSManaged var priority: NSNumber
    @NSManaged var folder: TableDataFolder

}
