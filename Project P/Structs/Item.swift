import Foundation

struct Item: Codable, Hashable {
    let _id: String
    //let postID: PetPost
    var name: String
    var quantity: String
    var category: String
    var expirationDate: Date?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs._id == rhs._id
    }
    
    func print() {
        Swift.print("{")
        Swift.print("_id: \(_id)")
        //Swift.print("postID: \(postID)")
        Swift.print("name: \(name)")
        Swift.print("quantity: \(quantity)")
        Swift.print("category: \(category)")
        if let expirationDate = expirationDate {
            Swift.print("expirationDate: \(expirationDate)")
        } else {
            Swift.print("expirationDate: null")
        }
        Swift.print("}")
    }
}
