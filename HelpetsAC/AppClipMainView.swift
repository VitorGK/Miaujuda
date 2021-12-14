import SwiftUI

struct AppClipMainView: View {
    @State var pickerSelectedItem: Int = 1
    var postsAppClips: [PetPost] = [
        PetPost(_id: "fdsf", createdAt: Date(), userID: User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "active", type: "Necessidade", title: "titulo do post", description: "miaumiau", item: Item(name: "name item", quantity: "qtd item", category: "Remédios")),
        PetPost(_id: "fdsf", createdAt: Date(), userID: User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "inactive", type: "Doação", title: "titulo do post2", description: "miaumiau", item: Item(name: "outro item", quantity: "qtd item", category: "Alimentos"))
    ]
    
    func filterPosts(type: String, posts: [PetPost]) -> [PetPost] {
        var filteredPosts: [PetPost] = []
        filteredPosts = posts.filter {$0.type == "\(type)"}
        return filteredPosts
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker(selection: $pickerSelectedItem, label: Text("Picker"), content: {
                        Text("Necessidades").tag(1)
                        Text("Doações").tag(2)
                    })
                        .pickerStyle(SegmentedPickerStyle())
                    
                    if pickerSelectedItem == 1 {
                        
                        PostsGrid(posts: filterPosts(type: "Necessidade", posts: postsAppClips))
                    }
                    else {
                        PostsGrid(posts: filterPosts(type: "Doação", posts: postsAppClips))
                    }
                } .padding()
            }.navigationTitle("Postagens")
        
            .navigationBarTitleDisplayMode(.large)
        }
    }
        
}

struct AppClipMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppClipMainView()
    }
}
