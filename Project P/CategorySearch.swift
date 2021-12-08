//
//  CategorySearch.swift
//  Helpets
//
//  Created by Caroline Taus on 08/12/21.
//

import SwiftUI

struct CategorySearch: View {
    @Binding var category: String
    
  //TODO: Exibir os posts filtrados para cada categoria
    var body: some View {
        ScrollView {
            VStack {
                PostCard(title: "titulo", organization: "org", items: [PostItem(name: "nomeitem", quantity: "qtditem")], status: "active", timeStamp: Date(), type: "donation", localization: "local")
            } .padding()
        } .navigationTitle("\(category)")
    }
}

struct CategorySearch_Previews: PreviewProvider {
    static var previews: some View {
        CategorySearch(category: .constant(""))
    }
}
