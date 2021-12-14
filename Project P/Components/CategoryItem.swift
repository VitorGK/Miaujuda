import SwiftUI

struct CategoryItem: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            ZStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
            }
            .shadow(radius: 1)
            
            Text(text)
                .font(.caption)
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(imageName: "remedio", text: "Alimentos")
    }
}
