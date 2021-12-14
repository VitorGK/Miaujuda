import SwiftUI

struct PostDetailsView: View {
    var post: PetPost
    @ObservedObject var userViewModel = UserInfos()
    
    init(post: PetPost) {
        self.post = post
        userViewModel.getUserFromPost(post: post)
        
    }
    
    
    var body: some View {
        if (userViewModel.errorMessage == nil){
        ScrollView(.vertical) {
            VStack(alignment:.leading){
                Text(String(post.createdAt))
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom)
                
                Text(post.description)
                    .padding(.bottom)
                
                HStack{
                    Text("Tipo:")
                        .font(.title2.bold())
                        .padding(.trailing)
                    
                    Text(post.type)
                        .font(.title3)
                }
                
                Text("Item")
                    .font(.title2.bold())
                    .padding(.top)
                
                ItemCard(itemName: post.itemName, itemQuantity: post.itemQuantity, itemCategory: post.itemCategory, itemExpirationDate: post.itemExpirationDate)
                
                Text("Contatos")
                    .font(.title2.bold())
                    .padding(.top)
                
                HStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.black)
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading){
                        Text(userViewModel.user?.organizationName ?? "hghfg")
                        Text(userViewModel.user?.organizationCategory ?? "")
                        Text(userViewModel.user?.organizationZipCode ?? "")
                    }
                }
                .padding(.bottom)

//                VStack (alignment: .leading){
//                    if let email = post.userID.email {
//                        Label("\(email)", systemImage: "envelope.fill")
//                    }
//                    if let phone = post.userID.phone {
//                        Label("\(phone)", systemImage: "phone.fill")
//                    }
//                    if let website = post.userID.website {
//                        Label("\(website)", systemImage: "link")
//                    }
//                }
            }
            .padding()
        }
        .navigationTitle(post.title)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(trailing: editMenu())
        }
        else {
            Text(userViewModel.errorMessage!)
        }
        }
}

struct editMenu: View {
    var body: some View {
        Menu {
            Button(action: concluir) {
                Label("Concluir post", systemImage: "checkmark")
            }
            Button(role: .destructive, action: deletar) {
                Label("Deletar post", systemImage: "trash.fill")
            }
        } label: {
            Label("", systemImage: "ellipsis.circle")
        }
    }
    
    func concluir(){
        print("post concluido")
    }
    
    func deletar(){
        print("deletado")
    }
}

//struct PostDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailsView(post: PetPost(_id: "id", createdAt: Date(), userID: "userID", status: "status", type: "type", title: "title", description: "descrp", item: Item(_id: "1", name: "itemnome", quantity: "qtd", category: "food", expirationDate: Date())))
//    }
//}
