import Foundation

struct User: Codable, Hashable {
    let _id: String
    let createdAt: Date
    let appleID: String
    var avatar: Int
    var organizationName: String
    var organizationCategory: String
    var organizationZipCode: String
    var email: String?
    var phone: String?
    var website: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs._id == lhs._id
    }
    
    func print() {
        Swift.print("{")
        Swift.print("_id: \(_id)")
        Swift.print("createdAt: \(createdAt)")
        Swift.print("avatar: \(avatar)")
        Swift.print("organizationName: \(organizationName)")
        Swift.print("organizationCategory: \(organizationCategory)")
        Swift.print("organizationZipCode: \(organizationZipCode)")
        Swift.print("email: \(email ?? "null")")
        Swift.print("phone: \(phone ?? "null")")
        Swift.print("website: \(website ?? "null")")
        Swift.print("}")
    }
}
