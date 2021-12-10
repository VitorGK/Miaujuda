import SwiftUI

struct ContentView: View {
    @State var pickerSelectedItem: Int = 1
    
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
    
    func filterPosts(type: String, posts: [PetPost]) -> [PetPost] {
            var filteredPosts: [PetPost]
            filteredPosts = posts.filter {$0.type == "\(type)"}
            return filteredPosts
        }
    
    var posts: [PetPost] = [
            PetPost(_id: "fdsf", createdAt: Date(), userID: User(_id: "userid", createdAt: Date(), avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal"), status: "active", type: "Necessidade", title: "titulo do post", description: "miaumiau", item: Item(_id: "itemid", name: "name item", quantity: "qtd item", category: "food")),
            PetPost(_id: "fdsf", createdAt: Date(), userID: User(_id: "userid", createdAt: Date(), avatar: 1, organizationName: "orgname", organizationCategory: "orgCat", organizationZipCode: "orgLocal", email: "jdshfjk"), status: "inactive", type: "Doação", title: "titulo do post2", description: "miaumiau", item: Item(_id: "itemid", name: "outro item", quantity: "qtd item", category: "food"))
        ]
    
    @State var filteredPostsNec: [PetPost] = []
    @State var filteredPostsDon: [PetPost] = []
    
    //MARK: para filtrar por categoria precisamos achar o itens que tem as categorias e os posts em que esses itens estão
    func filterPostsNecessity(category: String, posts: [PetPost]) {
        filteredPostsNec = posts.filter {$0.type == "Necessidade"}
    }
    func filterPostsDonation(category: String, posts: [PetPost]) {
        filteredPostsDon = posts.filter {$0.type == "Doação"}
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
                    Picker(selection: $pickerSelectedItem, label: Text("Picker"), content: {
                        Text("Necessidades").tag(1)
                        Text("Doações").tag(2)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if pickerSelectedItem == 1 {
                        
                        PostsGrid(posts: filterPosts(type: "Necessidade", posts: posts))
                    }
                    else {
                        PostsGrid(posts: filterPosts(type: "Doação", posts: posts))
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
                    NavigationLink(destination: FormProfileRegView()) {
                        Image("signOut")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 41, height: 41)
                    }

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
