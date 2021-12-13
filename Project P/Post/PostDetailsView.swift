import SwiftUI

struct PostDetailsView: View {
    var post: PetPost
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment:.leading){
                Text(post.createdAt,style: .date)
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
                
                ItemCard(itemName: post.item.name, quantity: post.item.quantity, category: post.item.category, expDate: post.item.expirationDate ?? Date())
                Text("Contatos")
                    .font(.title2.bold())
                    .padding(.top)
                
                HStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.black)
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading){
                        Text(post.userID.organizationName)
                        Text(post.userID.organizationCategory)
                        Text(post.userID.organizationZipCode)
                    }
                    
                }
                .padding(.bottom)
                
//                HStack{
//                    // TODO: for each de 0 a 2 para cada tipo de contato
//                    Image(systemName:"envelope.fill")
//                    Link("View Our Terms of Service",
//                         destination: URL(string: "https://www.example.com/TOS.html")!)
//                }
                VStack (alignment: .leading){
                    if let email = post.userID.email {
                        Label("\(email)", systemImage: "envelope.fill")
                    }
                    
                    if let phone = post.userID.phone {
                        Label("\(phone)", systemImage: "phone.fill")
                    }
                    
                    if let website = post.userID.website {
                        Label("\(website)", systemImage: "link")
                    }
                }
            }
            .padding()
        } .navigationTitle(post.title)
            .navigationBarTitleDisplayMode(.large)
        //            .navigationBarItems(trailing:
        //                                    Button(action: {
        //                print("aaa")
        //            }) {
        //                Image(systemName: "ellipsis.circle").imageScale(.large)
        //            }
        //            )
            .navigationBarItems(trailing:
                                    editMenu()
            )
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

