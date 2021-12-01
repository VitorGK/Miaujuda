//
//  ProfileView.swift
//  Project P
//
//  Created by João Victor Ferreira Pimenta on 01/12/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack{
                        Spacer()
                        Button{
                            print("Edit button was tapped")
                        } label: {
                            Image(systemName: "pencil.circle")
                        } .padding()
                        
                    }
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.black)
                        .frame(width: 60, height: 60)
                    Text("Unidos da Taus")
                        .font(.title.bold())
                    Text("ONG")
                        .foregroundColor(.secondary)
                    ForEach([1,2,3], id: \.self ) { contact in
                        Text("\(contact)")
                    }
                } .padding(.bottom, 50).background(RoundedRectangle(cornerRadius: 20)
                                                .fill(.red)).padding()
                List {
                    NavigationLink(destination: PostDetailsView()){
                        Text ("Minhas Postagens")
                    }
                    
                    Button{
                        print("Edit button was tapped")
                    } label: {
                        Text("Sair").foregroundColor(Color.red)
                    }                }
            }
            

        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
