//
//  ItemCard.swift
//  Project P
//
//  Created by Caroline Taus on 06/12/21.
//

import SwiftUI

struct ItemCard: View {
    var itemName: String
    var quantity: String
    var category: String
    var expDate: Date
    @State var imgName: String = ""
    
    func categImage(category: String) {
        var imageName: String = ""
        if category == "food" {
            imageName = "alimentos"
        }
        else if category == "med" {
            imageName = "remedio"
        }
        else if category == "hyg" {
            imageName = "higiene"
        }
        else if category == "other" {
            imageName = "outros"
        }

        imgName = imageName
    }
    
    
    var body: some View {
        
        VStack {
            Text("\(itemName)")
                .bold()
            HStack {
                VStack {
                    Text("\(quantity)")
                    Text(expDate,style: .date)
                    
                }
                .onAppear {
                    categImage(category: category)
                }
                
                Image(imgName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
            }
        }
    }
}

   




struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(itemName: "Ração de gato", quantity: "2 Sacos", category: "food", expDate: Date())
    }
}
