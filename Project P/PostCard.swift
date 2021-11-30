import SwiftUI

struct PostItem {
    var name: String
    var quantity: String
}

struct PostCard: View {
    var title: String
    var organization: String
    var items: [PostItem]
    var status: Int
    var timeStamp: Date
    
    var body: some View {
        VStack {
            
        }
    }
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard()
    }
}
