import SwiftUI

struct PostItem {
    var name: String
    var quantity: String
}

struct PostCard: View {
    var title: String
    var organization: String
    var item: PostItem
    var status: String
    var timeStamp: Date
    var type: String
    var localization: String
    
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
                if status == "active" { // status = ativo
                    Image(systemName: "clock.fill")
                }
                
                else { // status = inativo
                    Image(systemName: "checkmark.circle.fill")
                }
                
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 0)
                            .fill((status == "active") ? Color.activePostYellow : Color.concludedPostGray))
            
            VStack (alignment: .leading) {
                
                Text("\(item.name) - \(item.quantity)" )
                .padding(.leading)
                
                HStack{
                    Spacer()
                    Text("\(localization)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.trailing)
                
                HStack{
                    Spacer()
                    Text(timeStamp, style: .date)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.trailing)
                
                
            }
            
        }
        .padding(.bottom)
        
        .background(Color.backgroundPost)
        .cornerRadius(15)
        .shadow(radius: 4)
        
    }
}
//

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard(title: "Preciso de ração", organization: "ong miau miau", items: [PostItem(name: "ração", quantity: "2 sacos"), PostItem(name: "ração gatitos", quantity: "4.8 Kg")], status: "active", timeStamp: Date(), type: "donation", localization: "São Paulo - SP")
//    }
//}
