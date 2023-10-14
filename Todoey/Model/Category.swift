import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var dateCreated: NSDate?
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
