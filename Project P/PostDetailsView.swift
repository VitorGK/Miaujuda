//
//  PostDetailsView.swift
//  Project P
//
//  Created by Juliana Santana on 01/12/21.
//

import SwiftUI

struct PostDetailsView: View {
    var body: some View {
        NavigationView{
            ScrollView(.vertical) {
                VStack(alignment:.leading){
                    Text("Ração para gatos")
                        .font(.title)
                        .bold()
                    Text("20/04/2021 às 13h30")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .padding(.bottom)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non sem a ex blandit rutrum a et mauris. Vivamus elementum, tellus vel tristique varius, felis urna pulvinar dui, non eleifend ante sem in neque.")
                    Text("Itens")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    Text("Contatos")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                       
                    HStack{
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading){
                            Text("Unidos da Taus")
                            Text("ONG")
                        }
                
                    }
                    .padding(.bottom)
                    HStack{
                        Image(systemName:"envelope.fill")
                        Link("View Our Terms of Service",
                              destination: URL(string: "https://www.example.com/TOS.html")!)
                    }

                    
                        
                }
                .padding()
            }
        }
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsView()
    }
}
