import SwiftUI

struct MainClip: View {
    @AppStorage("avatar") var avatar: Int = 0
    @AppStorage("userID") var userID: String = ""
    
   // @ObservedObject var postViewModel: PostViewModel

    @State var pickerSelectedItem: Int = 1
    
//    init() {
//        postViewModel = PostViewModel(filterType: .byType(type: <#T##String#>))
//    }
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                
                VStack {
                    Picker(selection: $pickerSelectedItem, label: Text("Picker"), content: {
                        Text("Necessidades").tag(1)
                        Text("Doações").tag(2)
                    })
                        .pickerStyle(SegmentedPickerStyle())
                    
//                    if pickerSelectedItem == 1 {
//                        PostsGrid(posts: filterPosts(type: "Necessidade", posts: postViewModel.posts))
//                    } else {
//                        PostsGrid(posts: filterPosts(type: "Doação", posts: postViewModel.posts))
//                    }
                }
                .padding(.leading)
                .padding(.trailing)
                
                Spacer()
            }
            .navigationTitle("Postagens")
            // TODO: Add profile button
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func filterPosts(type: String, posts: [PetPost]) -> [PetPost] {
        var filteredPosts: [PetPost]
        filteredPosts = posts.filter {$0.type == "\(type)"}
        return filteredPosts
    }
}

//struct MainClip_Previews: PreviewProvider {
//    static var previews: some View {
//        MainClip()
//    }
//}
