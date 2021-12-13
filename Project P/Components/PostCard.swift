import SwiftUI

struct PostItem {
    var name: String
    var quantity: String
}

struct PostCard: View {
    var post: PetPost
    //    var title: String
    //    var organization: String
    //    var item: PostItem
    //    var status: String
    //    var timeStamp: Date
    //    var type: String
    //    var localization: String
    
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack {
                VStack {
                    Text(post.title)
                        .bold()
                    Text("post.userID.organizationName")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                if post.status == "Active" { // status = ativo
                    Image(systemName: "clock.fill")
                } else { // status = inativo
                    Image(systemName: "checkmark.circle.fill")
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 0)
                            .fill((post.status == "Active") ? Color.activePostYellow : Color.concludedPostGray))
            
            VStack (alignment: .leading) {
                Text("\(post.itemName) - \(post.itemQuantity)")
                    .padding(.leading)
                
                HStack{
                    Spacer()
                    Text("post.userID.organizationZipCode")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.trailing)
                
                HStack{
                    Spacer()
                    Text(String(post.createdAt))
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.trailing)
            }
            
        }
        .padding(.bottom)
        .background(Color.backgroundPost)
        .cornerRadius(15)
        .shadow(radius: 4)
        
    }
}

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard(title: "Preciso de ração", organization: "ong miau miau", items: [PostItem(name: "ração", quantity: "2 sacos"), PostItem(name: "ração gatitos", quantity: "4.8 Kg")], status: "active", timeStamp: Date(), type: "Doação", localization: "São Paulo - SP")
//    }
//}
