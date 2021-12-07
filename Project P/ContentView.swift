import SwiftUI

struct ContentView: View {
    @State var search: String = ""
    @State var pickerSelectedItem: Int = 0
    
    @State private var isPresented: Bool = false
    @State private var isButtonPressed: Bool = false
    let columns = [
            GridItem(.adaptive(minimum: 180))
        ]
    
    let categoriesTitle: [String] = [
        "Alimentos",
        "Remédios",
        "Higiene",
        "Outros"
    ]
    
    let categoriesImage: [String] = [
        "alimentos",
        "remedio",
        "higiene",
        "outros"
    ]
    
    let posts: [PostCard] = [PostCard(title: "Título", organization: "Org", items: [PostItem(name: "Nome do item", quantity: "Quantidade do item")], status: "active", timeStamp: Date(), type: "donation", localization: "Local"), PostCard(title: "Título2", organization: "Org2", items: [PostItem(name: "Nome do item2", quantity: "Quantidade do item2")], status: "inactive", timeStamp: Date(), type: "necessity", localization: "Local2")]
    
    let item: [ItemCard] = [ItemCard(itemName: "Nome do itemcard", quantity: "qtd", category: "food", expDate: Date()), ItemCard(itemName: "Nome do itemcard2", quantity: "qtd2", category: "rem", expDate: Date())]

    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                Text("Categorias")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 25)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.fixed(0))], spacing: 20) {
                        ForEach(0...3, id: \.self) { item in
                            CategoryItem(imageName: categoriesImage[item], text: categoriesTitle[item])
                        }
                    }
                    .frame(height: 86)
                    .padding(.leading)
                }
                HStack {
                    Text("Postagens")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZStack {
                        NavigationLink(destination: FormProfileRegView(), isActive: $isButtonPressed) {
                            EmptyView()
                        }.hidden()
                        
                        Button(action: {
                            self.isPresented = true
                        }, label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                        })
                        
                        .sheet(isPresented: $isPresented, onDismiss: {
                            self.isPresented = false
                        }) {
                            SignInWithAppleView(isButtonPressed: self.$isButtonPressed)
                        }
                    }
                }
                .padding()
                VStack {
                    Picker("Status", selection: $pickerSelectedItem) {
                        Text("Necessidades").tag(0)
                        Text("Doações").tag(1)
                    }
                    .pickerStyle(.segmented)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        NavigationLink {
                            PostDetailsView(postItems: [ItemCard(itemName: "Ração de gatos", quantity: "2 sacos", category: "food", expDate: Date())])
                        } label: {
                            PostCard(title: "fdsgs", organization: "gdfg", items: [PostItem(name: "item", quantity: "2 sacos")], status: "active", timeStamp: Date(), type: "donation", localization: "São Paulo - SP")

                        }.buttonStyle(.plain)

                    }
                    
                }
                
                .padding(.leading)
                .padding(.trailing)
                Spacer()
            }
            .navigationTitle("Mantimentos")
            // TODO: Add profile button
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image("signOut")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 41, height: 41)
                    }
                }
            }
            .searchable(text: $search)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
