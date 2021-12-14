import SwiftUI

struct MyPostsView: View {
    @ObservedObject var postViewModel: PostViewModel
    
    @State var pickerSelectedItemMyPosts: Int = 0
    @State var pickerSelectedItem: Int = 1
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
//    var posts2: [PetPost] = [
//        PetPost(_id: "fdsf", createdAt: Date(), userID: User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "active", type: "Necessidade", title: "titulo do post", description: "miaumiau", item: Item(name: "name item", quantity: "qtd item", category: "Remédios")),
//        PetPost(_id: "fdsf", createdAt: Date(), userID: User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "inactive", type: "Doação", title: "titulo do post2", description: "miaumiau", item: Item(name: "outro item", quantity: "qtd item", category: "Alimentos"))
//        ]
    
    init() {
        postViewModel = PostViewModel()
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
                    PostsGrid(posts: filterPosts(userID: "5454", posts: postViewModel.posts, status: "active"))
                }
                else {
                    PostsGrid(posts: filterPosts(userID: "5454", posts: postViewModel.posts, status: "inactive"))
                }
                
                
            } .padding()
        }
        .navigationTitle("Minhas Postagens")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func filterPosts(userID: String, posts: [PetPost], status: String) -> [PetPost] {
        var filteredPosts: [PetPost] = []
        var user: User?
        ServerService.shared.getUser(by: userID) { result in
            switch result {
                case .success(let user2):
                    user = user2
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        guard let user = user else { return [] }
        filteredPosts = posts.filter {
            user.appleID == "\(userID)" && $0.status == "\(status)"
        }
        return filteredPosts
    }
}

struct MyPostsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostsView()
    }
}
