import SwiftUI

struct CategoryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedCategory: String
    
    var categories: [String]
    
    var body: some View {
        List {
            ForEach(0..<categories.count) { item in
                Button {
                    self.selectedCategory = self.categories[item]
                    self.dismiss()
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
        CategoryView(selectedCategory: .constant(""), categories: ["ONG", "Protetor Independente", "Loja", "Fornecedor"])
    }
}
