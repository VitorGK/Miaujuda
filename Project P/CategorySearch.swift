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
        PetPost(_id: "", createdAt: Date(), userID: "", status: "", type: "donation", title: "toti", description: "ljksdfklsd"),
        PetPost(_id: "", createdAt: Date(), userID: "", status: "", type: "necessity", title: "gfdgdf", description: "ljksdfklsd")
            ]
    
  //TODO: Exibir os posts filtrados para cada categoria
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {

                ForEach(0..<posts.filter {$0.category == "\(category)"}.count, id: \.self) { p in

                    NavigationLink {
                        PostDetailsView(post: posts.filter {$0.category == "\(category)"}[p])
                    } label: { //TODO: os atributos organizaçao, localizacao são do usuario
                        PostCard(title: posts.filter {$0.category == "\(category)"}[p].title, organization: posts.filter {$0.category == "\(category)"}[p].userID, items: [PostItem(name: "item", quantity: "2 sacos")], status: posts.filter {$0.category == "\(category)"}[p].status, timeStamp: posts.filter {$0.category == "\(category)"}[p].createdAt, type: posts.filter {$0.category == "\(category)"}[p].type, localization: posts.filter {$0.category == "\(category)"}[p].userID)

                    }.buttonStyle(.plain)

                }
            
            
            
        } .navigationTitle("\(category)")
    }
}

struct CategorySearch_Previews: PreviewProvider {
    static var previews: some View {
        CategorySearch(category: .constant(""))
    }
}
