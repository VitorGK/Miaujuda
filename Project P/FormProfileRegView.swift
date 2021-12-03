//
//  FormProfileRegView.swift
//  Project P
//
//  Created by Caroline Taus on 02/12/21.
//

import SwiftUI

struct FormProfileRegView: View {
    @State var orgName: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var website: String = ""
    @State var zipCode: String = ""
    @State var avatarSelected: String = ""
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Escolha seu avatar")) {
                    HStack {
                        Button {
                            print("bot 1")
                            avatarSelected = "profileCat1"
                        } label: {
                            Image("profileCat1")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
                        }

                        Spacer()
                        
                        Button {
                            print("bot 2")
                            avatarSelected = "profilePug"
                        } label: {
                            Image("profilePug")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
                        }
                    
                        Spacer()
                        
                        Button {
                            print("bot 3")
                            avatarSelected = "profileDog"
                        } label: {
                            Image("profileDog")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
                        }
                        
                        Spacer()
                        
                        Button {
                            print("bot 4")
                            avatarSelected = "profileCat2"
                        } label: {
                            Image("profileCat2")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
                        }
                        
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                Section(header: Text("Adicione informações da organização")){
                    NavigationLink(destination: CategoryView(categories: ["ONG", "Protetor Independente", "Loja", "Fornecedor"])) {
                        Text("Categoria")
                    }
                    TextField("Nome da organização", text: $orgName)
                    TextField("CEP da organização", text: $zipCode)
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
        
    }
}

struct FormProfileRegView_Previews: PreviewProvider {
    static var previews: some View {
        FormProfileRegView()
    }
}
