import SwiftUI

struct FormPostView: View {
    @AppStorage("userID") var userID: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    @State var postType: String = "Necessidade"
    @State var postTitle: String = ""
    @State var postDescription: String = ""
    @State private var showingSheet = false
    @State var itemName: String = ""
    @State var itemQuantity: String = ""
    @State var itemCategory: String = ""
    @State var itemExpirationDate: Date = Date()
    
    @ViewBuilder
    var body: some View {
        Form {
            Section(header: Text("Categoria da Postagem")) {
                Picker(selection: $postType) {
                    Text("Necessidade").tag("Necessidade")
                    
                    Text("Doação").tag("Doação")
                } label: {
                    Text("Picker")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Título da Postagem")) {
                TextField("", text: $postTitle)
            }
            
            Section(header: Text("Descrição da Postagem")) {
                TextEditor(text: $postDescription)
                    .frame(height: 100)
            }
            
            Section(header: Text("Item")) {
                TextField("Nome", text: $itemName)
                
                TextField("Quantidade", text: $itemQuantity)
                
                List {
                    NavigationLink(destination: CategoryView(selectedCategory: $itemCategory, categories: ["Alimentos", "Remédios", "Higiene", "Outros"])) {
                        HStack{
                            Text("Categoria")
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("\(itemCategory)")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if (itemCategory != "Outros" && itemCategory != "") {
                        DatePicker(
                            "Validade",
                            selection: $itemExpirationDate,
                            displayedComponents: .date
                        )
                    }
                }
            }
        }
        .navigationTitle("Nova Postagem")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let petPostData: [String: Any] = [
                        "createdAt": Date().timeIntervalSince1970,
                        "userID": userID,
                        "status": PetPostStatus.active.rawValue,
                        "type": postType,
                        "title": postTitle,
                        "description": postDescription,
                        "itemName": itemName,
                        "itemQuantity": itemQuantity,
                        "itemCategory": itemCategory,
                        "itemExpirationDate": itemExpirationDate.timeIntervalSince1970
                    ]
                    ServerService.shared.postRequest(route: .petpost, body: petPostData) { result in
                        switch result {
                            case .success(let data):
                                print("PetPost created!")
                                print(data)
                            case .failure(let error):
                                print(error.localizedDescription)
                        }
                    }
                    self.dismiss()
                } label: {
                    Text("Adicionar")
                }
            }
        }
    }
}

struct FormPostView_Previews: PreviewProvider {
    static var previews: some View {
        FormPostView()
    }
}
