import SwiftUI

struct ProfileView: View {
    @AppStorage("avatar") var avatar: Int = 0
    @AppStorage("userID") var userID: String = ""
    
    @State var user: User? = nil
    
    
    let profileImages: [String] = [
        "profileCat1",
        "profilePug",
        "profileDog",
        "profileCat2"
    ]
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
//                Button{
//                    print("Edit button was tapped")
//                } label: {
//                    Image(systemName: "pencil.circle")
//                } .padding()
//                
            }
        
            Image(profileImages[avatar])
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 20)
    
            
            Text(user?.organizationName ?? "")
                .font(.title.bold())
            Text(user?.organizationCategory ?? "")
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
                
            
            VStack (alignment: .leading){
                if let email = user?.email, !email.isEmpty {
                    Label("\(email)", systemImage: "envelope.fill")
                }
                if let phone = user?.phone, !phone.isEmpty {
                    Label("\(phone)", systemImage: "phone.fill")
                }
                if let website = user?.website, !website.isEmpty {
                    Label("\(website)", systemImage: "link")
                }
            }
            
 
            
        } .padding(.bottom, 20)
            .background(Color .backgroundPost)
            .cornerRadius(20)
            .shadow(radius: 4)
            .padding()
            .navigationTitle("Perfil")
            .onAppear {
                ServerService.shared.getUser(by: userID) { result in
                    DispatchQueue.main.async {
                        switch result{
                        case .success(let user):
                            self.user = user
                        case .failure(let error):
                            return
                            //fatalError()
                            //TODO: TIRAR O FATAL ERROR
                        }
                    }


                }
            }
        List {
            NavigationLink(destination: MyPostsView()){
                Text ("Minhas Postagens")
            }
            
            Button{
                print("Edit button was tapped")
            } label: {
                Text("Sair").foregroundColor(Color.red)
            }
        }
    } 
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
