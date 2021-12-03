//
//  OrgCategoryView.swift
//  Project P
//
//  Created by Caroline Taus on 02/12/21.
//

import SwiftUI
struct OrgCategoryView: View {

    let categories = ["ONG", "Protetor Independente", "Loja", "Fornecedor"]
    @State var selectedCategory: String? = nil

    var body: some View {
        List {
            ForEach(categories, id: \.self) { item in
                OrgSelectionCell(category: item, selectedCategory: self.$selectedCategory)
            }
        }
        .navigationTitle("Categoria")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OrgSelectionCell: View {

    let category: String
    @Binding var selectedCategory: String?

    var body: some View {
        HStack {
            Text(category)
            Spacer()
            if category == selectedCategory {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .background(Color.white)
        .onTapGesture {
                self.selectedCategory = self.category
            }
    }
}



struct OrgCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrgCategoryView()
    }
}
