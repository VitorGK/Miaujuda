//
//  AddItemView.swift
//  Project P
//
//  Created by Caroline Taus on 02/12/21.
//

import SwiftUI

struct AddItemView: View {
    @State var itemName: String = ""
    @State var itemQuantity: String = ""
    @State var pickerSelectedDate: Date = Date()
    
    var body: some View {
        Form {
            Section(){
                TextField("Nome do item", text: $itemName)
                TextField("Quantidade", text: $itemQuantity)
                
            }
            
            List {
                NavigationLink(destination: CategoryView(categories: ["Alimento", "Remédio", "Higiene", "Outros"])){
                    Text ("Categoria")
                        .foregroundColor(.primary)
                    
                }
            }
            
            Section() {
                
                DatePicker(
                    "Validade",
                    selection: $pickerSelectedDate,
                    displayedComponents: [.date]
                )
                
                    
                
            }
        }
        .navigationTitle("Novo item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
