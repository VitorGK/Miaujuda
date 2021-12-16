import Foundation

struct User: Codable, Hashable {
    let __v: Int?
    let _id: String?
    let createdAt: String
    let appleID: String
    var avatar: Int
    var organizationName: String
    var organizationCategory: String
    var organizationZipCode: String
    var email: String
    var phone: String
    var website: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(appleID)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.appleID == rhs.appleID
    }
}
