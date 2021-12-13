import SwiftUI

struct ItemCard: View {
    var itemName: String
    var quantity: String
    var category: String
    var expDate: String?
    
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
        VStack (alignment: .leading){
            Text("\(itemName)")
                .font(.title3)
                .bold()
            HStack {
                VStack (alignment: .leading) {
                    Text("\(quantity)")
                    if let expDate = expDate {
                        Text(String(expDate))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .onAppear {
                    categImage(category: category)
                }
                Spacer()
                Image(imgName)
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

//struct ItemCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemCard(itemName: "Ração de gato", quantity: "2 Sacos", category: "food", expDate: Date())
//    }
//}
