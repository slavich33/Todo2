//
//  Category+CoreDataProperties.swift
//  Todoey
//
//  Created by Slava on 10.04.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var product: NSSet?

}

// MARK: Generated accessors for product
extension Category {

    @objc(addProductObject:)
    @NSManaged public func addToProduct(_ value: Item)

    @objc(removeProductObject:)
    @NSManaged public func removeFromProduct(_ value: Item)

    @objc(addProduct:)
    @NSManaged public func addToProduct(_ values: NSSet)

    @objc(removeProduct:)
    @NSManaged public func removeFromProduct(_ values: NSSet)

}

extension Category : Identifiable {

}
