import SwiftUI

struct FormProfileRegView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var avatar: Int = 0
    @State var organizationName: String = ""
    @State var organizationCategory: String = ""
    @State var organizationState: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var website: String = ""
    @State var selected0 = true
    @State var selected1 = false
    @State var selected2 = false
    @State var selected3 = false
    
    let avatarImages: [String] = [
        "profileCat1",
        "profilePug",
        "profileDog",
        "profileCat2"
    ]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Escolha seu avatar")) {
                    HStack {
                        ForEach(avatarImages.indices, id: \.self) { index in
                            Button {
                                avatar = index
                            } label: {
                                Image(avatarImages[index])
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .scaledToFill()
                            }
                            .overlay {
                                if avatar == index {
                                    Circle().stroke(Color.green, lineWidth: 4)
                                }
                            }.opacity(avatar == index ? 1 : 0.5)
                            
                            Spacer()
                        }
                        
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                Section(header: Text("Adicione informações da organização")) {
                    NavigationLink(destination: CategoryView(selectedCategory: $organizationCategory, categories: ["ONG", "Protetor Independente", "Loja", "Fornecedor"])) {
                        
                        HStack {
                            Text("Categoria")
                            Spacer()
                            Text("\(organizationCategory)")
                                .foregroundColor(.secondary)
                        }
                    }
                    TextField("Nome da organização", text: $organizationName)
                    NavigationLink(destination: CategoryView(selectedCategory: $organizationState, categories: ["AC", "AL", "AP", "AM", "BA", "CE", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO", "DF"])) {
                        
                        HStack {
                            Text("Estado da organização")
                            Spacer()
                            Text("\(organizationState)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Adicione pelo menos um contato")) {
                    TextField("e-mail", text: $email)
                    TextField("telefone", text: $phone)
                    TextField("website", text: $website)
                }
            }
        }
        .navigationTitle("Complete seu perfil")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let params: [String: Any] = [
                        "createdAt":Date(),
                        "avatar":avatar,
                        "organizationName":organizationName,
                        "organizationCategory":organizationCategory,
                        "organizationState":organizationState,
                        "email":email,
                        "phone":phone,
                        "website":website
                    ]
                    DataManager.shared.postRequest(route: .user, params: params) { result, error in
                        print("result")
                        print(result)
                        print("error")
                        print(error)
                        if let res: Bool = (result?.values.first as? Bool) {
                            if (res) {
                                print("User successfully created.")
                            } else {
                                print("Error.")
                            }
                        }
                    }
                    self.dismiss()
                } label: {
                    Text("Concluir")
                }
            }
        }
    }
}

struct FormProfileRegView_Previews: PreviewProvider {
    static var previews: some View {
        FormProfileRegView()
    }
}
