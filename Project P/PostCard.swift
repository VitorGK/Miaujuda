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
    var type: Int
    
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack {
                VStack {
                    Text("\(title)")
                        .bold()
                    Text("\(organization)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                if status == 0 { // status = ativo
                    Image(systemName: "clock.fill")
                    
                }
                else { // status = inativo
                    Image(systemName: "checkmark.circle.fill")
                }
                
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 0)
                            .fill((status == 0) ? Color.activePostYellow : Color.concludedPostGray))
            
            VStack (alignment: .leading) {
                ForEach(0..<items.count) { item in
                    Text("\(items[item].name) - \(items[item].quantity)" )
                } .padding(.leading)
                
                HStack{
                    Spacer()
                    //Text("postado em: \(timeStamp)")
                    Text("postado em 20/02/2020")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                }
                
                
            }
            
        }
        .padding(.bottom)
        
        .background(Color.backgroundPost)
        .cornerRadius(15)
        .shadow(radius: 4)
        
    }
}
//

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard(title: "Preciso de ração", organization: "ong miau miau", items: [PostItem(name: "ração", quantity: "2 sacos"), PostItem(name: "ração gatitos", quantity: "4.8 Kg")], status: 0, timeStamp: Date(), type: 0)
    }
}
