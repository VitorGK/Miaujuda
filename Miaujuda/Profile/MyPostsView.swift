import SwiftUI

struct MyPostsView: View {
    @ObservedObject var postViewModel = PostViewModel()
    
    @AppStorage("userID") var userID: String = ""
    
    @State var pickerSelectedItemMyPosts: Int = 0
    @State var pickerSelectedItem: Int = 1
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Picker(selection: $pickerSelectedItem, label: Text("Picker"), content: {
                    Text("Ativas").tag(1)
                    Text("Inativas").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                if pickerSelectedItem == 1 {
                    PostsGrid(posts: filterPosts(userID: userID, posts: postViewModel.posts, status: "Active"))
                }
                else {
                    PostsGrid(posts: filterPosts(userID: userID, posts: postViewModel.posts, status: "Inactive"))
                }
            }
            .padding()
        }
        .navigationTitle("Minhas Postagens")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func filterPosts(userID: String, posts: [PetPost], status: String) -> [PetPost] {
        var filteredPosts: [PetPost] = []
        filteredPosts = posts.filter {
            $0.userID == "\(userID)" && $0.status == "\(status)"
        }
        return filteredPosts
    }
}

struct MyPostsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostsView()
    }
}
