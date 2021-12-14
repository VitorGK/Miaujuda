//
//  CategorySearch.swift
//  Helpets
//
//  Created by Caroline Taus on 08/12/21.
//

import SwiftUI

struct CategorySearch: View {
    @ObservedObject var postViewModel: PostViewModel
    
    var category: String
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    @State var pickerSelectedItem: Int = 1
    
    init(category: String) {
        self.postViewModel = PostViewModel()
        self.category = category
    }
    
    //    var posts1: [PetPost] = [
    //        PetPost(_id: "fdsf", createdAt: Date(), userID: User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "active", type: "Necessidade", title: "titulo do post", description: "miaumiau", item: Item(name: "name item", quantity: "qtd item", category: "Remédios")),
    //        PetPost(_id: "fdsf", createdAt: Date(), userID: User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "inactive", type: "Doação", title: "titulo do post2", description: "miaumiau", item: Item(name: "outro item", quantity: "qtd item", category: "Alimentos"))
    //    ]
    
    //TODO: Exibir os posts filtrados para cada categoria
    var body: some View {
        ScrollView {
            VStack{
                Picker(selection: $pickerSelectedItem, label: Text("Picker"), content: {
                    Text("Necessidades").tag(1)
                    Text("Doações").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                if pickerSelectedItem == 1 {
                    PostsGrid(posts: filterPosts(category: "\(category)", posts: postViewModel.posts, type: "Necessidade"))
                } else {
                    PostsGrid(posts: filterPosts(category: "\(category)", posts: postViewModel.posts, type: "Doação"))
                }
            }
            .navigationTitle("\(category)")
            .padding()
        }
    }
    
    func filterPosts(category: String, posts: [PetPost], type: String) -> [PetPost] {
        var filteredPosts: [PetPost] = []
        filteredPosts = posts.filter { $0.itemCategory == "\(category)" && $0.type == "\(type)" }
        return filteredPosts
    }
}

struct CategorySearch_Previews: PreviewProvider {
    static var previews: some View {
        CategorySearch(category: "Alimentos")
    }
}
