import SwiftUI

struct PostsGrid: View {
    @State var posts: [PetPost]
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<posts.count, id: \.self) { p in
                NavigationLink {
                    PostDetailsView(petPost: posts[p])
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
