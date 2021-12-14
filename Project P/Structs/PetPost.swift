struct PetPost: Codable, Hashable {
    let __v: Int
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
    
    func print() {
            Swift.print("{")
            Swift.print("\t_id: \(_id)")
            Swift.print("\tcreatedAt: \(createdAt)")
            Swift.print("\tuserID: \(userID)")
            Swift.print("\tstatus: \(status)")
            Swift.print("\ttype: \(type)")
            Swift.print("\ttitle: \(title)")
            Swift.print("\tdescription: \(description)")
            Swift.print("\titemName: \(itemName)")
            Swift.print("\titemQuantity: \(itemQuantity)")
            Swift.print("\titemCategory: \(itemCategory)")
            Swift.print("\titemExpirationDate: \(itemExpirationDate)")
            Swift.print("}")
        }
    }
