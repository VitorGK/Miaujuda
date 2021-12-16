import SwiftUI

struct PostsGrid: View {
    var posts: [PetPost]
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    @State var presentedPetPost: Bool = false
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<posts.count, id: \.self) { p in
                NavigationLink(isActive: $presentedPetPost) {
                    PostDetailsView(petPost: posts[p], presentedPetPost: $presentedPetPost)
                } label: {
                    EmptyView()
                }
                .hidden()
                
                Button {
                    self.presentedPetPost = true
                } label: {
                    PostCard(petPost: posts[p])
                }
                .buttonStyle(.plain)
            }
        }
    }
}

//struct PostsGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsGrid()
//    }
//}
