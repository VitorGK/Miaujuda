import SwiftUI

struct MainView: View {
    @AppStorage("avatar") var avatar: Int = 0
    @AppStorage("userID") var userID: String = ""
    
    @ObservedObject var userFetcher = UserFetcher()
    
    @ObservedObject var postViewModel = PostViewModel(postFilter: TypePostFilter())
    
    
    @State private var isPresented: Bool = false
    @State private var isButtonPressed: Bool = false
    
    @State var isProfileTapped: Bool = false
    
    let categoriesTitle: [String] = [
        "Alimentos",
        "Remédios",
        "Higiene",
        "Outros"
    ]
    let profileImages: [String] = [
        "profileCat1",
        "profilePug",
        "profileDog",
        "profileCat2"
    ]
    
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
                                CategorySearch(postViewModel: PostViewModel(postFilter: TypeAndCategoryPostFilter(category: categoriesTitle[item])), category: categoriesTitle[item])
                            } label: {
                                CategoryItem(imageName: categoriesTitle[item], text: categoriesTitle[item])
                            }
                            .buttonStyle(.plain)
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
                    
                    if userID != "" {
                        ZStack {
                            NavigationLink {
                                FormPostView()
                            } label: {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                            }
                        }
                    } else {
                        ZStack {
                            Button {
                                self.isPresented = true
                                self.isProfileTapped = false
                            } label: {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                            }
                        }
                        .sheet(isPresented: $isPresented, onDismiss: {
                            self.isPresented = false
                        }) {
                            SignInWithAppleView(isPresented: self.$isPresented, isButtonPressed: self.$isButtonPressed)
                        }
                    }
                }
                .padding()
                
                VStack {
                    
                    Picker(selection: $postViewModel.pickerSelectedItem, label: Text("Picker"), content: {
                        Text("Necessidades").tag(1)
                        Text("Doações").tag(2)
                    })
                        .pickerStyle(SegmentedPickerStyle())
                    
                    PostsGrid(posts: postViewModel.filteredPosts)
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
                    if userID != "" {
                        ZStack {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                Image(avatar > -1 ? profileImages[avatar] : "signOut")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 41, height: 41)
                            }
                        }
                    }
                    else {
                        ZStack {
                            NavigationLink(isActive: $isButtonPressed) {
                                if isProfileTapped {
                                    ProfileView()
                                } else {
                                    FormPostView()
                                }
                            } label: {
                                EmptyView()
                            }
                            .hidden()
                            
                            Button {
                                self.isPresented = true
                                self.isProfileTapped = true
                            } label: {
                                Image("signOut")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 41, height: 41)
                            }
                        }
                        .sheet(isPresented: $isPresented, onDismiss: {
                            self.isPresented = false
                        }) {
                            SignInWithAppleView(isPresented: self.$isPresented, isButtonPressed: self.$isButtonPressed)
                        }
                    }
                }
            }
        }
    }
    
    func filterPosts(type: String, posts: [PetPost]) -> [PetPost] {
        var filteredPosts: [PetPost]
        filteredPosts = posts.filter {$0.type == "\(type)"}
        return filteredPosts
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
