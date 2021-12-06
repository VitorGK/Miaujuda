import SwiftUI

struct ContentView: View {
    @State var search: String = ""
    @State var pickerSelectedItem: Int = 0
    @State var showingSheet = false
    
    let categoriesTitle: [String] = [
        "Alimentos",
        "Remédios",
        "Higiene",
        "Outros"
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
                            CategoryItem(imageName: "heart.fill", text: categoriesTitle[item])
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
                    Button(action: {
                    }) {
                        NavigationLink(destination: SignInIView()) {
                            Image(systemName:"plus")
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
                }
                .padding(.leading)
                .padding(.trailing)
                Spacer()
            }
            .navigationTitle("Mantimentos")
            // TODO: Add profile button
            .navigationBarTitleDisplayMode(.large)
           .navigationBarItems(trailing:
                                Button(action: {
               showingSheet.toggle()
           }, label: {
               Image(systemName: "ellipsis.circle").imageScale(.large)
           })  .sheet(isPresented: $showingSheet) {SignInIView()}

    )
 
            .searchable(text: $search)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
