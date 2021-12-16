import SwiftUI

struct MainClip: View {
    @AppStorage("avatar") var avatar: Int = 0
    @AppStorage("userID") var userID: String = ""
    
    @ObservedObject var postViewModel = PostViewModel(postFilter: TypePostFilter())
    
    let categoriesTitle: [String] = [
        "Alimentos",
        "Remédios",
        "Higiene",
        "Outros"
    ]
    let profileImages: [String] = [
        "profileCat1",
        "profilePug",
        "profileDog",
        "profileCat2"
    ]
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    Picker(selection: $postViewModel.pickerSelectedItem, label: Text("Picker"), content: {
                        Text("Necessidades").tag(1)
                        Text("Doações").tag(2)
                    })
                        .pickerStyle(SegmentedPickerStyle())
                    
                    PostsGrid(posts: postViewModel.filteredPosts)
                }
                .padding(.leading)
                .padding(.trailing)
                
                Spacer()
            }
            .navigationTitle("Postagens")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func filterPosts(type: String, posts: [PetPost]) -> [PetPost] {
        var filteredPosts: [PetPost]
        filteredPosts = posts.filter {$0.type == "\(type)"}
        return filteredPosts
    }
}

struct MainClip_Previews: PreviewProvider {
    static var previews: some View {
        MainClip()
    }
}
