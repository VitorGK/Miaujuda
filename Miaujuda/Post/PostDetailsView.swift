import SwiftUI

struct PostDetailsView: View {
    var petPost: PetPost
    
    @State var user: User?
    @AppStorage("userID") var userID: String = ""
    
    let avatarImages: [String] = [
        "profileCat1",
        "profilePug",
        "profileDog",
        "profileCat2"
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment:.leading){
                Text(self.petPost.createdAt)
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom)
                
                Text(self.petPost.description)
                    .padding(.bottom)
                
                HStack{
                    Text("Tipo:")
                        .font(.title2.bold())
                        .padding(.trailing)
                    
                    Text(self.petPost.type)
                        .font(.title3)
                }
                
                Text("Item")
                    .font(.title2.bold())
                    .padding(.top)
                
                ItemCard(itemName: self.petPost.itemName, itemQuantity: self.petPost.itemQuantity, itemCategory: self.petPost.itemCategory, itemExpirationDate: self.petPost.itemExpirationDate)
                
                Text("Contatos")
                    .font(.title2.bold())
                    .padding(.top)
                
                HStack{
                    if let img = self.user?.avatar {
                        Image(avatarImages[img])
                            .resizable()
                            .frame(width: 60, height: 60)
                    } else {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                            .frame(width: 60, height: 60)
                    }
                    
                    VStack(alignment: .leading){
                        Text(self.user?.organizationName ?? "")
                        Text(self.user?.organizationCategory ?? "")
                        Text(self.user?.organizationZipCode ?? "")
                    }
                }
                .padding(.bottom)
                
                VStack (alignment: .leading){
                    if let email = self.user?.email ?? "", !email.isEmpty {
                        Label("\(email)", systemImage: "envelope.fill")
                    }
                    if let phone = self.user?.phone ?? "", !phone.isEmpty {
                        Label("\(phone)", systemImage: "phone.fill")
                    }
                    if let website = self.user?.website ?? "", !website.isEmpty {
                        Label("\(website)", systemImage: "link")
                    }
                }
            }
            .padding()
        }
        .navigationTitle(self.petPost.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if (self.petPost.userID == userID) {
                    EditMenu(petPostID: self.petPost._id)
                }
                
            }
        }
        .onAppear {
            ServerService.shared.getUserByID(self.petPost.userID) { result in
                DispatchQueue.main.async {
                    switch result{
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

struct EditMenu: View {
    var petPostID: String
    
    var body: some View {
        Menu {
            Button {
                concluir()
            } label: {
                Label("Concluir post", systemImage: "checkmark")
            }
            Button(role: .destructive) {
                deletar()
            } label: {
                Label("Deletar post", systemImage: "trash.fill")
            }
        } label: {
            Label("", systemImage: "ellipsis.circle")
        }
    }
    
    func concluir() {
        ServerService.shared.updatePetPostStatus(id: self.petPostID, status: .concluded) { result in
            switch result {
                case .success(let petPost):
                    print("PetPost with ID '\(petPostID)' is concluded!")
                    print(petPost)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func deletar() {
        print("deletado")
    }
}

//struct PostDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailsView(post: PetPost(_id: "id", createdAt: Date(), userID: "userID", status: "status", type: "type", title: "title", description: "descrp", item: Item(_id: "1", name: "itemnome", quantity: "qtd", category: "food", expirationDate: Date())))
//    }
//}
