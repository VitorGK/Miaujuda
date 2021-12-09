import SwiftUI



struct PostDetailsView: View {
    var post: PetPost
    var item: Item = Item(_id: "1", name: "itemnome", quantity: "qtd", category: "food", expirationDate: Date())
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment:.leading){
                Text(post.createdAt,style: .date)
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom)
                Text(post.description)
                Text("Itens")
                    .font(.title2.bold())
                    .padding(.top)
                ItemCard(itemName: item.name, quantity: item.quantity, category: item.category, expDate: item.expirationDate!)
                Text("Contatos")
                    .font(.title2.bold())
                    .padding(.top)
                
                HStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.black)
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading){
                        Text(post.userID.organizationName) // pegar nome do userID referente
                        Text(post.userID.organizationCategory) // pegar categoria do userID referente
                    }
                    
                }
                .padding(.bottom)
                HStack{
                    // TODO: for each de 0 a 2 para cada tipo de contato
                    Image(systemName:"envelope.fill")
                    Link("View Our Terms of Service",
                         destination: URL(string: "https://www.example.com/TOS.html")!)
                }
            }
            .padding()
        } .navigationTitle(post.title)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing:
                                    Button(action: {
                print("Oiii")
            }) {
                Image(systemName: "ellipsis.circle").imageScale(.large)
            }
            )
    }
}

//struct PostDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailsView(post: PetPost(_id: "id", createdAt: Date(), userID: "userID", status: "status", type: "type", title: "title", description: "descrp", item: Item(_id: "1", name: "itemnome", quantity: "qtd", category: "food", expirationDate: Date())))
//    }
//}

