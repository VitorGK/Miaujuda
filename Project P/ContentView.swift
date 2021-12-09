import SwiftUI

struct ContentView: View {
    @State var pickerSelectedItem: Int = 0
    
    @State private var isPresented: Bool = false
    @State private var isButtonPressed: Bool = false
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    @State var categoriesTitle: [String] = [
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
    
    var posts: [PetPost] = [
        PetPost(_id: "", createdAt: Date(), userID: "", status: "", type: "donation", title: "toti", description: "ljksdfklsd", item: Item(_id: "1", name: "itemnome", quantity: "qtd", category: "food", expirationDate: Date())),
        PetPost(_id: "", createdAt: Date(), userID: "", status: "", type: "necessity", title: "gfdgdf", description: "ljksdfklsd", item: Item(_id: "1", name: "itemnome", quantity: "qtd", category: "food", expirationDate: Date()))
    ]
    
    @State var filteredPostsNec: [PetPost] = []
    @State var filteredPostsDon: [PetPost] = []
    
    //MARK: para filtrar por categoria precisamos achar o itens que tem as categorias e os posts em que esses itens estão
    func filterPostsNecessity(category: String, posts: [PetPost]) {
        filteredPostsNec = posts.filter {$0.type == "Necessity"}
    }
    func filterPostsDonation(category: String, posts: [PetPost]) {
        filteredPostsDon = posts.filter {$0.type == "Donation"}
    }
    
    @ViewBuilder
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
                            NavigationLink {
                                CategorySearch(category: $categoriesTitle[item])
                            } label: {
                                CategoryItem(imageName: categoriesImage[item], text: categoriesTitle[item])
                            }.buttonStyle(.plain)
                            
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
                    
                    if pickerSelectedItem == 0 {
                        
                        filteredPostsNec()
                        LazyVGrid(columns: columns, spacing: 10) {
                            
                            ForEach(0..<filteredPostsNec.count, id: \.self) { p in
                                
                                NavigationLink {
                                    PostDetailsView(post: posts.filter {filteredPostsNec[p])
                                    } label: { //TODO: os atributos organizaçao, localizacao são do usuario
                                        PostCard(title: filteredPostsNec[p].title, organization: filteredPostsNec[p].userID, items: [PostItem(name: "item", quantity: "2 sacos")], status: filteredPostsNec[p].status, timeStamp: filteredPostsNec[p].createdAt, type: filteredPostsNec[p].type, localization: filteredPostsNec[p].userID)
                                        
                                    }.buttonStyle(.plain)
                                                    
                                                    }
                                                    
                                                    
                                                    }
                                                    }
                                                    else {
                                        
                                        filteredPostsDon()
                                        LazyVGrid(columns: columns, spacing: 10) {
                                            
                                            ForEach(0..<filteredPostsDon.count, id: \.self) { p in
                                                
                                                NavigationLink {
                                                    PostDetailsView(post: filteredPostsDon[p])
                                                } label: { //TODO: os atributos organizaçao, localizacao são do usuario
                                                    PostCard(title: filteredPostsDon[p].title, organization: filteredPostsDon[p].userID, items: [PostItem(name: "item", quantity: "2 sacos")], status: filteredPostsDon.status, timeStamp: filteredPostsDon[p].createdAt, type: filteredPostsDon.type, localization: filteredPostsDon[p].userID)
                                                    
                                                }.buttonStyle(.plain)
                                                
                                            }
                                            
                                            
                                        }
                                        
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
                                            NavigationLink(destination: FormPostView()) {
                                                Image("signOut")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 41, height: 41)
                                            }
                                            //                    Button {
                                            //
                                            //
                                            //                    } label: {
                                            //                        Image("signOut")
                                            //                            .resizable()
                                            //                            .scaledToFit()
                                            //                            .frame(width: 41, height: 41)
                                            //                    }
                                        }
                                    }
                                                    }
                                                    }
                                                    }
                                                    
                                                    struct ContentView_Previews: PreviewProvider {
                                        static var previews: some View {
                                            ContentView()
                                        }
                                    }
                                                    
