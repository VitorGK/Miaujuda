//
//  FormProfileRegView.swift
//  Project P
//
//  Created by Caroline Taus on 02/12/21.
//

import SwiftUI

struct FormProfileRegView: View {
    @State var orgName: String = ""
    var body: some View {
        VStack {
            Text("Complete seu perfil")
                .font(.title .bold())
            Form {
                Section(header: Text("Escolha seu avatar")) {
                    HStack {
                        Button {
                            print("sdfiudsi")
                        } label: {
                            Image("profileCat1")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .scaledToFill()
                        }

                        
                        Spacer()
                        Image("profilePug")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .scaledToFill()
                        Spacer()
                        Image("profileDog")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .scaledToFill()
                        Spacer()
                        Image("profileCat2")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .scaledToFill()
                        
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                Section(header: Text("Adicione informações da organização")){
                    NavigationLink(destination: OrgCategoryView()) {
                        Text("Categoria")
                    }
                    TextField("Nome da organização", text: $orgName)
                }
                
                Section(header: Text("Adicione pelo menos um contato")) {
                    
                    
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
