//
//  Item+CoreDataProperties.swift
//  Todoey
//
//  Created by Slava on 10.04.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var done: Bool

}

extension Item : Identifiable {

}
