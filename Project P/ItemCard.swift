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
    var imgName: String = ""
    
    var body: some View {
        VStack {
            Text("\(itemName)")
                .bold()
            HStack {
                VStack {
                    Text("\(quantity)")
                    Text(expDate,style: .date)
                    
                }
                //imgName = categImage(category: category)
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
            }
        }
    }
}

//func categImage(category: String) -> String {
//    var imageName: String = ""
//    if category == "food" {
//        imageName = "alimentos"
//    }
//    else if category == "med" {
//        imageName = "remedio"
//    }
//    else if category == "hyg" {
//        imageName = "higiene"
//    }
//    else if category == "other" {
//        imageName = "outros"
//    }
//
//    return imageName
//}


struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(itemName: "Ração de gato", quantity: "2 Sacos", category: "food", expDate: Date())
    }
}
