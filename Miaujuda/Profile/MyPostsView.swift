import SwiftUI

struct MyPostsView: View {
    @ObservedObject var postViewModel = PostViewModel(postFilter: UserAndStatusPostFilter())
    
    //@AppStorage("userID") var userID: String = ""
    
    @State var pickerSelectedItemMyPosts: Int = 0
    @State var pickerSelectedItem: Int = 1
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Picker(selection: $postViewModel.pickerSelectedItem, label: Text("Picker"), content: {
                    Text("Ativas").tag(1)
                    Text("Concluídas").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                PostsGrid(posts: postViewModel.filteredPosts)
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
