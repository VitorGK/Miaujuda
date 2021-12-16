import SwiftUI

struct PostCard: View {
    var petPost: PetPost
    
    @State var user: User?
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(self.petPost.title)
                        .bold()
                    
                    Text(self.user?.organizationName ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if self.petPost.status == PetPostStatus.active.rawValue {
                    Image(systemName: "clock.fill")
                } else {
                    Image(systemName: "checkmark.circle.fill")
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill((self.petPost.status == "Active") ? Color.activePostYellow : Color.concludedPostGray)
            )
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("\(self.petPost.itemName) - \(self.petPost.itemQuantity)")
                    .padding(.leading)
                
                HStack {
                    Spacer()
                    
                    Text(self.user?.organizationZipCode ?? "")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.trailing)
                
                HStack {
                    Spacer()
                    
                    Text("Postado em: \(DateFormat().formatDate(ISODate: self.petPost.createdAt))")
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
        .onAppear {
            ServerService.shared.getUserByID(self.petPost.userID) { result in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let user):
                            self.user = user
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard(title: "Preciso de ração", organization: "ong miau miau", items: [PostItem(name: "ração", quantity: "2 sacos"), PostItem(name: "ração gatitos", quantity: "4.8 Kg")], status: "active", timeStamp: Date(), type: "Doação", localization: "São Paulo - SP")
//    }
//}
