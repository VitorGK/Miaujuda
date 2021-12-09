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
    
    var posts: [PetPost] = [
        PetPost(_id: "", createdAt: Date(), userID: "", status: "", type: "donation", title: "toti", description: "ljksdfklsd", item: Item(_id: "iditem", name: "itemName", quantity: "qtdItem", category: "Alimentos")),
        PetPost(_id: "", createdAt: Date(), userID: "", status: "", type: "necessity", title: "gfdgdf", description: "ljksdfklsd", item: Item(_id: "iditem2", name: "itemName2", quantity: "qtdItem2", category: "Food"))
    ]
    @State var filteredPosts: [PetPost] = []
    
    
    func filterPosts(category: String, posts: [PetPost]) {
        filteredPosts = posts.filter {$0.item.category == "\(category)"}
    }
    
    //TODO: Exibir os posts filtrados para cada categoria
    var body: some View {
        
        
        ScrollView {
            VStack{
                
                
                LazyVGrid(columns: columns, spacing: 10) {
                    
                    
                    ForEach(0..<filteredPosts.count, id: \.self) { p in
                        
                        
                        
                        NavigationLink {
                            PostDetailsView(post: filteredPosts[p])
                        } label: { //TODO: os atributos organizaçao, localizacao são do usuario
                            PostCard(title: filteredPosts[p].title, organization: filteredPosts[p].userID, items: [PostItem(name: "item", quantity: "2 sacos")], status: filteredPosts[p].status, timeStamp: filteredPosts[p].createdAt, type: filteredPosts[p].type, localization: filteredPosts[p].userID)
                            
                        }.buttonStyle(.plain)
                        
                    }
                    
                    
                    
                } .navigationTitle("\(category)")
                
                
            }
            .onAppear {
                filterPosts(category: category, posts: posts)
            }
        }
    }
}

struct CategorySearch_Previews: PreviewProvider {
    static var previews: some View {
        CategorySearch(category: .constant(""))
    }
}
