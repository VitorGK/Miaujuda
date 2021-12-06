//
//  ProfileView.swift
//  Project P
//
//  Created by João Victor Ferreira Pimenta on 01/12/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        VStack {
            HStack{
                Spacer()
                Button{
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "pencil.circle")
                } .padding()
                
            }
        
            Image("profileCat2")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
    
            
            Text("Unidos da Taus")
                .font(.title.bold())
            Text("ONG")
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            ForEach([1,2,3], id: \.self ) { contact in
                Text("\(contact)")
            }
        } .padding(.bottom, 50)
            .background(Color .backgroundPost)
            .cornerRadius(20)
            .shadow(radius: 4)
            .padding()
            .navigationTitle("Perfil")
        List {
            NavigationLink(destination: MyPostsView()){
                Text ("Minhas Postagens")
            }
            
            Button{
                print("Edit button was tapped")
            } label: {
                Text("Sair").foregroundColor(Color.red)
            }
            
        }
    }
    

    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
