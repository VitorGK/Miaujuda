import SwiftUI

struct CategoryItem: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.red)
                    .frame(width: 60, height: 60)
                Image(systemName: imageName)
            }
            Text(text)
                .font(.caption)
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(imageName: "heart.fill", text: "Alimentos")
    }
}
