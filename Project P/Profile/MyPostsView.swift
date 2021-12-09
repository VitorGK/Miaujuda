import SwiftUI

struct MyPostsView: View {
    @State var pickerSelectedItemMyPosts: Int = 0
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    @State var pickerSelectedItem: Int = 1
    
    var posts2: [PetPost] = [
            PetPost(_id: "fdsf", createdAt: Date(), userID: User(_id: "5454", createdAt: Date(), avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "active", type: "Necessidade", title: "titulo do post", description: "miaumiau", item: Item(_id: "itemid", name: "name item", quantity: "qtd item", category: "Remédios")),
                                PetPost(_id: "fdsf", createdAt: Date(), userID: User(_id: "userid", createdAt: Date(), avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "inactive", type: "Doação", title: "titulo do post2", description: "miaumiau", item: Item(_id: "itemid", name: "outro item", quantity: "qtd item", category: "Alimentos"))
        ]
    
    
    func filterPosts(userID: String, posts: [PetPost], status: String) -> [PetPost] {
        var filteredPosts: [PetPost] = []
        filteredPosts = posts.filter {$0.userID._id == "\(userID)" && $0.status == "\(status)"}
        return filteredPosts
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                
                Picker(selection: $pickerSelectedItem, label: Text("Picker"), content: {
                    Text("Ativas").tag(1)
                    Text("Inativas").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                //TODO: deve verificar qual é o user no back pra ocmparar com o user id dos posts
                
                if pickerSelectedItem == 1 {
                    
                    PostsGrid(posts: filterPosts(userID: "5454", posts: posts2, status: "active"))
                }
                else {
                    PostsGrid(posts: filterPosts(userID: "5454", posts: posts2, status: "inactive"))
                }
                
                
            } .padding()
        }
        .navigationTitle("Minhas Postagens")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyPostsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostsView()
    }
}
