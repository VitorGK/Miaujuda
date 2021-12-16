import SwiftUI

struct ItemCard: View {
    var itemName: String
    var itemQuantity: String
    var itemCategory: String
    var itemExpirationDate: String?
    
    var body: some View {
        VStack (alignment: .leading){
            Text("\(itemName)")
                .font(.title3)
                .bold()
            
            HStack {
                VStack (alignment: .leading) {
                    Text("\(itemQuantity)")
                    
                    if let itemExpirationDate = self.itemExpirationDate {
                        Text(itemExpirationDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Image(itemCategory)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .trailing)
                    .scaledToFit()
                    .cornerRadius(7)
            }
        }
        .padding()
        .background(Color.backgroundPost)
        .cornerRadius(15)
        .shadow(radius: 1)
    }
}

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(itemName: "Ração de gato", itemQuantity: "2 Sacos", itemCategory: ItemCategory.food.rawValue)
    }
}
