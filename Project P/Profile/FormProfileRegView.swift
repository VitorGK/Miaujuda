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

/**
 Button {
     avatar = 0
     self.selected0 = true
     self.selected1 = false
     self.selected2 = false
     self.selected3 = false
 } label: {
     Image(avatar == 0 ? "selected" : "profileCat1")
         .resizable()
         .frame(width: 65, height: 65)
         .scaledToFill()
 }
 
 Spacer()
 
 Button {
     avatar = 1
     self.selected0 = false
     self.selected1 = true
     self.selected2 = false
     self.selected3 = false
 } label: {
     Image(self.selected1 == true ? "selected" : "profilePug")
         .resizable()
         .frame(width: 65, height: 65)
         .scaledToFill()
 }
 
 Spacer()
 
 Button {
     avatar = 2
     self.selected0 = false
     self.selected1 = false
     self.selected2 = true
     self.selected3 = false
 } label: {
     Image(self.selected2 == true ? "selected" : "profileDog")
         .resizable()
         .frame(width: 65, height: 65)
         .scaledToFill()
 }
 
 Spacer()
 
 Button {
     self.selected0 = false
     self.selected1 = false
     self.selected2 = false
     self.selected3 = true
     avatar = 3
 } label: {
     Image(self.selected3 == true ? "selected" : "profileCat2")
         .resizable()
         .frame(width: 65, height: 65)
         .scaledToFill()
 }
 */
