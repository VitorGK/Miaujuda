import SwiftUI

struct ContentView: View {
    @State var pickerSelectedItem: Int = 0
    
    @State private var isPresented: Bool = false
    @State private var isButtonPressed: Bool = false
    
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
                    
                    VStack {
                        PostCard(title: "fdsgs", organization: "gdfg", items: [PostItem(name: "item", quantity: "2 sacos")], status: "active", timeStamp: Date(), type: "donation", localization: "São Paulo - SP")
                        
                        PostCard(title: "fdsgs", organization: "gdfg", items: [PostItem(name: "item", quantity: "2 sacos")], status: "inactive", timeStamp: Date(), type: "necessity", localization: "Totilandia")
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
