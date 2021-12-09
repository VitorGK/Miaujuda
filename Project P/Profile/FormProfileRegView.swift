import SwiftUI

struct FormProfileRegView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var avatar: Int = 0
    @State var organizationName: String = ""
    @State var organizationCategory: String = ""
    @State var organizationZipCode: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var website: String = ""
    
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
                        Button {
                            avatar = 0
                        } label: {
                            Image("profileCat1")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
                        }
                        
                        Spacer()
                        
                        Button {
                            avatar = 1
                        } label: {
                            Image("profilePug")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
                        }
                        
                        Spacer()
                        
                        Button {
                            avatar = 2
                        } label: {
                            Image("profileDog")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
                        }
                        
                        Spacer()
                        
                        Button {
                            avatar = 3
                        } label: {
                            Image("profileCat2")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
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
                    TextField("CEP da organização", text: $organizationZipCode)
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
                        "organizationZipCode":organizationZipCode,
                        "email":email,
                        "phone":phone,
                        "website":website
                    ]
                    ServerService.shared.postRequest(route: .user, params: params) { result, error in
                        print("result")
                        print(result!)
                        print("error")
                        print(error!)
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
