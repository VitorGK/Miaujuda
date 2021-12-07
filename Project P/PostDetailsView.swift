import SwiftUI

struct PostDetailsView: View {
    var postItems: [ItemCard]
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment:.leading){
                Text("20/04/2021 às 13h30")
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non sem a ex blandit rutrum a et mauris. Vivamus elementum, tellus vel tristique varius, felis urna pulvinar dui, non eleifend ante sem in neque.")
                Text("Itens")
                    .font(.title2.bold())
                    .padding(.top)
                ItemCard(itemName: "Ração", quantity: "2 sacos", category: "food", expDate: Date())
                Text("Contatos")
                    .font(.title2.bold())
                    .padding(.top)
                
                HStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.black)
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading){
                        Text("Unidos da Taus")
                        Text("ONG")
                    }
                    
                }
                .padding(.bottom)
                HStack{
                    Image(systemName:"envelope.fill")
                    Link("View Our Terms of Service",
                         destination: URL(string: "https://www.example.com/TOS.html")!)
                }
            }
            .padding()
        } .navigationTitle("Ração para gatos")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing:
                                    Button(action: {
                print("Oiii")
            }) {
                Image(systemName: "ellipsis.circle").imageScale(.large)
            }
            )
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsView(postItems: [ItemCard(itemName: "Ração", quantity: "2 sacos", category: "food", expDate: Date())])
    }
}

