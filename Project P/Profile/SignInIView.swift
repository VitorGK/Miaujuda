//
//  SignInIView.swift
//  Project P
//
//  Created by Juliana Santana on 01/12/21.
//

import SwiftUI
import AuthenticationServices

struct SignInIView: View {
    var body: some View {
    

        VStack {
            Text("Bem Vindo!")
                .font(.title)
                .bold()
                .padding(.bottom)
            Text("Para fazer sua postagem você deve preencher um cadastro. \n\n Todas as informações cadastradas serão públicas para todos os usuários do aplicativo.")
            
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                    case .success(let authResults):
                        print("Authorisation successful")
                default:
                    print("bchdbcd")
                }
            }
            // black button
            .frame(width: 280, height: 60, alignment: .center)
            .signInWithAppleButtonStyle(.black)
            .padding(.bottom)
            .padding(.top)

        
            Image("signInCat")
                .resizable()
                .frame(width: 180, height: 220)
                .scaledToFill()
        }
        .padding(.trailing)
        .padding(.leading)
    
    }
}

struct SignInIView_Previews: PreviewProvider {
    static var previews: some View {
        SignInIView()
    }
}

