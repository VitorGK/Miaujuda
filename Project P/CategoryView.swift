//
//  OrgCategoryView.swift
//  Project P
//
//  Created by Caroline Taus on 02/12/21.
//

import SwiftUI
struct CategoryView: View {
    @Environment (\.dismiss) var dismiss
    
    var categories: [String]
    @State var selectedCategory: String? = nil
    
    var body: some View {
        List {
            ForEach(0..<categories.count) { item in
                
                Button {
                    self.selectedCategory = self.categories[item]
                    dismiss()
                } label: {
                    HStack {
                        Text(categories[item])
                            .foregroundColor(Color.primary)
                        Spacer()
                        if categories[item] == selectedCategory {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                
                
            }
        }
        .navigationTitle("Categoria")
        .navigationBarTitleDisplayMode(.inline)
    }
}





struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(categories: ["ONG", "Protetor Independente", "Loja", "Fornecedor"])
    }
}
