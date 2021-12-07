import SwiftUI

struct AddItemView: View {
    @State var itemName: String = ""
    @State var itemQuantity: String = ""
    @State var itemCategory: String = ""
    @State var pickerSelectedDate: Date = Date()
    
    var body: some View {
        Form {
            Section(){
                TextField("Nome do item", text: $itemName)
                TextField("Quantidade", text: $itemQuantity)
            }
            List {
                NavigationLink(destination: CategoryView(selectedCategory: $itemCategory, categories: ["Alimento", "Remédio", "Higiene", "Outros"])) {
                    HStack {
                        Text ("Categoria")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(itemCategory)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            Section() {
                DatePicker(
                    "Validade",
                    selection: $pickerSelectedDate,
                    displayedComponents: [.date]
                )
            }
        }
        .navigationTitle("Novo item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
