import Foundation

struct PetPost: Codable, Hashable {
    let __v: Int?
    let _id: String
    let createdAt: String
    let userID: String
    var status: String
    var type: String
    var title: String
    var description: String
    var itemName: String
    var itemQuantity: String
    var itemCategory: String
    var itemExpirationDate: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
    
    static func == (lhs: PetPost, rhs: PetPost) -> Bool {
        return lhs._id == rhs._id
    }
}
