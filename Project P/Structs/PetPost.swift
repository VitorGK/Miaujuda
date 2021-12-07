import Foundation

struct PetPost: Codable, Hashable {
    let _id: String
    let createdAt: Date
    let userID: User
    var status: String
    var type: String
    var title: String
    var description: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
    
    static func == (lhs: PetPost, rhs: PetPost) -> Bool {
        return lhs._id == lhs._id
    }
    
    func print() {
        Swift.print("{")
        Swift.print("_id: \(_id)")
        Swift.print("createdAt: \(createdAt)")
        Swift.print("userID: \(userID)")
        Swift.print("status: \(status)")
        Swift.print("type: \(type)")
        Swift.print("title: \(title)")
        Swift.print("description: \(description)")
        Swift.print("}")
    }
}
