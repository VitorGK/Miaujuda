//
//  CategorySearch.swift
//  Helpets
//
//  Created by Caroline Taus on 08/12/21.
//

import SwiftUI

struct CategorySearch: View {
    @Binding var category: String
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    @State var pickerSelectedItem: Int = 1
    
    var posts1: [PetPost] = [
        PetPost(_id: "fdsf", createdAt: Date(), userID: User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "active", type: "Necessidade", title: "titulo do post", description: "miaumiau", item: Item(_id: "itemid", name: "name item", quantity: "qtd item", category: "Remédios")),
        PetPost(_id: "fdsf", createdAt: Date(), userID: User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "inactive", type: "Doação", title: "titulo do post2", description: "miaumiau", item: Item(_id: "itemid", name: "outro item", quantity: "qtd item", category: "Alimentos"))
        ]
    
    
    
    func filterPosts(category: String, posts: [PetPost], type: String) -> [PetPost] {
        var filteredPosts: [PetPost] = []
        filteredPosts = posts.filter {$0.item.category == "\(category)" && $0.type == "\(type)"}
        return filteredPosts
    }
    
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
                    
                    PostsGrid(posts: filterPosts(category: "\(category)", posts: posts1, type: "Necessidade"))
                }
                else {
                    PostsGrid(posts: filterPosts(category: "\(category)", posts: posts1, type: "Doação"))
                }
                
                
            }
            .navigationTitle("\(category)")
            .padding()
        }
    }
}

struct CategorySearch_Previews: PreviewProvider {
    static var previews: some View {
        CategorySearch(category: .constant(""))
    }
}
