import SwiftUI

struct FormProfileRegView: View {
    @AppStorage("jwtToken") var jwtToken: String = ""
    @AppStorage("appleID") var appleIDDefaults: String = ""
    @AppStorage("userID") var userIDDefaults: String = ""
    @AppStorage("avatar") var avatarDefaults: Int = 0
    @AppStorage("organizationName") var organizationNameDefaults: String = ""
    @AppStorage("organizationCategory") var organizationCategoryDefaults: String = ""
    @AppStorage("organizationZipCode") var organizationZipCodeDefaults: String = ""
    @AppStorage("email") var emailDefaults: String = ""
    @AppStorage("phone") var phoneDefaults: String = ""
    @AppStorage("website") var websiteDefaults: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isPresented: Bool
    @Binding var isButtonPressed: Bool
    
    @State var avatar: Int = 0
    @State var organizationName: String = ""
    @State var organizationCategory: String = ""
    @State var organizationZipCode: String = ""
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
                    NavigationLink(destination: CategoryView(selectedCategory: $organizationZipCode, categories: ["Acre", "Alagoas", "Amapá", "Amazonas", "Bahia", "Ceará", "Espírito Santo", "Goiás", "Maranhão", "Mato Grosso", "Mato Grosso do Sul", "Minas Gerais", "Pará", "Paraíba", "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro", "Rio Grande do Norte", "Rio Grande do Sul", "Rondônia", "Roraima", "Santa Catarina", "São Paulo", "Sergipe", "Tocantins", "Distrito Federal"])) {
                        
                        HStack {
                            Text("Estado da organização")
                            Spacer()
                            Text("\(organizationZipCode)")
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
                    let userData: [String: Any] = [
                        "createdAt": ISO8601DateFormatter().string(from: Date()),
                        "appleID": appleIDDefaults,
                        "avatar": avatar,
                        "organizationName": organizationName,
                        "organizationCategory": organizationCategory,
                        "organizationZipCode": organizationZipCode,
                        "email": email,
                        "phone": phone,
                        "website": website
                    ]
                    ServerService.shared.createUser(userData: userData) { result in
                        switch result {
                            case .success(let user):
                                print("User created!")
                                self.appleIDDefaults = user.appleID
                                self.userIDDefaults = user._id!
                                self.avatarDefaults = user.avatar
                                self.organizationNameDefaults = user.organizationName
                                self.organizationCategoryDefaults = user.organizationCategory
                                self.organizationZipCodeDefaults = user.organizationZipCode
                                self.emailDefaults = user.email
                                self.phoneDefaults = user.phone
                                self.websiteDefaults = user.website
                            case .failure(let error):
                                print("Error creating user.")
                                print(error.localizedDescription)
                        }
                    }
                    ServerService.shared.authenticate(appleID: self.appleIDDefaults) { result in
                        switch result {
                            case .success(let data):
                                guard let jwtToken = data["access_token"] as? String else { return }
                                self.jwtToken = jwtToken
                            case .failure(let error):
                                print(error.localizedDescription)
                        }
                    }
                    self.isPresented = false
                    self.isButtonPressed = true
                } label: {
                    Text("Concluir")
                }
            }
        }
    }
}

//struct FormProfileRegView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormProfileRegView()
//    }
//}
